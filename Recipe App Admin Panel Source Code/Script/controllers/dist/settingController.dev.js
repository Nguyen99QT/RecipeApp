"use strict";

// Importing models
var settingModel = require("../model/settingModel");

var adminLoginModel = require("../model/adminLoginModel");

var userNotificationModel = require("../model/userNotificationModel");

var notificationModel = require("../model/notificationModel");

var recipeModel = require("../model/recipeModel"); // Importing the service function to send notification


var sendPushNotification = require("../services/sendPushNotification"); // Load view for private policy


var loadPrivatePolicy = function loadPrivatePolicy(req, res) {
  var setting;
  return regeneratorRuntime.async(function loadPrivatePolicy$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(settingModel.findOne());

        case 3:
          setting = _context.sent;
          return _context.abrupt("return", res.render("privatePolicy", {
            setting: setting
          }));

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log(_context.t0.message);

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Load view for terms and conditions


var loadTermsAndConditions = function loadTermsAndConditions(req, res) {
  var setting;
  return regeneratorRuntime.async(function loadTermsAndConditions$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(settingModel.findOne());

        case 3:
          setting = _context2.sent;
          return _context2.abrupt("return", res.render("termsConditions", {
            setting: setting
          }));

        case 7:
          _context2.prev = 7;
          _context2.t0 = _context2["catch"](0);
          console.log(_context2.t0.message);

        case 10:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // add private policy 


var addPrivatePolicy = function addPrivatePolicy(req, res) {
  var loginData, privatePolicy, setting, newSetting;
  return regeneratorRuntime.async(function addPrivatePolicy$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context3.sent;

          if (!(loginData && loginData.is_admin === 1)) {
            _context3.next = 23;
            break;
          }

          // Extract data from the request body
          privatePolicy = req.body.privatePolicy.replace(/"/g, '&quot;');
          _context3.next = 8;
          return regeneratorRuntime.awrap(settingModel.findOne());

        case 8:
          setting = _context3.sent;

          if (setting) {
            _context3.next = 17;
            break;
          }

          // Create a new private policy  if none exists
          newSetting = new settingModel({
            privatePolicy: privatePolicy
          });
          _context3.next = 13;
          return regeneratorRuntime.awrap(newSetting.save());

        case 13:
          req.flash('success', 'Private Policy added successfully....');
          return _context3.abrupt("return", res.redirect('back'));

        case 17:
          _context3.next = 19;
          return regeneratorRuntime.awrap(settingModel.findOneAndUpdate({
            _id: setting._id
          }, {
            $set: {
              privatePolicy: privatePolicy
            }
          }));

        case 19:
          req.flash('success', 'Private Policy updated successfully....');
          return _context3.abrupt("return", res.redirect('back'));

        case 21:
          _context3.next = 25;
          break;

        case 23:
          req.flash('error', 'You have no access to change private policy, Only admin have access to this functionality...!!');
          return _context3.abrupt("return", res.redirect('back'));

        case 25:
          _context3.next = 30;
          break;

        case 27:
          _context3.prev = 27;
          _context3.t0 = _context3["catch"](0);
          console.log(_context3.t0.message);

        case 30:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 27]]);
}; // add terms and conditions


var addTermsAndConditional = function addTermsAndConditional(req, res) {
  var loginData, terms_and_conditions, setting, newSetting, updatedData;
  return regeneratorRuntime.async(function addTermsAndConditional$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context4.sent;

          if (!(loginData && loginData.is_admin === 1)) {
            _context4.next = 24;
            break;
          }

          // Extract data from the request body
          terms_and_conditions = req.body.terms_and_conditions.replace(/"/g, '&quot;');
          _context4.next = 8;
          return regeneratorRuntime.awrap(settingModel.findOne());

        case 8:
          setting = _context4.sent;

          if (setting) {
            _context4.next = 17;
            break;
          }

          // Create a new terms and conditions if none exists
          newSetting = new settingModel({
            termsAndConditions: terms_and_conditions
          });
          _context4.next = 13;
          return regeneratorRuntime.awrap(newSetting.save());

        case 13:
          req.flash('success', 'Terms and conditions added successfully....');
          return _context4.abrupt("return", res.redirect('back'));

        case 17:
          _context4.next = 19;
          return regeneratorRuntime.awrap(settingModel.findOneAndUpdate({
            _id: setting._id
          }, {
            $set: {
              termsAndConditions: terms_and_conditions
            }
          }));

        case 19:
          updatedData = _context4.sent;
          req.flash('success', 'Terms and conditions updated successfully....');
          return _context4.abrupt("return", res.redirect('back'));

        case 22:
          _context4.next = 26;
          break;

        case 24:
          req.flash('error', 'You have no access to change terms and conditions, Only admin have access to this functionality...!!');
          return _context4.abrupt("return", res.redirect('back'));

        case 26:
          _context4.next = 31;
          break;

        case 28:
          _context4.prev = 28;
          _context4.t0 = _context4["catch"](0);
          console.log(_context4.t0.message);

        case 31:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 28]]);
}; // Load view for send custom notification


var loadSendNotification = function loadSendNotification(req, res) {
  var recipes, editId, editNotification;
  return regeneratorRuntime.async(function loadSendNotification$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(recipeModel.find().select('_id name').sort({
            createdAt: -1
          }));

        case 3:
          recipes = _context5.sent;
          // Check if this is edit mode
          editId = req.query.edit;
          editNotification = null;

          if (!editId) {
            _context5.next = 10;
            break;
          }

          _context5.next = 9;
          return regeneratorRuntime.awrap(notificationModel.findById(editId).populate('recipeId', 'name'));

        case 9:
          editNotification = _context5.sent;

        case 10:
          return _context5.abrupt("return", res.render("sendNotification", {
            recipes: recipes,
            editNotification: editNotification,
            isEditMode: !!editId
          }));

        case 13:
          _context5.prev = 13;
          _context5.t0 = _context5["catch"](0);
          console.log(_context5.t0.message);
          return _context5.abrupt("return", res.render("sendNotification", {
            recipes: [],
            editNotification: null,
            isEditMode: false
          }));

        case 17:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 13]]);
}; // send notification


