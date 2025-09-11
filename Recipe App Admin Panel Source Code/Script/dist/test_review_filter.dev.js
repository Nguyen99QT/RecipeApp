"use strict";

var axios = require('axios');

function testReviewFiltering() {
  var baseUrl, tests, _i, _tests, test, response, statusMatch, typeMatch, statsMatch, currentStatus, currentType, totalCount;

  return regeneratorRuntime.async(function testReviewFiltering$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          baseUrl = 'http://localhost:8190/admin/review';
          console.log('=== Testing Review Filtering ===\n'); // Test cases

          tests = [{
            name: 'All Reviews (no filter)',
            url: baseUrl
          }, {
            name: 'Enabled Reviews Only',
            url: "".concat(baseUrl, "?status=enabled")
          }, {
            name: 'Disabled Reviews Only',
            url: "".concat(baseUrl, "?status=disabled")
          }, {
            name: 'Recipe Reviews Only',
            url: "".concat(baseUrl, "?type=recipe")
          }, {
            name: 'App Reviews Only',
            url: "".concat(baseUrl, "?type=app")
          }, {
            name: 'Enabled Recipe Reviews',
            url: "".concat(baseUrl, "?status=enabled&type=recipe")
          }, {
            name: 'Disabled App Reviews',
            url: "".concat(baseUrl, "?status=disabled&type=app")
          }];
          _i = 0, _tests = tests;

        case 4:
          if (!(_i < _tests.length)) {
            _context.next = 32;
            break;
          }

          test = _tests[_i];
          _context.prev = 6;
          console.log("Testing: ".concat(test.name));
          console.log("URL: ".concat(test.url));
          _context.next = 11;
          return regeneratorRuntime.awrap(axios.get(test.url));

        case 11:
          response = _context.sent;
          // Extract filter values from response
          statusMatch = response.data.match(/currentStatusFilter[^']*'([^']+)'/);
          typeMatch = response.data.match(/currentTypeFilter[^']*'([^']+)'/);
          statsMatch = response.data.match(/stats\.total[^>]*>(\d+)</);
          currentStatus = statusMatch ? statusMatch[1] : 'not found';
          currentType = typeMatch ? typeMatch[1] : 'not found';
          totalCount = statsMatch ? statsMatch[1] : 'not found';
          console.log("\u2713 Response received (status: ".concat(response.status, ")"));
          console.log("  Current Status Filter: ".concat(currentStatus));
          console.log("  Current Type Filter: ".concat(currentType));
          console.log("  Total Count: ".concat(totalCount));
          console.log('---');
          _context.next = 29;
          break;

        case 25:
          _context.prev = 25;
          _context.t0 = _context["catch"](6);
          console.log("\u2717 Failed: ".concat(_context.t0.message));
          console.log('---');

        case 29:
          _i++;
          _context.next = 4;
          break;

        case 32:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[6, 25]]);
} // Run tests


testReviewFiltering()["catch"](console.error);