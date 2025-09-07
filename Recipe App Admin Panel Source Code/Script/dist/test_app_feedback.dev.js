"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function _getRequireWildcardCache() { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } if (obj === null || _typeof(obj) !== "object" && typeof obj !== "function") { return { "default": obj }; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj["default"] = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

// Test script for app feedback API
function testAppFeedbackAPI() {
  var fetch, baseURL, loginResponse, loginData, token, feedbackResponse, feedbackData;
  return regeneratorRuntime.async(function testAppFeedbackAPI$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.next = 2;
          return regeneratorRuntime.awrap(Promise.resolve().then(function () {
            return _interopRequireWildcard(require('node-fetch'));
          }));

        case 2:
          fetch = _context.sent["default"];
          baseURL = 'http://localhost:8190/api';
          _context.prev = 4;
          console.log('🔐 Testing login...');
          _context.next = 8;
          return regeneratorRuntime.awrap(fetch("".concat(baseURL, "/login"), {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              email: 'thunkaka8899@gmail.com',
              password: 'password'
            })
          }));

        case 8:
          loginResponse = _context.sent;
          _context.next = 11;
          return regeneratorRuntime.awrap(loginResponse.json());

        case 11:
          loginData = _context.sent;

          if (!loginData.status) {
            _context.next = 28;
            break;
          }

          token = loginData.token;
          console.log('✅ Login successful');
          console.log('\n📱 Testing app feedback API...');
          _context.next = 18;
          return regeneratorRuntime.awrap(fetch("".concat(baseURL, "/AddAppFeedback"), {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': "Bearer ".concat(token)
            },
            body: JSON.stringify({
              rating: 5,
              comment: 'Great app! Love using it for cooking. Very helpful interface and features.'
            })
          }));

        case 18:
          feedbackResponse = _context.sent;
          _context.next = 21;
          return regeneratorRuntime.awrap(feedbackResponse.json());

        case 21:
          feedbackData = _context.sent;
          console.log('📊 App Feedback API Response:');
          console.log('Status Code:', feedbackResponse.status);
          console.log('Response Body:', JSON.stringify(feedbackData, null, 2));

          if (feedbackData.status) {
            console.log('✅ App feedback submitted successfully!');
          } else {
            console.log('❌ App feedback failed:', feedbackData.message);
          }

          _context.next = 29;
          break;

        case 28:
          console.log('❌ Login failed:', loginData.message);

        case 29:
          _context.next = 34;
          break;

        case 31:
          _context.prev = 31;
          _context.t0 = _context["catch"](4);
          console.error('❌ Error testing app feedback:', _context.t0.message);

        case 34:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[4, 31]]);
}

testAppFeedbackAPI();