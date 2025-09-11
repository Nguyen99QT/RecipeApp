"use strict";

// Simple test using Node.js built-in modules
var http = require('http');

var url = require('url');

function testReviewFilter(path, description) {
  return regeneratorRuntime.async(function testReviewFilter$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          return _context.abrupt("return", new Promise(function (resolve, reject) {
            var options = {
              hostname: 'localhost',
              port: 8190,
              path: path,
              method: 'GET'
            };
            var req = http.request(options, function (res) {
              var data = '';
              res.on('data', function (chunk) {
                data += chunk;
              });
              res.on('end', function () {
                console.log("\n=== ".concat(description, " ==="));
                console.log("URL: http://localhost:8190".concat(path));
                console.log("Status: ".concat(res.statusCode)); // Extract filter values from HTML

                var statusMatch = data.match(/currentStatusFilter === '([^']+)'/);
                var typeMatch = data.match(/currentTypeFilter === '([^']+)'/); // Extract stats

                var totalMatch = data.match(/Total: (\d+)/);
                var enabledMatch = data.match(/Enabled: (\d+)/);
                var disabledMatch = data.match(/Disabled: (\d+)/);
                var recipeMatch = data.match(/Recipe: (\d+)/);
                var appMatch = data.match(/App: (\d+)/);
                console.log("Current Status Filter: ".concat(statusMatch ? statusMatch[1] : 'not found'));
                console.log("Current Type Filter: ".concat(typeMatch ? typeMatch[1] : 'not found'));
                console.log("Stats - Total: ".concat(totalMatch ? totalMatch[1] : '?', ", Enabled: ").concat(enabledMatch ? enabledMatch[1] : '?', ", Disabled: ").concat(disabledMatch ? disabledMatch[1] : '?'));
                console.log("Stats - Recipe: ".concat(recipeMatch ? recipeMatch[1] : '?', ", App: ").concat(appMatch ? appMatch[1] : '?'));
                resolve();
              });
            });
            req.on('error', function (err) {
              console.log("\n=== ".concat(description, " ==="));
              console.log("ERROR: ".concat(err.message));
              resolve();
            });
            req.end();
          }));

        case 1:
        case "end":
          return _context.stop();
      }
    }
  });
}

function runTests() {
  var tests, _i, _tests, test;

  return regeneratorRuntime.async(function runTests$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log('🧪 Testing Review Filtering Functionality');
          tests = [{
            path: '/admin/review',
            desc: 'All Reviews (Default)'
          }, {
            path: '/admin/review?status=enabled',
            desc: 'Enabled Reviews Only'
          }, {
            path: '/admin/review?status=disabled',
            desc: 'Disabled Reviews Only'
          }, {
            path: '/admin/review?type=recipe',
            desc: 'Recipe Reviews Only'
          }, {
            path: '/admin/review?type=app',
            desc: 'App Reviews Only'
          }, {
            path: '/admin/review?status=enabled&type=recipe',
            desc: 'Enabled Recipe Reviews'
          }, {
            path: '/admin/review?status=disabled&type=app',
            desc: 'Disabled App Reviews'
          }];
          _i = 0, _tests = tests;

        case 3:
          if (!(_i < _tests.length)) {
            _context2.next = 12;
            break;
          }

          test = _tests[_i];
          _context2.next = 7;
          return regeneratorRuntime.awrap(testReviewFilter(test.path, test.desc));

        case 7:
          _context2.next = 9;
          return regeneratorRuntime.awrap(new Promise(function (resolve) {
            return setTimeout(resolve, 1000);
          }));

        case 9:
          _i++;
          _context2.next = 3;
          break;

        case 12:
          console.log('\n✅ Test completed!');

        case 13:
        case "end":
          return _context2.stop();
      }
    }
  });
}

runTests()["catch"](console.error);