var sendNotification = function sendNotification(req, res) {
  var loginData, title, description, notificationType, recipeId, FindTokens, registrationTokens, currentDate, options, formattedDate, notificationData, recipe, newNotification, notificationPayload, successMessage;
  return regeneratorRuntime.async(function sendNotification$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context6.sent;

          if (!(loginData && loginData.is_admin === 0)) {
            _context6.next = 7;
            break;
          }

          req.flash('error', 'You have no access send notification, Only admin have access to this functionality...!!');
          return _context6.abrupt("return", res.redirect('back'));

        case 7:
          // Extract data from the request body
          title = req.body.title;
          description = req.body.description.replace(/"/g, '&quot;');
          notificationType = req.body.notification_type;
          recipeId = req.body.recipe_id;

          if (!(!title || !description)) {
            _context6.next = 14;
            break;
          }

          req.flash('error', 'Both title and description are required.');
          return _context6.abrupt("return", res.redirect('back'));

        case 14:
          if (!(notificationType === 'new_recipe' && !recipeId)) {
            _context6.next = 17;
            break;
          }

          req.flash('error', 'Please select a recipe for new recipe notification.');
          return _context6.abrupt("return", res.redirect('back'));

        case 17:
          _context6.next = 19;
          return regeneratorRuntime.awrap(userNotificationModel.find());

        case 19:
          FindTokens = _context6.sent;
          registrationTokens = FindTokens.map(function (item) {
            return item.registrationToken;
          }); // date

          currentDate = new Date();
          options = {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
          };
          formattedDate = currentDate.toLocaleDateString('en-US', options);
          notificationData = {
            title: title,
            date: formattedDate,
            message: description,
            type: notificationType
          }; // If it's a new recipe notification, add recipe details

          if (!(notificationType === 'new_recipe' && recipeId)) {
            _context6.next = 30;
            break;
          }

          _context6.next = 28;
          return regeneratorRuntime.awrap(recipeModel.findById(recipeId));

        case 28:
          recipe = _context6.sent;

          if (recipe) {
            notificationData.recipeId = recipeId;
            notificationData.recipeName = recipe.name;
          }

        case 30:
          _context6.next = 32;
          return regeneratorRuntime.awrap(notificationModel(notificationData).save());

        case 32:
          newNotification = _context6.sent;
          // Prepare notification payload for push notification
          notificationPayload = {
            title: title,
            body: description.replace(/<[^>]*>/g, '') // Remove HTML tags for push notification

          }; // Add custom data for new recipe notifications

          if (notificationType === 'new_recipe' && recipeId) {
            notificationPayload.data = {
              type: 'new_recipe',
              recipeId: recipeId,
              recipeName: notificationData.recipeName
            };
          } // send notification


          _context6.next = 37;
          return regeneratorRuntime.awrap(sendPushNotification(registrationTokens, notificationPayload.title, notificationPayload.body, notificationPayload.data || {}));

        case 37:
          successMessage = notificationType === 'new_recipe' ? "New recipe notification sent successfully for \"".concat(notificationData.recipeName, "\"!") : 'General notification sent successfully!';
          req.flash('success', successMessage);
          return _context6.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 42:
          _context6.prev = 42;
          _context6.t0 = _context6["catch"](0);
          console.error("Error in sendNotification:", _context6.t0.message);
          req.flash('error', 'An error occurred while sending notification.');
          return _context6.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 47:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 42]]);
}; // Load notification history page


