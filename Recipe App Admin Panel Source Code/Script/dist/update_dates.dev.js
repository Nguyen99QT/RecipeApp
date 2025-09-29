"use strict";

var mongoose = require('mongoose');

var categoryModel = require('./model/categoryModel');

var cuisinesModel = require('./model/cuisinesModel'); // Database connection


mongoose.connect('mongodb://localhost:27017/food-recipe');
var db = mongoose.connection;
db.on('error', function (error) {
  console.error('Database connection error:', error);
});
db.once('open', function _callee() {
  var targetDate, totalCategories, totalCuisines, updatedCategories, updatedCuisines;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          console.log('Connected to MongoDB successfully');
          _context.prev = 1;
          // Set target date: 17/8/2025
          targetDate = new Date('2025-08-17T00:00:00.000Z');
          console.log('Target date:', targetDate); // First, let's check current documents

          _context.next = 6;
          return regeneratorRuntime.awrap(categoryModel.countDocuments({}));

        case 6:
          totalCategories = _context.sent;
          _context.next = 9;
          return regeneratorRuntime.awrap(cuisinesModel.countDocuments({}));

        case 9:
          totalCuisines = _context.sent;
          console.log("Total categories: ".concat(totalCategories));
          console.log("Total cuisines: ".concat(totalCuisines)); // Update all categories

          console.log('\n=== Updating Categories ===');
          _context.next = 15;
          return regeneratorRuntime.awrap(categoryModel.updateMany({}, // Empty filter to match all documents
          {
            createdAt: targetDate,
            updatedAt: targetDate
          }));

        case 15:
          console.log('Categories update command executed'); // Update all cuisines

          console.log('\n=== Updating Cuisines ===');
          _context.next = 19;
          return regeneratorRuntime.awrap(cuisinesModel.updateMany({}, // Empty filter to match all documents
          {
            createdAt: targetDate,
            updatedAt: targetDate
          }));

        case 19:
          console.log('Cuisines update command executed'); // Verify updates

          console.log('\n=== Verification ===');
          _context.next = 23;
          return regeneratorRuntime.awrap(categoryModel.find({}, 'name createdAt').limit(3));

        case 23:
          updatedCategories = _context.sent;
          _context.next = 26;
          return regeneratorRuntime.awrap(cuisinesModel.find({}, 'name createdAt').limit(3));

        case 26:
          updatedCuisines = _context.sent;
          console.log('Updated categories:');
          updatedCategories.forEach(function (cat) {
            console.log("- ".concat(cat.name, ": ").concat(cat.createdAt));
          });
          console.log('Updated cuisines:');
          updatedCuisines.forEach(function (cuisine) {
            console.log("- ".concat(cuisine.name, ": ").concat(cuisine.createdAt));
          });
          console.log('\n✅ Date update completed successfully!');
          _context.next = 37;
          break;

        case 34:
          _context.prev = 34;
          _context.t0 = _context["catch"](1);
          console.error('Error updating dates:', _context.t0);

        case 37:
          _context.prev = 37;
          _context.next = 40;
          return regeneratorRuntime.awrap(mongoose.connection.close());

        case 40:
          console.log('Database connection closed');
          return _context.finish(37);

        case 42:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[1, 34, 37, 42]]);
});
