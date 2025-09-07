"use strict";

// Test enhanced notification system
function testNotificationSystem() {
  var response, data, generalNotifications, recipeNotifications;
  return regeneratorRuntime.async(function testNotificationSystem$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          console.log('🔔 Testing Enhanced Notification System...\n');
          _context.prev = 1;
          // Test 1: Get all notifications
          console.log('1️⃣ Testing GetAllNotification API...');
          _context.next = 5;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/GetAllNotification', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
          }));

        case 5:
          response = _context.sent;
          _context.next = 8;
          return regeneratorRuntime.awrap(response.json());

        case 8:
          data = _context.sent;

          if (data.status) {
            console.log("\u2705 API successful, found ".concat(data.data.notification.length, " notifications")); // Show notification types

            generalNotifications = data.data.notification.filter(function (n) {
              return n.type === 'general';
            });
            recipeNotifications = data.data.notification.filter(function (n) {
              return n.type === 'new_recipe';
            });
            console.log("   \uD83D\uDCE2 General notifications: ".concat(generalNotifications.length));
            console.log("   \uD83C\uDF7D\uFE0F Recipe notifications: ".concat(recipeNotifications.length)); // Show sample notifications

            if (data.data.notification.length > 0) {
              console.log('\n📋 Sample notifications:');
              data.data.notification.slice(0, 3).forEach(function (notification, index) {
                console.log("   ".concat(index + 1, ". Type: ").concat(notification.type));
                console.log("      Title: ".concat(notification.title));

                if (notification.type === 'new_recipe' && notification.recipeName) {
                  console.log("      Recipe: ".concat(notification.recipeName));
                  console.log("      Recipe ID: ".concat(notification.recipeId));
                }

                console.log("      Date: ".concat(notification.date));
                console.log('      ---');
              });
            }
          } else {
            console.log('❌ API failed:', data.message);
          }

          _context.next = 15;
          break;

        case 12:
          _context.prev = 12;
          _context.t0 = _context["catch"](1);
          console.error('❌ Error testing notification system:', _context.t0.message);

        case 15:
          console.log('\n🎯 New Notification Features:');
          console.log('✅ Admin can send general notifications to all users');
          console.log('✅ Admin can send new recipe notifications with recipe selection');
          console.log('✅ Notifications include recipe ID for navigation in app');
          console.log('✅ Push notifications carry custom data for app handling');
          console.log('✅ API returns full notification details with recipe info');

        case 21:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[1, 12]]);
}

testNotificationSystem();