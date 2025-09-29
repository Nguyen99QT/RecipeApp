const notificationModel = require("../model/notificationModel");
const userModel = require("../model/userModel");
const recipeModel = require("../model/recipeModel");

// Load notifications list page
const loadNotifications = async (req, res) => {
    try {
        const notifications = await notificationModel.find()
            .sort({ createdAt: -1 })
            .populate('readNotifications', 'username email')
            .populate('recipeId', 'name');
            
        res.render("notifications", { 
            notifications: notifications,
            title: "Notifications Management",
            message: req.flash('message'),
            error: req.flash('error')
        });
    } catch (error) {
        console.error('Error loading notifications:', error);
        req.flash('error', 'Failed to load notifications');
        res.redirect('/dashboard');
    }
};

// Load create notification page
const loadCreateNotification = async (req, res) => {
    try {
        const users = await userModel.find({}, 'username email').sort({ username: 1 });
        const recipes = await recipeModel.find({}, 'name').sort({ name: 1 });
        
        res.render("sendNotification", { 
            users: users,
            recipes: recipes,
            isEditMode: false,
            title: "Create New Notification",
            flash: {
                error: req.flash('error'),
                success: req.flash('success')
            }
        });
    } catch (error) {
        console.error('Error loading create notification page:', error);
        req.flash('error', 'Failed to load page');
        res.redirect('/notifications');
    }
};

// Load edit notification page
const loadEditNotification = async (req, res) => {
    try {
        const { id } = req.params;
        
        const notification = await notificationModel.findById(id)
            .populate('recipeId', 'name');
        
        if (!notification) {
            req.flash('error', 'Notification not found');
            return res.redirect('/notifications');
        }
        
        // Debug logging
        console.log('Edit Notification Data:', {
            id: notification._id,
            title: notification.title,
            type: notification.type,
            recipeId: notification.recipeId,
            recipeName: notification.recipeName
        });
        
        const users = await userModel.find({}, 'username email').sort({ username: 1 });
        const recipes = await recipeModel.find({}, 'name').sort({ name: 1 });
        
        console.log('Recipes available:', recipes.length);
        console.log('Selected recipe (if any):', notification.recipeId);
        
        res.render("sendNotification", { 
            notification: notification,
            editNotification: notification, // For template compatibility
            users: users,
            recipes: recipes,
            isEditMode: true,
            title: "Edit Notification",
            flash: {
                error: req.flash('error'),
                success: req.flash('success')
            }
        });
    } catch (error) {
        console.error('Error loading edit notification page:', error);
        req.flash('error', 'Failed to load notification');
        res.redirect('/notifications');
    }
};

// Create new notification
const createNotification = async (req, res) => {
    try {
        const { title, description, notification_type, targetUsers, specificUsers, date, recipe_id } = req.body;
        
        if (!title || !description) {
            req.flash('error', 'Title and message are required');
            return res.redirect('/notifications/create');
        }

        let notifications = [];
        const notificationData = {
            title: title,
            message: description, // Form uses 'description' for message
            type: notification_type || 'general',
            date: date || new Date().toISOString().split('T')[0],
            isEnabled: true,
            readNotifications: []
        };

        // Add recipe data if type is new_recipe
        if (notification_type === 'new_recipe' && recipe_id) {
            const recipe = await recipeModel.findById(recipe_id);
            if (recipe) {
                notificationData.recipeId = recipe_id;
                notificationData.recipeName = recipe.name;
            }
        }

        if (targetUsers === 'all') {
            // Send to all users
            const notification = new notificationModel(notificationData);
            await notification.save();
            notifications = [notification];
            
            // Emit to all connected users via WebSocket
            if (global.notificationWS) {
                global.notificationWS.broadcastToAll({
                    id: notification._id,
                    title: title,
                    body: description,
                    type: notification_type || 'general',
                    createdAt: notification.createdAt
                });
                
                // Also broadcast that notification count has changed
                global.notificationWS.broadcastNotificationCountChanged();
                
                console.log(`📢 Real-time notification sent to all users: ${title}`);
            }
            
        } else if (targetUsers === 'specific' && specificUsers) {
            // Send to specific users
            const userIds = Array.isArray(specificUsers) ? specificUsers : [specificUsers];
            
            for (const userId of userIds) {
                const userNotification = new notificationModel({
                    ...notificationData,
                    targetUserId: userId
                });
                await userNotification.save();
                notifications.push(userNotification);
                
                // Emit to specific user via WebSocket
                if (global.notificationWS) {
                    global.notificationWS.notifyUser(userId, {
                        id: userNotification._id,
                        title: title,
                        body: description,
                        type: notification_type || 'general',
                        createdAt: userNotification.createdAt
                    });
                }
            }
            
            console.log(`📨 Real-time notification sent to ${userIds.length} specific users: ${title}`);
        }

        req.flash('success', 
            `Notification created successfully! Sent to ${notifications.length} users.`
        );
        
        res.redirect('/notifications');

    } catch (error) {
        console.error('Error creating notification:', error);
        req.flash('error', 'Failed to create notification');
        res.redirect('/notifications/create');
    }
};

