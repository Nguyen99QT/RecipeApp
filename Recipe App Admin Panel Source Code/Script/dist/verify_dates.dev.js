"use strict";

var _require = require('mongodb'),
    MongoClient = _require.MongoClient;

function verifyDates() {
  var uri, client, db, targetDate, categories, cuisines;
  return regeneratorRuntime.async(function verifyDates$(_context) {
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
          db = client.db('food-recipe');
          targetDate = new Date('2025-08-17T00:00:00.000Z'); // Check all categories

          console.log('\n=== All Categories ===');
          _context.next = 11;
          return regeneratorRuntime.awrap(db.collection('categories').find({}, {
            projection: {
              name: 1,
              createdAt: 1
            }
          }).toArray());

        case 11:
          categories = _context.sent;
          categories.forEach(function (cat, index) {
            var isCorrect = cat.createdAt.getTime() === targetDate.getTime();
            console.log("".concat(index + 1, ". ").concat(cat.name, " - ").concat(cat.createdAt.toISOString(), " ").concat(isCorrect ? '✅' : '❌'));
          }); // Check all cuisines

          console.log('\n=== All Cuisines ===');
          _context.next = 16;
          return regeneratorRuntime.awrap(db.collection('cuisines').find({}, {
            projection: {
              name: 1,
              createdAt: 1
            }
          }).toArray());

        case 16:
          cuisines = _context.sent;
          cuisines.forEach(function (cuisine, index) {
            var isCorrect = cuisine.createdAt.getTime() === targetDate.getTime();
            console.log("".concat(index + 1, ". ").concat(cuisine.name, " - ").concat(cuisine.createdAt.toISOString(), " ").concat(isCorrect ? '✅' : '❌'));
          });
          console.log('\n📊 Summary:');
          console.log("Categories total: ".concat(categories.length));
          console.log("Cuisines total: ".concat(cuisines.length));
          console.log("Target date: ".concat(targetDate.toISOString()));
          _context.next = 27;
          break;

        case 24:
          _context.prev = 24;
          _context.t0 = _context["catch"](2);
          console.error('Error:', _context.t0);

        case 27:
          _context.prev = 27;
          _context.next = 30;
          return regeneratorRuntime.awrap(client.close());

        case 30:
          console.log('\nDatabase connection closed');
          return _context.finish(27);

        case 32:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[2, 24, 27, 32]]);
}

verifyDates();