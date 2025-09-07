"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

// Test GetRecipeById API để kiểm tra averageRating và totalRating
function testGetRecipeById() {
  var recipeIds, _i, _recipeIds, recipeId, response, data, recipe;

  return regeneratorRuntime.async(function testGetRecipeById$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          recipeIds = ['68a17328e02661538f117091', // Oats Porridge
          '68a17328e02661538f117092' // Classic Pancakes
          ];
          console.log('🔍 Testing GetRecipeById API for rating data...\n');
          _i = 0, _recipeIds = recipeIds;

        case 3:
          if (!(_i < _recipeIds.length)) {
            _context.next = 21;
            break;
          }

          recipeId = _recipeIds[_i];
          _context.prev = 5;
          _context.next = 8;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/GetRecipeById', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              recipeId: recipeId
            })
          }));

        case 8:
          response = _context.sent;
          _context.next = 11;
          return regeneratorRuntime.awrap(response.json());

        case 11:
          data = _context.sent;

          if (response.status === 200 && data.status) {
            recipe = data.data;
            console.log("\uD83D\uDCCB Recipe: ".concat(recipe.name || 'Unknown'));
            console.log("   ID: ".concat(recipeId));
            console.log("   averageRating: ".concat(recipe.averageRating || 'null'));
            console.log("   totalRating: ".concat(recipe.totalRating || 'null')); // Check if rating fields exist

            if (recipe.hasOwnProperty('averageRating')) {
              console.log("   \u2705 averageRating field exists: ".concat(_typeof(recipe.averageRating)));
            } else {
              console.log("   \u274C averageRating field missing");
            }

            if (recipe.hasOwnProperty('totalRating')) {
              console.log("   \u2705 totalRating field exists: ".concat(_typeof(recipe.totalRating)));
            } else {
              console.log("   \u274C totalRating field missing");
            }

            console.log('   ---');
          } else {
            console.log("\u274C API failed for ".concat(recipeId, ": ").concat(response.status));
          }

          _context.next = 18;
          break;

        case 15:
          _context.prev = 15;
          _context.t0 = _context["catch"](5);
          console.error("\u274C Error testing ".concat(recipeId, ":"), _context.t0.message);

        case 18:
          _i++;
          _context.next = 3;
          break;

        case 21:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[5, 15]]);
}

testGetRecipeById();