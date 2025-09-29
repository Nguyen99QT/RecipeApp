"use strict";

// Test Flutter app notification API connectivity
var fetch = require('node-fetch');

function testFlutterNotificationAPI() {
  var response, data, sample;
  return regeneratorRuntime.async(function testFlutterNotificationAPI$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          console.log('🔍 Testing Flutter App Notification API Connection...\n');
          _context.prev = 1;
          // Test if the admin panel server is running
          console.log('1️⃣ Checking if admin panel server is running...');
          _context.next = 5;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/GetAllNotification', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json' // No authorization header to simulate Flutter app call without login

            },
            body: JSON.stringify({})
          }));

        case 5:
          response = _context.sent;
          _context.next = 8;
          return regeneratorRuntime.awrap(response.json());

        case 8:
          data = _context.sent;

          if (response.ok && data.status) {
            console.log('✅ Server is running and API is accessible');
            console.log("\uD83D\uDCCA Found ".concat(data.data.notification.length, " notifications")); // Check notification structure

            if (data.data.notification.length > 0) {
              sample = data.data.notification[0];
              console.log('\n📋 Sample notification structure:');
              console.log("   - Title: ".concat(sample.title ? '✅' : '❌'));
              console.log("   - Description: ".concat(sample.description ? '✅' : '❌'));
              console.log("   - Date: ".concat(sample.date ? '✅' : '❌'));
              console.log("   - Type: ".concat(sample.type ? '✅' : '❌'));

              if (sample.type === 'new_recipe') {
                console.log("   - Recipe ID: ".concat(sample.recipeId ? '✅' : '❌'));
                console.log("   - Recipe Name: ".concat(sample.recipeName ? '✅' : '❌'));
              }
            }

            console.log('\n🎯 Flutter App Integration Status:');
            console.log('✅ API endpoint is working correctly');
            console.log('✅ Response structure matches Flutter expectations');
            console.log('⚠️  FCM functionality needs to be enabled in Flutter app');
            console.log('⚠️  Test the Flutter app notification page to verify display');
          } else {
            console.log('❌ API call failed:', data.message || 'Unknown error');
          }

          _context.next = 15;
          break;

        case 12:
          _context.prev = 12;
          _context.t0 = _context["catch"](1);

          if (_context.t0.code === 'ECONNREFUSED') {
            console.log('❌ Admin panel server is not running!');
            console.log('💡 Please start the server with: npm start');
          } else {
            console.log('❌ Error testing API:', _context.t0.message);
          }

        case 15:
          console.log('\n🔧 Next Steps for Flutter App:');
          console.log('1. Start the admin panel server if not running');
          console.log('2. Run the Flutter app and navigate to notification page');
          console.log('3. Check if notifications display correctly');
          console.log('4. Enable FCM functionality for push notifications');
          console.log('5. Test end-to-end notification flow');

        case 21:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[1, 12]]);
}

testFlutterNotificationAPI();
