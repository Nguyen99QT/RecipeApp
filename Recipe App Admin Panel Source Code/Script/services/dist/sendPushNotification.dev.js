"use strict";

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

// Importing required modules 
var admin = require('firebase-admin');

var serviceAccount = require('../firebase.json'); // Initialize Firebase Admin SDK


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
}); // // const registrationTokens = "cLte7Mh0SaO6lkCTR9qDlV:APA91bGGKOob7C1QMQ1SaEuLCt9b_ddN7cftWYOqoUOOuP6zdtEgi3nvsmoAFVTRQuU0w4d1PugzGfTrG9WZfjPSaTPHeiWGxFjAT4E_lmir7WFR_Lq8QLRymKOZyRBxQZ0wRC99Egn9"
// const title = "Hello DreamVision";
// const description = "This is a test notification for you";
// Function to send notifications

var sendPushNotification = function sendPushNotification(registrationTokens, title, message) {
  var data,
      totalTokens,
      _iteratorNormalCompletion,
      _didIteratorError,
      _iteratorError,
      _iterator,
      _step,
      token,
      messagePayload,
      _i,
      _Object$entries,
      _Object$entries$_i,
      key,
      value,
      response,
      _args = arguments;

  return regeneratorRuntime.async(function sendPushNotification$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          data = _args.length > 3 && _args[3] !== undefined ? _args[3] : {};
          totalTokens = registrationTokens.length; // Iterate over each token and send the notification

          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context.prev = 5;
          _iterator = registrationTokens[Symbol.iterator]();

        case 7:
          if (_iteratorNormalCompletion = (_step = _iterator.next()).done) {
            _context.next = 24;
            break;
          }

          token = _step.value;
          messagePayload = {
            notification: {
              title: title,
              body: message
            },
            token: token
          }; // Add custom data if provided

          if (Object.keys(data).length > 0) {
            messagePayload.data = {}; // Convert all data values to strings (Firebase requirement)

            for (_i = 0, _Object$entries = Object.entries(data); _i < _Object$entries.length; _i++) {
              _Object$entries$_i = _slicedToArray(_Object$entries[_i], 2), key = _Object$entries$_i[0], value = _Object$entries$_i[1];
              messagePayload.data[key] = String(value);
            }
          }

          _context.prev = 11;
          _context.next = 14;
          return regeneratorRuntime.awrap(admin.messaging().send(messagePayload));

        case 14:
          response = _context.sent;
          console.log("Successfully sent notification to token: ".concat(response));
          _context.next = 21;
          break;

        case 18:
          _context.prev = 18;
          _context.t0 = _context["catch"](11);
          console.error("Failed to send notification to token:", _context.t0);

        case 21:
          _iteratorNormalCompletion = true;
          _context.next = 7;
          break;

        case 24:
          _context.next = 30;
          break;

        case 26:
          _context.prev = 26;
          _context.t1 = _context["catch"](5);
          _didIteratorError = true;
          _iteratorError = _context.t1;

        case 30:
          _context.prev = 30;
          _context.prev = 31;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 33:
          _context.prev = 33;

          if (!_didIteratorError) {
            _context.next = 36;
            break;
          }

          throw _iteratorError;

        case 36:
          return _context.finish(33);

        case 37:
          return _context.finish(30);

        case 38:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[5, 26, 30, 38], [11, 18], [31,, 33, 37]]);
}; // sendPushNotification();


module.exports = sendPushNotification;