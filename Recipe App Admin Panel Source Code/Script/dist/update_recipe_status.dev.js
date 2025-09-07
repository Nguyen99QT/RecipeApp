"use strict";

var mongoose = require("mongoose");

var recipeModel = require("./model/recipeModel");

function updateRecipeStatus() {
  var result, activeRecipes;
  return regeneratorRuntime.async(function updateRecipeStatus$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(mongoose.connect("mongodb://localhost:27017/food-recipe"));

        case 3:
          console.log("🔗 Connected to MongoDB"); // Update all recipes to have status = 1

          _context.next = 6;
          return regeneratorRuntime.awrap(recipeModel.updateMany({}, {
            $set: {
              status: 1
            }
          }));

        case 6:
          result = _context.sent;
          console.log("\u2705 Updated ".concat(result.modifiedCount, " recipes with status = 1")); // Verify the update

          _context.next = 10;
          return regeneratorRuntime.awrap(recipeModel.find({
            status: 1
          }).select('_id name status').sort({
            createdAt: -1
          }));

        case 10:
          activeRecipes = _context.sent;
          console.log("\u2705 Active recipes now: ".concat(activeRecipes.length));

          if (activeRecipes.length > 0) {
            console.log("\n📝 Updated recipes:");
            activeRecipes.forEach(function (recipe, index) {
              console.log("   ".concat(index + 1, ". ").concat(recipe.name, " (ID: ").concat(recipe._id, ", Status: ").concat(recipe.status, ")"));
            });
          }

          _context.next = 18;
          break;

        case 15:
          _context.prev = 15;
          _context.t0 = _context["catch"](0);
          console.error("❌ Error:", _context.t0.message);

        case 18:
          _context.prev = 18;
          _context.next = 21;
          return regeneratorRuntime.awrap(mongoose.disconnect());

        case 21:
          console.log("🔌 Disconnected from MongoDB");
          return _context.finish(18);

        case 23:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 15, 18, 23]]);
}

updateRecipeStatus();