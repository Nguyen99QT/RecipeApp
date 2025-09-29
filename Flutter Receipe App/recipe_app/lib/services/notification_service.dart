import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '/flutter_flow/flutter_flow_util.dart';
import '/utils/network_utils.dart';

class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance => _instance ??= NotificationService._();
  
  NotificationService._();
  
  IO.Socket? _socket;
  bool _isConnected = false;
  String? _currentUserId;
  
  // Callback functions for real-time updates
  Function(Map<String, dynamic>)? onNewNotification;
  Function(bool)? onConnectionStatusChanged;
  
  /// Initialize and connect to WebSocket server
  Future<void> connect(String userId, {String? token}) async {
    try {
      _currentUserId = userId;
      
      // Disconnect existing connection if any
      await disconnect();
      
      print('[DEBUG] ===== NOTIFICATION SERVICE CONNECT =====');
      print('[DEBUG] NotificationService: Connecting to WebSocket...');
      print('[DEBUG] UserId: "$userId"');
      print('[DEBUG] Token available: ${token?.isNotEmpty ?? false}');
      
      // Create socket connection 
      // Use same URL as API calls for consistency
      final cachedIp = NetworkUtils.getCachedIp();
      final serverUrl = cachedIp != null 
          ? 'http://$cachedIp:3000'
          : 'http://10.0.2.2:3000'; // Fallback to emulator IP
      print('[DEBUG] NotificationService: Connecting to $serverUrl');
      print('[DEBUG] Using cached IP: $cachedIp');
      
      _socket = IO.io(
        serverUrl,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .disableAutoConnect()
            .setTimeout(10000) // Increase timeout
            .setReconnectionAttempts(10)
            .setReconnectionDelay(3000)
            .build(),
      );
      
      _setupEventHandlers();
      
      // Connect to server
      print('[DEBUG] NotificationService: Attempting connection...');
      _socket!.connect();
      
    } catch (e) {
      print('[ERROR] NotificationService connect error: $e');
    }
  }
  
  void _setupEventHandlers() {
    if (_socket == null) return;
    
    // Connection established
    _socket!.on('connect', (data) {
      print('[DEBUG] ===== WEBSOCKET CONNECTED =====');
      print('[DEBUG] NotificationService: Connected to WebSocket server');
      print('[DEBUG] Connection data: $data');
      _isConnected = true;
      onConnectionStatusChanged?.call(true);
      
      // Authenticate with server
      print('[DEBUG] Starting authentication...');
      _authenticate();
    });
    
    // Connection error
    _socket!.on('connect_error', (error) {
      print('[ERROR] ===== WEBSOCKET CONNECTION ERROR =====');
      print('[ERROR] NotificationService: Connection error - $error');
      print('[ERROR] NotificationService: Error type: ${error.runtimeType}');
      print('[ERROR] NotificationService: Error details: ${error.toString()}');
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
    });
    
    // Disconnection
    _socket!.on('disconnect', (reason) {
      print('[DEBUG] ===== WEBSOCKET DISCONNECTED =====');
      print('[DEBUG] NotificationService: Disconnected - $reason');
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
    });
    
    // Authentication response
    _socket!.on('authenticated', (data) {
      print('[DEBUG] ===== WEBSOCKET AUTHENTICATED =====');
      print('[DEBUG] NotificationService: Authenticated successfully');
      print('[DEBUG] Auth response data: $data');
    });
    
    _socket!.on('auth_error', (data) {
      print('[ERROR] NotificationService: Authentication failed - $data');
    });
    
    // New notification received
    _socket!.on('new_notification', (data) {
      print('[DEBUG] ===== WebSocket EVENT: new_notification =====');
      print('[DEBUG] NotificationService: New notification received - $data');
      print('[DEBUG] Data type: ${data.runtimeType}');
      print('[DEBUG] Data content: ${data.toString()}');
      _handleNewNotification(data);
    });
    
    // Notification deleted
    _socket!.on('notification_deleted', (data) {
      print('[DEBUG] ===== WebSocket EVENT: notification_deleted =====');
      print('[DEBUG] NotificationService: Notification deleted - $data');
      _handleNotificationDeleted(data);
    });
    
    // Notification updated/status changed
    _socket!.on('notification_updated', (data) {
      print('[DEBUG] ===== WebSocket EVENT: notification_updated =====');
      print('[DEBUG] NotificationService: Notification updated - $data');
      _handleNotificationUpdated(data);
    });
    
    // Notification count changed - refresh count
    _socket!.on('notification_count_changed', (data) {
      print('[DEBUG] ===== WebSocket EVENT: notification_count_changed =====');
      print('[DEBUG] NotificationService: Notification count changed - $data');
      _handleNotificationCountChanged(data);
    });
    
    // Heartbeat response
    _socket!.on('pong', (data) {
      print('[DEBUG] NotificationService: Heartbeat pong received');
    });
  }
  
  void _authenticate() {
    if (_socket == null || _currentUserId == null) {
      print('[ERROR] ===== AUTHENTICATION FAILED =====');
      print('[ERROR] NotificationService: Cannot authenticate - socket: ${_socket != null}, userId: $_currentUserId');
      return;
    }
    
    final authData = {
      'userId': _currentUserId,
      'userType': 'user', // Add userType for server
      // Add token if available for additional security
      // 'token': FFAppState().authToken,
    };
    
    print('[DEBUG] ===== STARTING AUTHENTICATION =====');
    print('[DEBUG] NotificationService: Authenticating with server...');
    print('[DEBUG] NotificationService: Auth data: $authData');
    _socket!.emit('authenticate', authData);
    print('[DEBUG] NotificationService: Authentication request sent');
  }
  
  void _handleNewNotification(dynamic data) {
    try {
      print('[DEBUG] ===== _handleNewNotification CALLED =====');
      print('[DEBUG] Raw notification data: $data');
      
      final notificationData = data is Map<String, dynamic> 
          ? data 
          : json.decode(data.toString()) as Map<String, dynamic>;
      
      print('[DEBUG] NotificationService: Processing new notification');
      print('[DEBUG] Parsed notification data: $notificationData');
      print('[DEBUG] Notification title: ${notificationData['title']}');
      print('[DEBUG] Notification body: ${notificationData['body']}');
      
      // Update unread count in app state
      FFAppState().unreadNotificationCount += 1;
      print('[DEBUG] Updated unread count to: ${FFAppState().unreadNotificationCount}');
      
      // Call callback if set
      print('[DEBUG] Calling onNewNotification callback...');
      onNewNotification?.call(notificationData);
      print('[DEBUG] onNewNotification callback called');
      
      // Show local notification (optional)
      _showLocalNotification(notificationData);
      print('[DEBUG] ===== _handleNewNotification FINISHED =====');
      
    } catch (e) {
      print('[ERROR] NotificationService: Error processing notification - $e');
    }
  }
  
  void _handleNotificationDeleted(dynamic data) {
    try {
      final deletionData = data is Map<String, dynamic> 
          ? data 
          : json.decode(data.toString()) as Map<String, dynamic>;
      
      print('[DEBUG] NotificationService: Processing notification deletion');
      print('[DEBUG] Deletion data: $deletionData');
      
      final notificationId = deletionData['id'];
      
      // Call callback if set to refresh notification list
      onNewNotification?.call({
        'action': 'deleted',
        'notificationId': notificationId,
        'refresh': true
      });
      
    } catch (e) {
      print('[ERROR] NotificationService: Error processing notification deletion - $e');
    }
  }
  
  void _handleNotificationUpdated(dynamic data) {
    try {
      final updateData = data is Map<String, dynamic> 
          ? data 
          : json.decode(data.toString()) as Map<String, dynamic>;
      
      print('[DEBUG] NotificationService: Processing notification update');
      print('[DEBUG] Update data: $updateData');
      
      final notificationId = updateData['id'];
      final isEnabled = updateData['isEnabled'];
      
      // Call callback if set to refresh notification list
      onNewNotification?.call({
        'action': 'updated',
        'notificationId': notificationId,
        'isEnabled': isEnabled,
        'refresh': true
      });
      
    } catch (e) {
      print('[ERROR] NotificationService: Error processing notification update - $e');
    }
  }
  
  void _handleNotificationCountChanged(dynamic data) {
    try {
      print('[DEBUG] NotificationService: Processing notification count change');
      print('[DEBUG] Count change data: $data');
      
      // Trigger a notification count refresh without polling
      onNewNotification?.call({
        'action': 'count_changed',
        'refresh_count': true
      });
      
    } catch (e) {
      print('[ERROR] NotificationService: Error processing notification count change - $e');
    }
  }
  
  void _showLocalNotification(Map<String, dynamic> notificationData) {
    // Here you can integrate with flutter_local_notifications
    // to show system notifications when app is in background
    
    final title = notificationData['title'] ?? 'New Notification';
    final body = notificationData['body'] ?? '';
    
    print('[DEBUG] NotificationService: Would show local notification - $title: $body');
    
    // TODO: Implement actual local notification
    // LocalNotificationService.show(title, body);
  }
  
  /// Send heartbeat to keep connection alive
  void sendHeartbeat() {
    if (_socket != null && _isConnected) {
      _socket!.emit('ping');
    }
  }
  
  /// Disconnect from WebSocket server
  Future<void> disconnect() async {
    if (_socket != null) {
      print('[DEBUG] NotificationService: Disconnecting from WebSocket');
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
    _isConnected = false;
    _currentUserId = null;
    onConnectionStatusChanged?.call(false);
  }
  
  /// Check connection status
  bool get isConnected => _isConnected;
  
  /// Get current user ID
  String? get currentUserId => _currentUserId;
  
  /// Manual refresh of notification count (fallback)
  Future<void> refreshNotificationCount() async {
    // This can be called as backup when WebSocket fails
    try {
      // Call existing API to get updated count
      // Implementation depends on your existing API call structure
      print('[DEBUG] NotificationService: Refreshing notification count via API');
    } catch (e) {
      print('[ERROR] NotificationService: Failed to refresh count - $e');
    }
  }
}
