"use strict";

// Simple test for notification API without external dependencies
var http = require('http');

function testNotificationAPI() {
  console.log('🔍 Testing Notification API...\n');
  var postData = JSON.stringify({});
  var options = {
    hostname: 'localhost',
    port: 8190,
    path: '/api/GetAllNotification',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData)
    }
  };
  var req = http.request(options, function (res) {
    var data = '';
    res.on('data', function (chunk) {
      data += chunk;
    });
    res.on('end', function () {
      try {
        var response = JSON.parse(data);

        if (response.status && response.data && response.data.notification) {
          console.log('✅ API is working correctly');
          console.log("\uD83D\uDCCA Found ".concat(response.data.notification.length, " notifications"));

          if (response.data.notification.length > 0) {
            var sample = response.data.notification[0];
            console.log('\n📋 Sample notification:');
            console.log("   Title: ".concat(sample.title));
            console.log("   Description: ".concat(sample.description || sample.message));
            console.log("   Date: ".concat(sample.date));
            console.log("   Type: ".concat(sample.type)); // Check if all required fields are present

            var hasTitle = !!sample.title;
            var hasDescription = !!(sample.description || sample.message);
            var hasDate = !!sample.date;
            console.log('\n🔍 Flutter App Requirements Check:');
            console.log("   Title field: ".concat(hasTitle ? '✅' : '❌'));
            console.log("   Description field: ".concat(hasDescription ? '✅' : '❌'));
            console.log("   Date field: ".concat(hasDate ? '✅' : '❌'));

            if (hasTitle && hasDescription && hasDate) {
              console.log('\n✅ All required fields are present for Flutter app');
            } else {
              console.log('\n❌ Missing required fields for Flutter app');
            }
          }
        } else {
          console.log('❌ API response structure is incorrect');
          console.log('Response:', response);
        }
      } catch (error) {
        console.log('❌ Error parsing API response:', error.message);
        console.log('Raw response:', data);
      }
    });
  });
  req.on('error', function (error) {
    if (error.code === 'ECONNREFUSED') {
      console.log('❌ Cannot connect to server at localhost:8190');
      console.log('💡 Please make sure the admin panel server is running');
    } else {
      console.log('❌ Request error:', error.message);
    }
  });
  req.write(postData);
  req.end();
}

testNotificationAPI();