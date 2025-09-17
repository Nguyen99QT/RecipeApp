"use strict";

var _require = require('mongodb'),
    MongoClient = _require.MongoClient;

function updateDates() {
  var uri, client, db, targetDate, categoryResult, cuisineResult, sampleCategory, sampleCuisine;
  return regeneratorRuntime.async(function updateDates$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          uri = 'mongodb://localhost:27017';
          client = new MongoClient(uri);
          _context.prev = 2;
          _context.next = 5;
          return regeneratorRuntime.awrap(client.connect());

        case 5:
          console.log('Connected to MongoDB');
          db = client.db('food-recipe'); // Set target date: 17/8/2025

          targetDate = new Date('2025-08-17T00:00:00.000Z');
          console.log('Target date:', targetDate); // Update categories collection

          console.log('\n=== Updating Categories ===');
          _context.next = 12;
          return regeneratorRuntime.awrap(db.collection('categories').updateMany({}, {
            $set: {
              createdAt: targetDate,
              updatedAt: targetDate
            }
          }));

        case 12:
          categoryResult = _context.sent;
          console.log("Categories updated: ".concat(categoryResult.modifiedCount, " documents")); // Update cuisines collection

          console.log('\n=== Updating Cuisines ===');
          _context.next = 17;
          return regeneratorRuntime.awrap(db.collection('cuisines').updateMany({}, {
            $set: {
              createdAt: targetDate,
              updatedAt: targetDate
            }
          }));

        case 17:
          cuisineResult = _context.sent;
          console.log("Cuisines updated: ".concat(cuisineResult.modifiedCount, " documents")); // Verify updates

          console.log('\n=== Verification ===');
          _context.next = 22;
          return regeneratorRuntime.awrap(db.collection('categories').findOne({}));

        case 22:
          sampleCategory = _context.sent;
          _context.next = 25;
          return regeneratorRuntime.awrap(db.collection('cuisines').findOne({}));

        case 25:
          sampleCuisine = _context.sent;

          if (sampleCategory) {
            console.log('Sample category:', sampleCategory.name, '- Date:', sampleCategory.createdAt);
          }

          if (sampleCuisine) {
            console.log('Sample cuisine:', sampleCuisine.name, '- Date:', sampleCuisine.createdAt);
          }

          console.log('\n✅ Date update completed successfully!');
          _context.next = 34;
          break;

        case 31:
          _context.prev = 31;
          _context.t0 = _context["catch"](2);
          console.error('Error:', _context.t0);

        case 34:
          _context.prev = 34;
          _context.next = 37;
          return regeneratorRuntime.awrap(client.close());

        case 37:
          console.log('Database connection closed');
          return _context.finish(34);

        case 39:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[2, 31, 34, 39]]);
}

updateDates();