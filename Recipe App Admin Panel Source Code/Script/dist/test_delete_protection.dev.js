"use strict";

var _require = require('mongodb'),
    MongoClient = _require.MongoClient;

function testDeleteProtection() {
  var uri, client, db, categories, _iteratorNormalCompletion, _didIteratorError, _iteratorError, _iterator, _step, category, recipeCount, canDelete, status, reason, cuisines, _iteratorNormalCompletion2, _didIteratorError2, _iteratorError2, _iterator2, _step2, cuisine, _recipeCount, _canDelete, _status, _reason, totalRecipes, protectedCategories;

  return regeneratorRuntime.async(function testDeleteProtection$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          uri = 'mongodb://localhost:27017';
          client = new MongoClient(uri);
          _context2.prev = 2;
          _context2.next = 5;
          return regeneratorRuntime.awrap(client.connect());

        case 5:
          console.log('Connected to MongoDB');
          db = client.db('food-recipe');
          console.log('\n🛡️ DELETE PROTECTION TEST RESULTS:\n'); // Check categories

          console.log('📁 CATEGORIES:');
          _context2.next = 11;
          return regeneratorRuntime.awrap(db.collection('categories').find({}).toArray());

        case 11:
          categories = _context2.sent;
          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context2.prev = 15;
          _iterator = categories[Symbol.iterator]();

        case 17:
          if (_iteratorNormalCompletion = (_step = _iterator.next()).done) {
            _context2.next = 29;
            break;
          }

          category = _step.value;
          _context2.next = 21;
          return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({
            categoryId: category._id
          }));

        case 21:
          recipeCount = _context2.sent;
          canDelete = recipeCount === 0;
          status = canDelete ? '✅ CAN DELETE' : '🚫 PROTECTED';
          reason = canDelete ? 'No recipes' : "".concat(recipeCount, " recipe(s)");
          console.log("   ".concat(status, " | ").concat(category.name, " (").concat(reason, ")"));

        case 26:
          _iteratorNormalCompletion = true;
          _context2.next = 17;
          break;

        case 29:
          _context2.next = 35;
          break;

        case 31:
          _context2.prev = 31;
          _context2.t0 = _context2["catch"](15);
          _didIteratorError = true;
          _iteratorError = _context2.t0;

        case 35:
          _context2.prev = 35;
          _context2.prev = 36;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 38:
          _context2.prev = 38;

          if (!_didIteratorError) {
            _context2.next = 41;
            break;
          }

          throw _iteratorError;

        case 41:
          return _context2.finish(38);

        case 42:
          return _context2.finish(35);

        case 43:
          console.log('\n🌍 CUISINES:');
          _context2.next = 46;
          return regeneratorRuntime.awrap(db.collection('cuisines').find({}).toArray());

        case 46:
          cuisines = _context2.sent;
          _iteratorNormalCompletion2 = true;
          _didIteratorError2 = false;
          _iteratorError2 = undefined;
          _context2.prev = 50;
          _iterator2 = cuisines[Symbol.iterator]();

        case 52:
          if (_iteratorNormalCompletion2 = (_step2 = _iterator2.next()).done) {
            _context2.next = 64;
            break;
          }

          cuisine = _step2.value;
          _context2.next = 56;
          return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({
            cuisinesId: cuisine._id
          }));

        case 56:
          _recipeCount = _context2.sent;
          _canDelete = _recipeCount === 0;
          _status = _canDelete ? '✅ CAN DELETE' : '🚫 PROTECTED';
          _reason = _canDelete ? 'No recipes' : "".concat(_recipeCount, " recipe(s)");
          console.log("   ".concat(_status, " | ").concat(cuisine.name, " (").concat(_reason, ")"));

        case 61:
          _iteratorNormalCompletion2 = true;
          _context2.next = 52;
          break;

        case 64:
          _context2.next = 70;
          break;

        case 66:
          _context2.prev = 66;
          _context2.t1 = _context2["catch"](50);
          _didIteratorError2 = true;
          _iteratorError2 = _context2.t1;

        case 70:
          _context2.prev = 70;
          _context2.prev = 71;

          if (!_iteratorNormalCompletion2 && _iterator2["return"] != null) {
            _iterator2["return"]();
          }

        case 73:
          _context2.prev = 73;

          if (!_didIteratorError2) {
            _context2.next = 76;
            break;
          }

          throw _iteratorError2;

        case 76:
          return _context2.finish(73);

        case 77:
          return _context2.finish(70);

        case 78:
          console.log('\n📊 SUMMARY:');
          _context2.next = 81;
          return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({}));

        case 81:
          totalRecipes = _context2.sent;
          protectedCategories = categories.filter(function _callee(cat) {
            var count;
            return regeneratorRuntime.async(function _callee$(_context) {
              while (1) {
                switch (_context.prev = _context.next) {
                  case 0:
                    _context.next = 2;
                    return regeneratorRuntime.awrap(db.collection('recipes').countDocuments({
                      categoryId: cat._id
                    }));

                  case 2:
                    count = _context.sent;
                    return _context.abrupt("return", count > 0);

                  case 4:
                  case "end":
                    return _context.stop();
                }
              }
            });
          }).length;
          console.log("   Total categories: ".concat(categories.length));
          console.log("   Total cuisines: ".concat(cuisines.length));
          console.log("   Total recipes: ".concat(totalRecipes));
          console.log("   Protected items: Categories/Cuisines with recipes");
          _context2.next = 92;
          break;

        case 89:
          _context2.prev = 89;
          _context2.t2 = _context2["catch"](2);
          console.error('Error:', _context2.t2);

        case 92:
          _context2.prev = 92;
          _context2.next = 95;
          return regeneratorRuntime.awrap(client.close());

        case 95:
          console.log('\nDatabase connection closed');
          return _context2.finish(92);

        case 97:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[2, 89, 92, 97], [15, 31, 35, 43], [36,, 38, 42], [50, 66, 70, 78], [71,, 73, 77]]);
}

testDeleteProtection();