var loadNotificationHistory = function loadNotificationHistory(req, res) {
  var notifications;
  return regeneratorRuntime.async(function loadNotificationHistory$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          _context7.next = 3;
          return regeneratorRuntime.awrap(notificationModel.find().populate('recipeId', 'name image') // Populate recipe details
          .sort({
            createdAt: -1
          }));

        case 3:
          notifications = _context7.sent;
          return _context7.abrupt("return", res.render("notificationHistory", {
            notifications: notifications,
            moment: require('moment') // For date formatting

          }));

        case 7:
          _context7.prev = 7;
          _context7.t0 = _context7["catch"](0);
          console.log(_context7.t0.message);
          req.flash('error', 'An error occurred while loading notification history.');
          return _context7.abrupt("return", res.redirect('/dashboard'));

        case 12:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Update notification


var updateNotification = function updateNotification(req, res) {
  var loginData, notificationId, title, description, notificationType, recipeId, updateData, recipe, updatedNotification, successMessage;
  return regeneratorRuntime.async(function updateNotification$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          _context8.prev = 0;
          _context8.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context8.sent;

          if (!(loginData && loginData.is_admin === 0)) {
            _context8.next = 7;
            break;
          }

          req.flash('error', 'You have no access to update notification, Only admin have access to this functionality...!!');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 7:
          notificationId = req.body.notification_id;
          title = req.body.title;
          description = req.body.description.replace(/"/g, '&quot;');
          notificationType = req.body.notification_type;
          recipeId = req.body.recipe_id;

          if (notificationId) {
            _context8.next = 15;
            break;
          }

          req.flash('error', 'Notification ID is required for update.');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 15:
          if (!(!title || !description)) {
            _context8.next = 18;
            break;
          }

          req.flash('error', 'Both title and description are required.');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 18:
          if (!(notificationType === 'new_recipe' && !recipeId)) {
            _context8.next = 21;
            break;
          }

          req.flash('error', 'Please select a recipe for new recipe notification.');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 21:
          // Prepare update data
          updateData = {
            title: title,
            message: description,
            type: notificationType || 'general',
            date: new Date().toISOString().split('T')[0] // Update date to current

          }; // Add recipe info if it's a new recipe notification

          if (!(notificationType === 'new_recipe' && recipeId)) {
            _context8.next = 29;
            break;
          }

          _context8.next = 25;
          return regeneratorRuntime.awrap(recipeModel.findById(recipeId));

        case 25:
          recipe = _context8.sent;

          if (recipe) {
            updateData.recipeId = recipeId;
            updateData.recipeName = recipe.name;
          }

          _context8.next = 31;
          break;

        case 29:
          // Remove recipe info if changing to general notification
          updateData.recipeId = null;
          updateData.recipeName = null;

        case 31:
          _context8.next = 33;
          return regeneratorRuntime.awrap(notificationModel.findByIdAndUpdate(notificationId, updateData, {
            "new": true
          }));

        case 33:
          updatedNotification = _context8.sent;

          if (updatedNotification) {
            _context8.next = 37;
            break;
          }

          req.flash('error', 'Notification not found.');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 37:
          successMessage = notificationType === 'new_recipe' ? "Recipe notification updated successfully for \"".concat(updateData.recipeName, "\"!") : 'General notification updated successfully!';
          req.flash('success', successMessage);
          return _context8.abrupt("return", res.redirect('/notification-history'));

        case 42:
          _context8.prev = 42;
          _context8.t0 = _context8["catch"](0);
          console.error("Error in updateNotification:", _context8.t0.message);
          req.flash('error', 'An error occurred while updating notification.');
          return _context8.abrupt("return", res.redirect(req.get("Referrer") || "/"));

        case 47:
        case "end":
          return _context8.stop();
      }
    }
  }, null, null, [[0, 42]]);
}; // Toggle notification status (enable/disable)


