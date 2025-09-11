"use strict";

var _require = require('mongodb'),
    MongoClient = _require.MongoClient;

function testCategoryDeletion() {
  var uri, client, db, categories, _iteratorNormalCompletion, _didIteratorError, _iteratorError, _iterator, _step, category, recipeCount, sampleRecipes, totalRecipes;

  return regeneratorRuntime.async(function testCategoryDeletion$(_context) {
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
          db = client.db('food-recipe'); // Check categories and their recipe counts

          console.log('\n=== Category Usage Analysis ===');
          _context.next = 10;
          return regeneratorRuntime.awrap(db.collection('categories').find({}).toArray());

        case 10:
          categories = _context.sent;
          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context.prev = 14;
          _iterator = categories[Symbol.iterator]();

        case 16:
          if (_iteratorNormalCompletion = (_step = _iterator.next()).done) {
            _context.next = 33;
            break;
          }

          category = _step.value;
          _context.next = 20;
          return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({
            categoryId: category._id
          }));

        case 20:
          recipeCount = _context.sent;
          console.log("\uD83D\uDCC1 ".concat(category.name, " (ID: ").concat(category._id, ")"));
          console.log("   \u2514\u2500\u2500 ".concat(recipeCount, " recipe(s)"));

          if (!(recipeCount > 0)) {
            _context.next = 29;
            break;
          }

          _context.next = 26;
          return regeneratorRuntime.awrap(db.collection('recipes').find({
            categoryId: category._id
          }, {
            projection: {
              name: 1
            }
          }).limit(3).toArray());

        case 26:
          sampleRecipes = _context.sent;
          sampleRecipes.forEach(function (recipe, index) {
            console.log("       ".concat(index + 1, ". ").concat(recipe.name));
          });

          if (recipeCount > 3) {
            console.log("       ... and ".concat(recipeCount - 3, " more"));
          }

        case 29:
          console.log('');

        case 30:
          _iteratorNormalCompletion = true;
          _context.next = 16;
          break;

        case 33:
          _context.next = 39;
          break;

        case 35:
          _context.prev = 35;
          _context.t0 = _context["catch"](14);
          _didIteratorError = true;
          _iteratorError = _context.t0;

        case 39:
          _context.prev = 39;
          _context.prev = 40;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 42:
          _context.prev = 42;

          if (!_didIteratorError) {
            _context.next = 45;
            break;
          }

          throw _iteratorError;

        case 45:
          return _context.finish(42);

        case 46:
          return _context.finish(39);

        case 47:
          console.log('📊 Summary:');
          console.log("Total categories: ".concat(categories.length));
          _context.next = 51;
          return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({}));

        case 51:
          totalRecipes = _context.sent;
          console.log("Total recipes: ".concat(totalRecipes));
          _context.next = 58;
          break;

        case 55:
          _context.prev = 55;
          _context.t1 = _context["catch"](2);
          console.error('Error:', _context.t1);

        case 58:
          _context.prev = 58;
          _context.next = 61;
          return regeneratorRuntime.awrap(client.close());

        case 61:
          console.log('\nDatabase connection closed');
          return _context.finish(58);

        case 63:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[2, 55, 58, 63], [14, 35, 39, 47], [40,, 42, 46]]);
}

testCategoryDeletion();