"use strict";

// Test API with IP address
var http = require('http');

function testAPI(host) {
  console.log("\uD83D\uDD0D Testing API at ".concat(host, ":8190...\n"));
  var postData = JSON.stringify({});
  var options = {
    hostname: host,
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
          console.log("\u2705 API working at ".concat(host, ":8190"));
          console.log("\uD83D\uDCCA Found ".concat(response.data.notification.length, " notifications"));
        } else {
          console.log("\u274C API response structure incorrect at ".concat(host, ":8190"));
        }
      } catch (error) {
        console.log("\u274C JSON parse error at ".concat(host, ":8190:"), error.message);
      }
    });
  });
  req.on('error', function (error) {
    console.log("\u274C Connection error to ".concat(host, ":8190:"), error.message);
  });
  req.write(postData);
  req.end();
} // Test both localhost and IP


testAPI('localhost');
setTimeout(function () {
  return testAPI('192.168.101.207');
}, 1000);