var toggleNotificationStatus = function toggleNotificationStatus(req, res) {
  var loginData, notificationId, isEnabled, updatedNotification, action;
  return regeneratorRuntime.async(function toggleNotificationStatus$(_context9) {
    while (1) {
      switch (_context9.prev = _context9.next) {
        case 0:
          _context9.prev = 0;
          _context9.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context9.sent;

          if (!(loginData && loginData.is_admin === 0)) {
            _context9.next = 6;
            break;
          }

          return _context9.abrupt("return", res.status(403).json({
            success: false,
            message: 'You have no access to modify notifications. Only admin have access to this functionality.'
          }));

        case 6:
          notificationId = req.params.id;
          isEnabled = req.body.isEnabled; // Validate notification ID

          if (notificationId) {
            _context9.next = 10;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            success: false,
            message: 'Notification ID is required'
          }));

        case 10:
          if (!(typeof isEnabled !== 'boolean')) {
            _context9.next = 12;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            success: false,
            message: 'Invalid status value'
          }));

        case 12:
          _context9.next = 14;
          return regeneratorRuntime.awrap(notificationModel.findByIdAndUpdate(notificationId, {
            isEnabled: isEnabled
          }, {
            "new": true
          }));

        case 14:
          updatedNotification = _context9.sent;

          if (updatedNotification) {
            _context9.next = 17;
            break;
          }

          return _context9.abrupt("return", res.status(404).json({
            success: false,
            message: 'Notification not found'
          }));

        case 17:
          action = isEnabled ? 'enabled' : 'disabled';
          return _context9.abrupt("return", res.status(200).json({
            success: true,
            message: "Notification ".concat(action, " successfully"),
            notification: updatedNotification
          }));

        case 21:
          _context9.prev = 21;
          _context9.t0 = _context9["catch"](0);
          console.error('Error in toggleNotificationStatus:', _context9.t0);
          return _context9.abrupt("return", res.status(500).json({
            success: false,
            message: 'An error occurred while updating notification status'
          }));

        case 25:
        case "end":
          return _context9.stop();
      }
    }
  }, null, null, [[0, 21]]);
}; // Delete notification


var deleteNotification = function deleteNotification(req, res) {
  var notificationId, deletedNotification;
  return regeneratorRuntime.async(function deleteNotification$(_context10) {
    while (1) {
      switch (_context10.prev = _context10.next) {
        case 0:
          _context10.prev = 0;
          notificationId = req.params.id; // Validate notification ID

          if (notificationId) {
            _context10.next = 4;
            break;
          }

          return _context10.abrupt("return", res.status(400).json({
            success: false,
            message: 'Notification ID is required'
          }));

        case 4:
          _context10.next = 6;
          return regeneratorRuntime.awrap(notificationModel.findByIdAndDelete(notificationId));

        case 6:
          deletedNotification = _context10.sent;

          if (deletedNotification) {
            _context10.next = 9;
            break;
          }

          return _context10.abrupt("return", res.status(404).json({
            success: false,
            message: 'Notification not found'
          }));

        case 9:
          return _context10.abrupt("return", res.status(200).json({
            success: true,
            message: 'Notification deleted successfully'
          }));

        case 12:
          _context10.prev = 12;
          _context10.t0 = _context10["catch"](0);
          console.error('Error in deleteNotification:', _context10.t0);
          return _context10.abrupt("return", res.status(500).json({
            success: false,
            message: 'An error occurred while deleting notification'
          }));

        case 16:
        case "end":
          return _context10.stop();
      }
    }
  }, null, null, [[0, 12]]);
};

module.exports = {
  loadPrivatePolicy: loadPrivatePolicy,
  addPrivatePolicy: addPrivatePolicy,
  loadTermsAndConditions: loadTermsAndConditions,
  addTermsAndConditional: addTermsAndConditional,
  loadSendNotification: loadSendNotification,
  sendNotification: sendNotification,
  updateNotification: updateNotification,
  loadNotificationHistory: loadNotificationHistory,
  toggleNotificationStatus: toggleNotificationStatus,
  deleteNotification: deleteNotification
};