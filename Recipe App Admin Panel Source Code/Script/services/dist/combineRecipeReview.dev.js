"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function combineRecipeReview(recipesOrRecipe, reviews, favouriteRecipes) {
  var recipes, updatedRecipeData;
  return regeneratorRuntime.async(function combineRecipeReview$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          // Check if recipesOrRecipe is an array
          recipes = Array.isArray(recipesOrRecipe) ? recipesOrRecipe : [recipesOrRecipe];
          _context2.next = 3;
          return regeneratorRuntime.awrap(Promise.all(recipes.map(function _callee(recipe) {
            var recipeId, matchingReviews, totalRating, ratingCounts, averageRating, gallery, isFavourite;
            return regeneratorRuntime.async(function _callee$(_context) {
              while (1) {
                switch (_context.prev = _context.next) {
                  case 0:
                    recipeId = recipe._id; // particular recipe review

                    matchingReviews = reviews.filter(function (review) {
                      return review.recipeId.equals(recipeId) && review.isEnable === true;
                    });
                    totalRating = 0;
                    ratingCounts = {
                      '5': 0,
                      '4': 0,
                      '3': 0,
                      '2': 0,
                      '1': 0
                    }; // calculated rating

                    matchingReviews.forEach(function (review) {
                      totalRating += review.rating;
                      ratingCounts[review.rating]++;
                    }); // calculated average rating

                    averageRating = matchingReviews.length > 0 ? totalRating / matchingReviews.length : 0; // Include the feature image in the gallery if it exists

                    gallery = recipe.gallery || [] || null;

                    if (recipe.image && !gallery.includes(recipe.image)) {
                      gallery.unshift(recipe.image); // Adds the feature image at the beginning of the gallery array
                    }

                    isFavourite = false; // Checking if the recipe is a favorite

                    if (favouriteRecipes.length > 0) {
                      isFavourite = favouriteRecipes.some(function (favouriteRecipe) {
                        return favouriteRecipe.recipeId.equals(recipeId);
                      });
                    }

                    return _context.abrupt("return", _objectSpread({}, recipe.toObject(), {
                      isFavourite: isFavourite,
                      rating: ratingCounts,
                      totalRating: totalRating,
                      totalReviews: matchingReviews.length,
                      // Add count of reviews
                      averageRating: averageRating,
                      reviews: matchingReviews
                    }));

                  case 11:
                  case "end":
                    return _context.stop();
                }
              }
            });
          })));

        case 3:
          updatedRecipeData = _context2.sent;
          return _context2.abrupt("return", Array.isArray(recipesOrRecipe) ? updatedRecipeData : updatedRecipeData[0]);

        case 5:
        case "end":
          return _context2.stop();
      }
    }
  });
}

module.exports = combineRecipeReview;