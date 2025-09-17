// Real-time Notification WebSocket Service
// Quản lý real-time notifications cho Recipe App

const { Server } = require('socket.io');
const jwt = require('jsonwebtoken');

class NotificationWebSocketService {
    constructor(httpServer) {
        this.io = new Server(httpServer, {
            cors: {
                origin: "*",
                methods: ["GET", "POST"]
            },
            transports: ['websocket', 'polling']
        });
        
        this.connectedUsers = new Map(); // userId -> socket mapping
        this.setupEventHandlers();
        
        console.log('📡 WebSocket server for notifications initialized');
    }

    setupEventHandlers() {
        this.io.on('connection', (socket) => {
            console.log(`🔌 User connected: ${socket.id}`);
            console.log(`📊 Total connections: ${this.io.sockets.sockets.size}`);

            // Handle user authentication and registration
            socket.on('authenticate', async (data) => {
                console.log('🔐 Authentication attempt received:', data);
                try {
                    const { token, userId } = data;
                    
                    if (!userId) {
                        console.log('❌ Authentication failed: No userId provided');
                        socket.emit('auth_error', { message: 'UserId is required' });
                        return;
                    }
                    
                    // Verify JWT token (optional security layer)
                    if (token) {
                        const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
                        if (decoded.userId !== userId) {
                            console.log('❌ Authentication failed: Invalid token');
                            socket.emit('auth_error', { message: 'Invalid token' });
                            return;
                        }
                    }

                    // Register user socket connection
                    this.connectedUsers.set(userId, socket);
                    socket.userId = userId;
                    
                    console.log(`✅ User ${userId} authenticated and registered for notifications`);
                    console.log(`📊 Total authenticated users: ${this.connectedUsers.size}`);
                    socket.emit('authenticated', { status: 'success', message: 'Connected to real-time notifications' });
                    
                } catch (error) {
                    console.error('❌ Authentication error:', error);
                    socket.emit('auth_error', { message: 'Authentication failed' });
                }
            });

            // Handle disconnection
            socket.on('disconnect', () => {
                if (socket.userId) {
                    this.connectedUsers.delete(socket.userId);
                    console.log(`🔌 User ${socket.userId} disconnected`);
                }
            });

            // Heartbeat to keep connection alive
            socket.on('ping', () => {
                socket.emit('pong');
            });
        });
    }

    // Broadcast new notification to specific user
    notifyUser(userId, notificationData) {
        const userSocket = this.connectedUsers.get(userId);
        if (userSocket) {
            userSocket.emit('new_notification', {
                id: notificationData.id,
                title: notificationData.title,
                body: notificationData.body,
                type: notificationData.type || 'general',
                createdAt: notificationData.createdAt || new Date(),
                isRead: false
            });
            
            console.log(`📨 Notification sent to user ${userId}: ${notificationData.title}`);
            return true;
        } else {
            console.log(`📱 User ${userId} not connected, notification will be delivered on next app open`);
            return false;
        }
    }

    // Broadcast notification to all connected users
    broadcastToAll(notificationData) {
        this.io.emit('new_notification', notificationData);
        console.log(`📢 Broadcasted notification to all users: ${notificationData.title}`);
    }

    // Broadcast notification deletion to all connected users
    broadcastNotificationDeleted(notificationId) {
        this.io.emit('notification_deleted', {
            id: notificationId,
            action: 'deleted'
        });
        console.log(`🗑️ Broadcasted notification deletion to all users: ${notificationId}`);
    }

    // Broadcast notification update to all connected users
    broadcastNotificationUpdated(notificationData) {
        this.io.emit('notification_updated', {
            id: notificationData.id,
            title: notificationData.title,
            body: notificationData.body,
            type: notificationData.type || 'general',
            isEnabled: notificationData.isEnabled,
            action: 'updated'
        });
        console.log(`✏️ Broadcasted notification update to all users: ${notificationData.title}`);
    }

    // Broadcast notification count change to all connected users
    broadcastNotificationCountChanged() {
        this.io.emit('notification_count_changed', {
            action: 'refresh_count',
            timestamp: new Date()
        });
        console.log(`🔄 Broadcasted notification count change to all users`);
    }

    // Broadcast to multiple specific users
    notifyUsers(userIds, notificationData) {
        const results = userIds.map(userId => this.notifyUser(userId, notificationData));
        const successCount = results.filter(Boolean).length;
        
        console.log(`📊 Notification sent to ${successCount}/${userIds.length} users`);
        return { total: userIds.length, delivered: successCount };
    }

    // Get connected users count
    getConnectedUsersCount() {
        return this.connectedUsers.size;
    }

    // Get list of connected user IDs
    getConnectedUserIds() {
        return Array.from(this.connectedUsers.keys());
    }
}

module.exports = NotificationWebSocketService;