// Importing models
const settingModel = require("../model/settingModel");
const adminLoginModel = require("../model/adminLoginModel");
const userNotificationModel = require("../model/userNotificationModel");
const notificationModel = require("../model/notificationModel");
const recipeModel = require("../model/recipeModel");

// Importing the service function to send notification
const sendPushNotification = require("../services/sendPushNotification");

// Load view for private policy
const loadPrivatePolicy = async (req, res) => {

    try {

        // fetch private policy
        let setting = await settingModel.findOne();

        return res.render("privatePolicy", { setting });

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for terms and conditions
const loadTermsAndConditions = async (req, res) => {

    try {


        // fetch terms and conditions
        let setting = await settingModel.findOne();

        return res.render("termsConditions", { setting });

    } catch (error) {
        console.log(error.message);
    }
}

// add private policy 
const addPrivatePolicy = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request body
            const privatePolicy = req.body.privatePolicy.replace(/"/g, '&quot;');

            const setting = await settingModel.findOne();

            if (!setting) {
                // Create a new private policy  if none exists
                const newSetting = new settingModel({ privatePolicy: privatePolicy });
                await newSetting.save();

                req.flash('success', 'Private Policy added successfully....');
                return res.redirect('back');

            } else {
                // Update existing private policy 
                await settingModel.findOneAndUpdate({ _id: setting._id }, { $set: { privatePolicy: privatePolicy } });

                req.flash('success', 'Private Policy updated successfully....');
                return res.redirect('back');
            }
        }
        else {

            req.flash('error', 'You have no access to change private policy, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

// add terms and conditions
const addTermsAndConditional = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request body
            const terms_and_conditions = req.body.terms_and_conditions.replace(/"/g, '&quot;');

            const setting = await settingModel.findOne();

            if (!setting) {
                // Create a new terms and conditions if none exists
                const newSetting = new settingModel({ termsAndConditions: terms_and_conditions });
                await newSetting.save();

                req.flash('success', 'Terms and conditions added successfully....');
                return res.redirect('back');

            } else {
                // Update existing terms and conditions
                const updatedData = await settingModel.findOneAndUpdate({ _id: setting._id }, { $set: { termsAndConditions: terms_and_conditions } });

                req.flash('success', 'Terms and conditions updated successfully....');
                return res.redirect('back');
            }
        }
        else {

            req.flash('error', 'You have no access to change terms and conditions, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for send custom notification
const loadSendNotification = async (req, res) => {

    try {
        // Get all recipes for dropdown (no status filter since all should be active by default)
        const recipes = await recipeModel.find().select('_id name').sort({ createdAt: -1 });
        
        // Check if this is edit mode
        const editId = req.query.edit;
        let editNotification = null;
        
        if (editId) {
            editNotification = await notificationModel.findById(editId).populate('recipeId', 'name');
        }
        
        return res.render("sendNotification", { 
            recipes, 
            editNotification,
            isEditMode: !!editId 
        });

    } catch (error) {
        console.log(error.message);
        return res.render("sendNotification", { 
            recipes: [], 
            editNotification: null,
            isEditMode: false 
        });
    }
}

// send notification
const sendNotification = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 0) {

            req.flash('error', 'You have no access send notification, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

        // Extract data from the request body
        const title = req.body.title;
        const description = req.body.description.replace(/"/g, '&quot;');
        const notificationType = req.body.notification_type;
        const recipeId = req.body.recipe_id;

        if (!title || !description) {
            req.flash('error', 'Both title and description are required.');
            return res.redirect('back');
        }

        if (notificationType === 'new_recipe' && !recipeId) {
            req.flash('error', 'Please select a recipe for new recipe notification.');
            return res.redirect('back');
        }

        // fetch user token
        const FindTokens = await userNotificationModel.find();
        const registrationTokens = FindTokens.map(item => item.registrationToken);

        // date
        const currentDate = new Date();
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const formattedDate = currentDate.toLocaleDateString('en-US', options);

        let notificationData = {
            title: title,
            date: formattedDate,
            message: description,
            type: notificationType
        };

        // If it's a new recipe notification, add recipe details
        if (notificationType === 'new_recipe' && recipeId) {
            const recipe = await recipeModel.findById(recipeId);
            if (recipe) {
                notificationData.recipeId = recipeId;
                notificationData.recipeName = recipe.name;
            }
        }

        // save notification
        const newNotification = await notificationModel(notificationData).save();

        // Prepare notification payload for push notification
        let notificationPayload = {
            title: title,
            body: description.replace(/<[^>]*>/g, ''), // Remove HTML tags for push notification
        };

        // Add custom data for new recipe notifications
        if (notificationType === 'new_recipe' && recipeId) {
            notificationPayload.data = {
                type: 'new_recipe',
                recipeId: recipeId,
                recipeName: notificationData.recipeName
            };
        }

        // send notification
        await sendPushNotification(registrationTokens, notificationPayload.title, notificationPayload.body, notificationPayload.data || {});

        const successMessage = notificationType === 'new_recipe' 
            ? `New recipe notification sent successfully for "${notificationData.recipeName}"!`
            : 'General notification sent successfully!';
            
        req.flash('success', successMessage);
        return res.redirect(req.get("Referrer") || "/");

    } catch (error) {
        console.error("Error in sendNotification:", error.message);
        req.flash('error', 'An error occurred while sending notification.');
        return res.redirect(req.get("Referrer") || "/");
    }
}

// Load notification history page
const loadNotificationHistory = async (req, res) => {
    try {
        // Fetch all notifications with recipe details if applicable
        const notifications = await notificationModel.find()
            .populate('recipeId', 'name image') // Populate recipe details
            .sort({ createdAt: -1 }); // Sort by newest first

        return res.render("notificationHistory", { 
            notifications, 
            moment: require('moment') // For date formatting
        });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while loading notification history.');
        return res.redirect('/dashboard');
    }
}

// Update notification
const updateNotification = async (req, res) => {
    try {
        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 0) {
            req.flash('error', 'You have no access to update notification, Only admin have access to this functionality...!!');
            return res.redirect(req.get("Referrer") || "/");
        }

        const notificationId = req.body.notification_id;
        const title = req.body.title;
        const description = req.body.description.replace(/"/g, '&quot;');
        const notificationType = req.body.notification_type;
        const recipeId = req.body.recipe_id;

        if (!notificationId) {
            req.flash('error', 'Notification ID is required for update.');
            return res.redirect(req.get("Referrer") || "/");
        }

        if (!title || !description) {
            req.flash('error', 'Both title and description are required.');
            return res.redirect(req.get("Referrer") || "/");
        }

        if (notificationType === 'new_recipe' && !recipeId) {
            req.flash('error', 'Please select a recipe for new recipe notification.');
            return res.redirect(req.get("Referrer") || "/");
        }

        // Prepare update data
        const updateData = {
            title: title,
            message: description,
            type: notificationType || 'general',
            date: new Date().toISOString().split('T')[0] // Update date to current
        };

        // Add recipe info if it's a new recipe notification
        if (notificationType === 'new_recipe' && recipeId) {
            const recipe = await recipeModel.findById(recipeId);
            if (recipe) {
                updateData.recipeId = recipeId;
                updateData.recipeName = recipe.name;
            }
        } else {
            // Remove recipe info if changing to general notification
            updateData.recipeId = null;
            updateData.recipeName = null;
        }

        // Update the notification
        const updatedNotification = await notificationModel.findByIdAndUpdate(
            notificationId, 
            updateData, 
            { new: true }
        );

        if (!updatedNotification) {
            req.flash('error', 'Notification not found.');
            return res.redirect(req.get("Referrer") || "/");
        }

        const successMessage = notificationType === 'new_recipe' 
            ? `Recipe notification updated successfully for "${updateData.recipeName}"!`
            : 'General notification updated successfully!';
            
        req.flash('success', successMessage);
        return res.redirect('/notification-history');

    } catch (error) {
        console.error("Error in updateNotification:", error.message);
        req.flash('error', 'An error occurred while updating notification.');
        return res.redirect(req.get("Referrer") || "/");
    }
}

// Toggle notification status (enable/disable)
const toggleNotificationStatus = async (req, res) => {
    try {
        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 0) {
            return res.status(403).json({ 
                success: false, 
                message: 'You have no access to modify notifications. Only admin have access to this functionality.' 
            });
        }

        const notificationId = req.params.id;
        const { isEnabled } = req.body;

        // Validate notification ID
        if (!notificationId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Notification ID is required' 
            });
        }

        // Validate isEnabled value
        if (typeof isEnabled !== 'boolean') {
            return res.status(400).json({ 
                success: false, 
                message: 'Invalid status value' 
            });
        }

        // Update the notification status
        const updatedNotification = await notificationModel.findByIdAndUpdate(
            notificationId, 
            { isEnabled: isEnabled },
            { new: true }
        );

        if (!updatedNotification) {
            return res.status(404).json({ 
                success: false, 
                message: 'Notification not found' 
            });
        }

        const action = isEnabled ? 'enabled' : 'disabled';
        return res.status(200).json({ 
            success: true, 
            message: `Notification ${action} successfully`,
            notification: updatedNotification
        });

    } catch (error) {
        console.error('Error in toggleNotificationStatus:', error);
        return res.status(500).json({ 
            success: false, 
            message: 'An error occurred while updating notification status' 
        });
    }
}

// Delete notification
const deleteNotification = async (req, res) => {
    try {
        const notificationId = req.params.id;

        // Validate notification ID
        if (!notificationId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Notification ID is required' 
            });
        }

        // Find and delete the notification
        const deletedNotification = await notificationModel.findByIdAndDelete(notificationId);

        if (!deletedNotification) {
            return res.status(404).json({ 
                success: false, 
                message: 'Notification not found' 
            });
        }

        return res.status(200).json({ 
            success: true, 
            message: 'Notification deleted successfully' 
        });

    } catch (error) {
        console.error('Error in deleteNotification:', error);
        return res.status(500).json({ 
            success: false, 
            message: 'An error occurred while deleting notification' 
        });
    }
}

module.exports = {

    loadPrivatePolicy,
    addPrivatePolicy,
    loadTermsAndConditions,
    addTermsAndConditional,
    loadSendNotification,
    sendNotification,
    updateNotification,
    loadNotificationHistory,
    toggleNotificationStatus,
    deleteNotification

}