// Toggle notification status
const toggleNotification = async (req, res) => {
    try {
        const { id } = req.params;
        
        const notification = await notificationModel.findById(id);
        if (!notification) {
            req.flash('error', 'Notification not found');
            return res.redirect('/notifications');
        }
        
        notification.isEnabled = !notification.isEnabled;
        await notification.save();
        
        // Broadcast notification status update to all connected users via WebSocket
        if (global.notificationWS) {
            global.notificationWS.broadcastNotificationUpdated({
                id: notification._id,
                title: notification.title,
                body: notification.message,
                type: notification.type,
                isEnabled: notification.isEnabled
            });
            // Also broadcast that notification count has changed
            global.notificationWS.broadcastNotificationCountChanged();
            console.log(`✏️ Real-time notification status update broadcast sent for ID: ${id}`);
        }
        
        req.flash('message', 
            `Notification ${notification.isEnabled ? 'enabled' : 'disabled'} successfully`
        );
        
        res.redirect('/notifications');
        
    } catch (error) {
        console.error('Error toggling notification:', error);
        req.flash('error', 'Failed to update notification');
        res.redirect('/notifications');
    }
};

// Delete notification
const deleteNotification = async (req, res) => {
    try {
        const { id } = req.params;
        
        const notification = await notificationModel.findByIdAndDelete(id);
        if (!notification) {
            req.flash('error', 'Notification not found');
            return res.redirect('/notifications');
        }
        
        // Broadcast notification deletion to all connected users via WebSocket
        if (global.notificationWS) {
            global.notificationWS.broadcastNotificationDeleted(id);
            // Also broadcast that notification count has changed
            global.notificationWS.broadcastNotificationCountChanged();
            console.log(`🗑️ Real-time notification deletion broadcast sent for ID: ${id}`);
        }
        
        req.flash('message', 'Notification deleted successfully');
        res.redirect('/notifications');
        
    } catch (error) {
        console.error('Error deleting notification:', error);
        req.flash('error', 'Failed to delete notification');
        res.redirect('/notifications');
    }
};

// Get notification statistics (AJAX endpoint)
const getNotificationStats = async (req, res) => {
    try {
        const totalNotifications = await notificationModel.countDocuments();
        const enabledNotifications = await notificationModel.countDocuments({ isEnabled: true });
        const recentNotifications = await notificationModel.countDocuments({
            createdAt: { $gte: new Date(Date.now() - 24 * 60 * 60 * 1000) } // Last 24 hours
        });
        
        res.json({
            success: true,
            stats: {
                total: totalNotifications,
                enabled: enabledNotifications,
                recent: recentNotifications
            }
        });
        
    } catch (error) {
        console.error('Error getting notification stats:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to get statistics'
        });
    }
};

// Update notification
const updateNotification = async (req, res) => {
    try {
        const { id } = req.params;
        const { title, description, notification_type, recipe_id } = req.body;
        
        if (!title || !description) {
            req.flash('error', 'Title and message are required');
            return res.redirect(`/notifications/edit/${id}`);
        }

        const notification = await notificationModel.findById(id);
        if (!notification) {
            req.flash('error', 'Notification not found');
            return res.redirect('/notifications');
        }

        // Update basic fields
        notification.title = title;
        notification.message = description; // Form uses 'description' for message
        notification.type = notification_type || 'general';

        // Handle recipe data
        if (notification_type === 'new_recipe' && recipe_id) {
            const recipe = await recipeModel.findById(recipe_id);
            if (recipe) {
                notification.recipeId = recipe_id;
                notification.recipeName = recipe.name;
            }
        } else {
            // Clear recipe data if not new_recipe type
            notification.recipeId = undefined;
            notification.recipeName = undefined;
        }

        await notification.save();

        // Broadcast notification update via WebSocket
        if (global.notificationWS) {
            global.notificationWS.broadcastNotificationUpdated({
                id: notification._id,
                title: notification.title,
                body: notification.message,
                type: notification.type,
                recipeId: notification.recipeId,
                recipeName: notification.recipeName,
                isEnabled: notification.isEnabled
            });
            global.notificationWS.broadcastNotificationCountChanged();
            console.log(`✏️ Real-time notification update broadcast sent for ID: ${id}`);
        }

        req.flash('success', 'Notification updated successfully');
        res.redirect('/notifications');

    } catch (error) {
        console.error('Error updating notification:', error);
        req.flash('error', 'Failed to update notification');
        res.redirect(`/notifications/edit/${req.params.id}`);
    }
};

module.exports = {
    loadNotifications,
    loadCreateNotification,
    loadEditNotification,
    createNotification,
    updateNotification,
    toggleNotification,
    deleteNotification,
    getNotificationStats
};
