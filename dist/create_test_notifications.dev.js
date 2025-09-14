"use strict";

// Simple test script to create test notifications in MongoDB
var _require = require('mongodb'),
    MongoClient = _require.MongoClient; // MongoDB connection URL (adjust if needed)


var url = 'mongodb://localhost:27017';
var dbName = 'food-recipe';

function createTestNotifications() {
  var client, db, collection, testNotifications, result, totalCount;
  return regeneratorRuntime.async(function createTestNotifications$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          client = new MongoClient(url);
          _context.prev = 1;
          _context.next = 4;
          return regeneratorRuntime.awrap(client.connect());

        case 4:
          console.log('Connected to MongoDB');
          db = client.db(dbName);
          collection = db.collection('notifications'); // Create test notifications

          testNotifications = [{
            date: new Date().toLocaleDateString(),
            title: 'Welcome to Recipe App!',
            message: 'Thank you for joining our recipe community. Enjoy exploring delicious recipes!',
            type: 'general',
            isEnabled: true,
            readNotifications: [],
            // Empty array means no one has read it yet
            createdAt: new Date(),
            updatedAt: new Date()
          }, {
            date: new Date().toLocaleDateString(),
            title: 'New Recipe Added!',
            message: 'Check out our latest delicious pasta recipe. Perfect for dinner!',
            type: 'new_recipe',
            recipeName: 'Delicious Pasta',
            isEnabled: true,
            readNotifications: [],
            // Empty array means no one has read it yet
            createdAt: new Date(),
            updatedAt: new Date()
          }, {
            date: new Date().toLocaleDateString(),
            title: 'Special Offer!',
            message: 'Get premium recipes with 50% discount this month!',
            type: 'general',
            isEnabled: true,
            readNotifications: [],
            // Empty array means no one has read it yet
            createdAt: new Date(),
            updatedAt: new Date()
          }]; // Insert test notifications

          _context.next = 10;
          return regeneratorRuntime.awrap(collection.insertMany(testNotifications));

        case 10:
          result = _context.sent;
          console.log("".concat(result.insertedCount, " test notifications created successfully!"));
          console.log('Inserted IDs:', Object.values(result.insertedIds)); // Count total notifications

          _context.next = 15;
          return regeneratorRuntime.awrap(collection.countDocuments());

        case 15:
          totalCount = _context.sent;
          console.log("Total notifications in database: ".concat(totalCount));
          _context.next = 22;
          break;

        case 19:
          _context.prev = 19;
          _context.t0 = _context["catch"](1);
          console.error('Error:', _context.t0);

        case 22:
          _context.prev = 22;
          _context.next = 25;
          return regeneratorRuntime.awrap(client.close());

        case 25:
          console.log('MongoDB connection closed');
          return _context.finish(22);

        case 27:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[1, 19, 22, 27]]);
} // Check if mongodb module exists, if not provide alternative


var fs = require('fs');

var path = require('path'); // Check if we're in the Script directory


var currentDir = process.cwd();
var scriptDir = path.join(currentDir, 'Recipe App Admin Panel Source Code', 'Script');

if (fs.existsSync(scriptDir)) {
  console.log('Changing to script directory...');
  process.chdir(scriptDir);

  try {
    var createTestNotificationsWithMongoose = function createTestNotificationsWithMongoose() {
      var testNotifications, result, totalCount;
      return regeneratorRuntime.async(function createTestNotificationsWithMongoose$(_context2) {
        while (1) {
          switch (_context2.prev = _context2.next) {
            case 0:
              _context2.prev = 0;
              _context2.next = 3;
              return regeneratorRuntime.awrap(mongoose.connect('mongodb://localhost:27017/food-recipe'));

            case 3:
              console.log('Connected to MongoDB via Mongoose'); // Create test notifications

              testNotifications = [{
                date: new Date().toLocaleDateString(),
                title: 'Welcome to Recipe App!',
                message: 'Thank you for joining our recipe community. Enjoy exploring delicious recipes!',
                type: 'general',
                isEnabled: true,
                readNotifications: []
              }, {
                date: new Date().toLocaleDateString(),
                title: 'New Recipe Added!',
                message: 'Check out our latest delicious pasta recipe. Perfect for dinner!',
                type: 'new_recipe',
                recipeName: 'Delicious Pasta',
                isEnabled: true,
                readNotifications: []
              }, {
                date: new Date().toLocaleDateString(),
                title: 'Special Offer!',
                message: 'Get premium recipes with 50% discount this month!',
                type: 'general',
                isEnabled: true,
                readNotifications: []
              }]; // Insert test notifications

              _context2.next = 7;
              return regeneratorRuntime.awrap(notificationModel.insertMany(testNotifications));

            case 7:
              result = _context2.sent;
              console.log("".concat(result.length, " test notifications created successfully!")); // Count total notifications

              _context2.next = 11;
              return regeneratorRuntime.awrap(notificationModel.countDocuments());

            case 11:
              totalCount = _context2.sent;
              console.log("Total notifications in database: ".concat(totalCount));
              _context2.next = 15;
              return regeneratorRuntime.awrap(mongoose.disconnect());

            case 15:
              console.log('MongoDB connection closed');
              _context2.next = 21;
              break;

            case 18:
              _context2.prev = 18;
              _context2.t0 = _context2["catch"](0);
              console.error('Error with Mongoose:', _context2.t0.message);

            case 21:
            case "end":
              return _context2.stop();
          }
        }
      }, null, null, [[0, 18]]);
    };

    // Try to use the existing project's mongoose
    var mongoose = require('mongoose');

    var notificationModel = require('./model/notificationModel');

    createTestNotificationsWithMongoose();
  } catch (error) {
    console.log('Mongoose not available, using native MongoDB driver...');
    createTestNotifications();
  }
} else {
  console.log('Script directory not found, using native MongoDB driver...');
  createTestNotifications();
}