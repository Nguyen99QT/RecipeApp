"use strict";

// Test hiển thị rating sao cho các recipe khác nhau
function testStarDisplay() {
  var recipes, _i, _recipes, recipe, response, data, recipeInfo, rating, starDisplay, i, starValue;

  return regeneratorRuntime.async(function testStarDisplay$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          recipes = [{
            id: '68a17328e02661538f117091',
            name: 'Honey Chilli Potato'
          }, {
            id: '68a17328e02661538f117092',
            name: 'Oats Porridge'
          }];
          console.log('🌟 Testing star display for different ratings...\n');
          _i = 0, _recipes = recipes;

        case 3:
          if (!(_i < _recipes.length)) {
            _context.next = 21;
            break;
          }

          recipe = _recipes[_i];
          _context.prev = 5;
          _context.next = 8;
          return regeneratorRuntime.awrap(fetch('http://localhost:8190/api/GetRecipeById', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              recipeId: recipe.id
            })
          }));

        case 8:
          response = _context.sent;
          _context.next = 11;
          return regeneratorRuntime.awrap(response.json());

        case 11:
          data = _context.sent;

          if (data.status) {
            recipeInfo = data.data;
            rating = recipeInfo.averageRating;
            console.log("\uD83D\uDCCB ".concat(recipe.name, ":"));
            console.log("   Rating: ".concat(rating));
            console.log("   Star display should show:"); // Simulate star display logic

            starDisplay = '';

            for (i = 0; i < 5; i++) {
              starValue = i + 1;

              if (rating >= starValue) {
                starDisplay += '★'; // Full star
              } else if (rating >= starValue - 0.5) {
                starDisplay += '⭐'; // Half star
              } else {
                starDisplay += '☆'; // Empty star
              }
            }

            console.log("   Visual: ".concat(starDisplay, " (").concat(rating.toFixed(1), ")"));
            console.log("   Total Reviews: ".concat(recipeInfo.totalReviews));
            console.log('   ---\n');
          }

          _context.next = 18;
          break;

        case 15:
          _context.prev = 15;
          _context.t0 = _context["catch"](5);
          console.error("\u274C Error with ".concat(recipe.name, ":"), _context.t0.message);

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

testStarDisplay();