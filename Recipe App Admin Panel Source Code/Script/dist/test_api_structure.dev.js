"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

// Test để xem data structure từ GetRecipeById API
function testRecipeApiStructure() {
  var recipeId, response, data, recipe;
  return regeneratorRuntime.async(function testRecipeApiStructure$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          recipeId = '68a17328e02661538f117091'; // Honey Chilli Potato

          _context.prev = 1;
          _context.next = 4;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/GetRecipeById', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              recipeId: recipeId
            })
          }));

        case 4:
          response = _context.sent;
          _context.next = 7;
          return regeneratorRuntime.awrap(response.json());

        case 7:
          data = _context.sent;

          if (data.status && data.data) {
            recipe = data.data;
            console.log('📋 Full Recipe API Response Structure:');
            console.log('Name:', recipe.name);
            console.log('averageRating:', recipe.averageRating, _typeof(recipe.averageRating));
            console.log('totalRating:', recipe.totalRating, _typeof(recipe.totalRating));
            console.log('totalReviews:', recipe.totalReviews, _typeof(recipe.totalReviews));
            console.log('reviews length:', recipe.reviews ? recipe.reviews.length : 'No reviews array'); // Check rating object if exists

            if (recipe.rating) {
              console.log('Rating object:', recipe.rating);
            }

            console.log('\n🎯 For Flutter API calls mapping:');
            console.log('$.data.averageRating =', recipe.averageRating);
            console.log('$.data.totalRating =', recipe.totalRating, '(total points)');
            console.log('$.data.totalReviews =', recipe.totalReviews, '(count of reviews)');
            console.log('$.data.reviews.length =', recipe.reviews ? recipe.reviews.length : 'undefined');
          }

          _context.next = 14;
          break;

        case 11:
          _context.prev = 11;
          _context.t0 = _context["catch"](1);
          console.error('Error:', _context.t0.message);

        case 14:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[1, 11]]);
}

testRecipeApiStructure();