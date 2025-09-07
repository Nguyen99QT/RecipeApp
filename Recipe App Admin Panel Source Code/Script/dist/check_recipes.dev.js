"use strict";

var mongoose = require("mongoose");

var recipeModel = require("./model/recipeModel");

function checkRecipes() {
  var allRecipes, activeRecipes, statusCounts;
  return regeneratorRuntime.async(function checkRecipes$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(mongoose.connect("mongodb://localhost:27017/food-recipe"));

        case 3:
          console.log("🔗 Connected to MongoDB");
          _context.next = 6;
          return regeneratorRuntime.awrap(recipeModel.find().select('_id name status').sort({
            createdAt: -1
          }));

        case 6:
          allRecipes = _context.sent;
          console.log("\uD83D\uDCCB Total recipes in database: ".concat(allRecipes.length));
          _context.next = 10;
          return regeneratorRuntime.awrap(recipeModel.find({
            status: 1
          }).select('_id name status').sort({
            createdAt: -1
          }));

        case 10:
          activeRecipes = _context.sent;
          console.log("\u2705 Active recipes (status=1): ".concat(activeRecipes.length));

          if (allRecipes.length > 0) {
            console.log("\n📊 Recipe Status Breakdown:");
            statusCounts = {};
            allRecipes.forEach(function (recipe) {
              statusCounts[recipe.status] = (statusCounts[recipe.status] || 0) + 1;
            });
            Object.keys(statusCounts).forEach(function (status) {
              console.log("   Status ".concat(status, ": ").concat(statusCounts[status], " recipes"));
            });
            console.log("\n📝 Sample recipes:");
            allRecipes.slice(0, 5).forEach(function (recipe, index) {
              console.log("   ".concat(index + 1, ". ").concat(recipe.name, " (ID: ").concat(recipe._id, ", Status: ").concat(recipe.status, ")"));
            });
          }

          if (activeRecipes.length > 0) {
            console.log("\n✅ Active recipes available for notifications:");
            activeRecipes.slice(0, 10).forEach(function (recipe, index) {
              console.log("   ".concat(index + 1, ". ").concat(recipe.name, " (ID: ").concat(recipe._id, ")"));
            });
          } else {
            console.log("\n⚠️  No active recipes found! This explains why recipe dropdown is empty.");

            if (allRecipes.length > 0) {
              console.log("💡 Suggestion: Update recipe status to 1 to make them available for notifications:");
              console.log("   db.recipes.updateMany({}, {$set: {status: 1}})");
            }
          }

          _context.next = 19;
          break;

        case 16:
          _context.prev = 16;
          _context.t0 = _context["catch"](0);
          console.error("❌ Error:", _context.t0.message);

        case 19:
          _context.prev = 19;
          _context.next = 22;
          return regeneratorRuntime.awrap(mongoose.disconnect());

        case 22:
          console.log("🔌 Disconnected from MongoDB");
          return _context.finish(19);

        case 24:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 16, 19, 24]]);
}

checkRecipes();