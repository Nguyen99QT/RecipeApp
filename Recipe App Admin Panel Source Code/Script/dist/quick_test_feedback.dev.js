"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function _getRequireWildcardCache() { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } if (obj === null || _typeof(obj) !== "object" && typeof obj !== "function") { return { "default": obj }; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj["default"] = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

// Quick test for AddAppFeedback API
var testAddAppFeedback = function testAddAppFeedback() {
  var fetch, response, result;
  return regeneratorRuntime.async(function testAddAppFeedback$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.next = 2;
          return regeneratorRuntime.awrap(Promise.resolve().then(function () {
            return _interopRequireWildcard(require('node-fetch'));
          }));

        case 2:
          fetch = _context.sent["default"];
          console.log('=== TESTING ADD APP FEEDBACK API ===\n');
          _context.prev = 4;
          _context.next = 7;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/AddAppFeedback', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjkwNTEzNCwiZXhwIjoxNzU5NDk3MTM0fQ.Uw6wY-qDHc5eAtlpf4QngeyubS5aWPpT5CU3-765aDM'
            },
            body: JSON.stringify({
              rating: 5,
              comment: 'Great app for recipes! Very user friendly.'
            })
          }));

        case 7:
          response = _context.sent;
          _context.next = 10;
          return regeneratorRuntime.awrap(response.json());

        case 10:
          result = _context.sent;
          console.log('Status:', response.status);
          console.log('Response:', JSON.stringify(result, null, 2));
          console.log('✅ Status:', response.status === 200 ? 'PASS' : 'FAIL');
          _context.next = 19;
          break;

        case 16:
          _context.prev = 16;
          _context.t0 = _context["catch"](4);
          console.log('❌ Error:', _context.t0.message);

        case 19:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[4, 16]]);
};

testAddAppFeedback();