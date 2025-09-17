"use strict";

// Test different localhost URLs for Flutter app
var http = require('http');

var testUrls = ['http://localhost:8190/api/GetAllNotification', 'http://10.0.2.2:8190/api/GetAllNotification', 'http://127.0.0.1:8190/api/GetAllNotification'];

function testUrl(url, index) {
  return new Promise(function (resolve) {
    console.log("".concat(index + 1, ". Testing: ").concat(url));
    var urlObj = new URL(url);
    var postData = JSON.stringify({});
    var options = {
      hostname: urlObj.hostname,
      port: urlObj.port,
      path: urlObj.pathname,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      },
      timeout: 5000
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
            console.log("   \u2705 Success - Found ".concat(response.data.notification.length, " notifications"));
            resolve({
              url: url,
              success: true,
              count: response.data.notification.length
            });
          } else {
            console.log("   \u274C Invalid response structure");
            resolve({
              url: url,
              success: false,
              error: 'Invalid response'
            });
          }
        } catch (error) {
          console.log("   \u274C JSON parse error: ".concat(error.message));
          resolve({
            url: url,
            success: false,
            error: error.message
          });
        }
      });
    });
    req.on('error', function (error) {
      console.log("   \u274C Connection error: ".concat(error.message));
      resolve({
        url: url,
        success: false,
        error: error.message
      });
    });
    req.on('timeout', function () {
      console.log("   \u274C Request timeout");
      req.destroy();
      resolve({
        url: url,
        success: false,
        error: 'Timeout'
      });
    });
    req.write(postData);
    req.end();
  });
}

function testAllUrls() {
  var results, i, result, working, failed;
  return regeneratorRuntime.async(function testAllUrls$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          console.log('🔍 Testing different localhost URLs for Flutter app...\n');
          results = [];
          i = 0;

        case 3:
          if (!(i < testUrls.length)) {
            _context.next = 11;
            break;
          }

          _context.next = 6;
          return regeneratorRuntime.awrap(testUrl(testUrls[i], i));

        case 6:
          result = _context.sent;
          results.push(result);

        case 8:
          i++;
          _context.next = 3;
          break;

        case 11:
          console.log('\n📊 Results Summary:');
          working = results.filter(function (r) {
            return r.success;
          });
          failed = results.filter(function (r) {
            return !r.success;
          });

          if (working.length > 0) {
            console.log('✅ Working URLs:');
            working.forEach(function (r) {
              console.log("   - ".concat(r.url, " (").concat(r.count, " notifications)"));
            });
          }

          if (failed.length > 0) {
            console.log('❌ Failed URLs:');
            failed.forEach(function (r) {
              console.log("   - ".concat(r.url, ": ").concat(r.error));
            });
          }

          console.log('\n💡 Flutter App Configuration:');

          if (working.length > 0) {
            console.log('✅ API is accessible, notifications should display in Flutter app');
            console.log('🔧 Make sure Flutter app is using the correct base URL for your platform:');
            console.log('   - Android Emulator: http://10.0.2.2:8190/api');
            console.log('   - iOS Simulator: http://localhost:8190/api');
            console.log('   - Web: http://localhost:8190/api');
            console.log('   - Physical Device: http://[computer-ip]:8190/api');
          } else {
            console.log('❌ API is not accessible from any localhost variant');
            console.log('🔧 Please ensure the admin panel server is running on port 8190');
          }

        case 18:
        case "end":
          return _context.stop();
      }
    }
  });
}

testAllUrls();