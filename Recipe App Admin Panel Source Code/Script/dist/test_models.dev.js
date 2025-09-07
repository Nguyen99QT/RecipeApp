"use strict";

require('./config/conn');

var notificationModel = require('./model/notificationModel');

var recipeModel = require('./model/recipeModel');

function testModels() {
  var notifications, recipes, notificationsWithRecipes;
  return regeneratorRuntime.async(function testModels$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          console.log('Testing notification model...');
          _context.next = 4;
          return regeneratorRuntime.awrap(notificationModel.find().limit(2));

        case 4:
          notifications = _context.sent;
          console.log("Found ".concat(notifications.length, " notifications"));
          console.log('Testing recipe model...');
          _context.next = 9;
          return regeneratorRuntime.awrap(recipeModel.find().limit(2));

        case 9:
          recipes = _context.sent;
          console.log("Found ".concat(recipes.length, " recipes"));
          console.log('Testing populate...');
          _context.next = 14;
          return regeneratorRuntime.awrap(notificationModel.find().populate('recipeId', 'name image').limit(2));

        case 14:
          notificationsWithRecipes = _context.sent;
          console.log('Populate successful');
          console.log('All models working correctly!');
          process.exit(0);
          _context.next = 24;
          break;

        case 20:
          _context.prev = 20;
          _context.t0 = _context["catch"](0);
          console.error('Error testing models:', _context.t0);
          process.exit(1);

        case 24:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 20]]);
}

testModels();