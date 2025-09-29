"use strict";

var mongoose = require("mongoose");

var notificationModel = require("./model/notificationModel"); // Connect to MongoDB


mongoose.connect("mongodb://localhost:27017/food-recipe", {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

function checkNotificationData() {
  var notifications, noMessage;
  return regeneratorRuntime.async(function checkNotificationData$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          console.log("🔍 Checking notification data structure...\n");
          _context.next = 4;
          return regeneratorRuntime.awrap(notificationModel.find().sort({
            createdAt: -1
          }));

        case 4:
          notifications = _context.sent;
          console.log("\uD83D\uDCCA Total notifications: ".concat(notifications.length, "\n"));
          notifications.forEach(function (notification, index) {
            console.log("".concat(index + 1, ". Notification ID: ").concat(notification._id));
            console.log("   Type: ".concat(notification.type || 'undefined'));
            console.log("   Title: ".concat(notification.title || 'undefined'));
            console.log("   Message: ".concat(notification.message || 'undefined'));
            console.log("   Description: ".concat(notification.description || 'undefined'));
            console.log("   RecipeId: ".concat(notification.recipeId || 'undefined'));
            console.log("   Created: ".concat(notification.createdAt));
            console.log("   ---");
          }); // Check for any notifications with missing message

          noMessage = notifications.filter(function (n) {
            return !n.message;
          });

          if (noMessage.length > 0) {
            console.log("\n\u26A0\uFE0F  Found ".concat(noMessage.length, " notifications without message:"));
            noMessage.forEach(function (n) {
              console.log("   - ID: ".concat(n._id, ", Title: ").concat(n.title));
            });
          }

          process.exit(0);
          _context.next = 16;
          break;

        case 12:
          _context.prev = 12;
          _context.t0 = _context["catch"](0);
          console.error("❌ Error:", _context.t0.message);
          process.exit(1);

        case 16:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 12]]);
}

checkNotificationData();
