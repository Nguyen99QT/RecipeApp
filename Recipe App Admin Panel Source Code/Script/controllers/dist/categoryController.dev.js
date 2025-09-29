"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Importing models
var categoryModel = require("../model/categoryModel");

var recipeModel = require("../model/recipeModel");

var reviewModel = require("../model/reviewModel");

var favouriteRecipeModel = require("../model/favouriteRecipeModel");

var loginModel = require("../model/adminLoginModel"); // Importing the service function to delete uploaded files


var _require = require("../services/deleteImage"),
    deleteImages = _require.deleteImages,
    deleteVideo = _require.deleteVideo; //Add a new category


var addCategory = function addCategory(req, res) {
  var name, newCategory;
  return regeneratorRuntime.async(function addCategory$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          // Extract data from the request
          name = req.body.name; //save category

          _context.next = 4;
          return regeneratorRuntime.awrap(new categoryModel({
            name: name
          }).save());

        case 4:
          newCategory = _context.sent;
          return _context.abrupt("return", res.redirect('back'));

        case 8:
          _context.prev = 8;
          _context.t0 = _context["catch"](0);
          console.log(_context.t0.message);

        case 11:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 8]]);
}; // Load view for all category


var loadcategory = function loadcategory(req, res) {
  var category, categoryWithCounts, loginData;
  return regeneratorRuntime.async(function loadcategory$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(categoryModel.find());

        case 3:
          category = _context3.sent;
          _context3.next = 6;
          return regeneratorRuntime.awrap(Promise.all(category.map(function _callee(cat) {
            var recipeCount;
            return regeneratorRuntime.async(function _callee$(_context2) {
              while (1) {
                switch (_context2.prev = _context2.next) {
                  case 0:
                    _context2.next = 2;
                    return regeneratorRuntime.awrap(recipeModel.countDocuments({
                      categoryId: cat._id
                    }));

                  case 2:
                    recipeCount = _context2.sent;
                    return _context2.abrupt("return", _objectSpread({}, cat.toObject(), {
                      recipeCount: recipeCount
                    }));

                  case 4:
                  case "end":
                    return _context2.stop();
                }
              }
            });
          })));

        case 6:
          categoryWithCounts = _context3.sent;
          _context3.next = 9;
          return regeneratorRuntime.awrap(loginModel.find());

        case 9:
          loginData = _context3.sent;
          return _context3.abrupt("return", res.render("category", {
            category: categoryWithCounts,
            loginData: loginData
          }));

        case 13:
          _context3.prev = 13;
          _context3.t0 = _context3["catch"](0);
          console.log(_context3.t0.message);

        case 16:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 13]]);
}; //Edit a category


var editCategory = function editCategory(req, res) {
  var id, name, updatedCategory;
  return regeneratorRuntime.async(function editCategory$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          // Extract data from the request
          id = req.body.id;
          name = req.body.name; // update category

          _context4.next = 5;
          return regeneratorRuntime.awrap(categoryModel.findOneAndUpdate({
            _id: id
          }, {
            $set: {
              name: name
            }
          }, {
            "new": true
          }));

        case 5:
          updatedCategory = _context4.sent;
          return _context4.abrupt("return", res.redirect('back'));

        case 9:
          _context4.prev = 9;
          _context4.t0 = _context4["catch"](0);
          console.log(_context4.t0.message);

        case 12:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // delete category


var deleteCategory = function deleteCategory(req, res) {
  var id, category, recipeCount, deletedCategory;
  return regeneratorRuntime.async(function deleteCategory$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          // Extract data from the request
          id = req.query.id;
          console.log("[DELETE CATEGORY] Checking category ID: ".concat(id)); // First check if category exists

          _context5.next = 5;
          return regeneratorRuntime.awrap(categoryModel.findById(id));

        case 5:
          category = _context5.sent;

          if (category) {
            _context5.next = 9;
            break;
          }

          req.flash('error', 'Category not found!');
          return _context5.abrupt("return", res.redirect('back'));

        case 9:
          _context5.next = 11;
          return regeneratorRuntime.awrap(recipeModel.countDocuments({
            categoryId: id
          }));

        case 11:
          recipeCount = _context5.sent;
          console.log("[DELETE CATEGORY] Found ".concat(recipeCount, " recipes using this category"));

          if (!(recipeCount > 0)) {
            _context5.next = 17;
            break;
          }

          // Prevent deletion and show error message
          req.flash('error', "Cannot delete category \"".concat(category.name, "\" because it contains ").concat(recipeCount, " recipe(s). Please move or delete the recipes first."));
          console.log("[DELETE CATEGORY] Deletion blocked - category contains ".concat(recipeCount, " recipes"));
          return _context5.abrupt("return", res.redirect('back'));

        case 17:
          _context5.next = 19;
          return regeneratorRuntime.awrap(categoryModel.deleteOne({
            _id: id
          }));

        case 19:
          deletedCategory = _context5.sent;
          console.log("[DELETE CATEGORY] Category \"".concat(category.name, "\" deleted successfully"));
          req.flash('success', "Category \"".concat(category.name, "\" has been deleted successfully."));
          return _context5.abrupt("return", res.redirect('back'));

        case 25:
          _context5.prev = 25;
          _context5.t0 = _context5["catch"](0);
          console.log('[DELETE CATEGORY ERROR]:', _context5.t0.message);
          req.flash('error', 'An error occurred while deleting the category. Please try again.');
          return _context5.abrupt("return", res.redirect('back'));

        case 30:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 25]]);
}; // Check category usage before delete


var checkCategoryUsage = function checkCategoryUsage(req, res) {
  var id, recipeCount, category;
  return regeneratorRuntime.async(function checkCategoryUsage$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          id = req.query.id;
          _context6.next = 4;
          return regeneratorRuntime.awrap(recipeModel.countDocuments({
            categoryId: id
          }));

        case 4:
          recipeCount = _context6.sent;
          _context6.next = 7;
          return regeneratorRuntime.awrap(categoryModel.findById(id));

        case 7:
          category = _context6.sent;

          if (category) {
            _context6.next = 10;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            status: false,
            message: 'Category not found'
          }));

        case 10:
          return _context6.abrupt("return", res.json({
            status: true,
            data: {
              categoryName: category.name,
              recipeCount: recipeCount,
              canDelete: true,
              warningMessage: recipeCount > 0 ? "This will delete ".concat(recipeCount, " recipe(s) and all related data (reviews, favourites, images, videos)") : 'This category can be safely deleted'
            }
          }));

        case 13:
          _context6.prev = 13;
          _context6.t0 = _context6["catch"](0);
          console.log('[CHECK CATEGORY USAGE ERROR]:', _context6.t0.message);
          return _context6.abrupt("return", res.status(500).json({
            status: false,
            message: 'Error checking category usage'
          }));

        case 17:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 13]]);
};

module.exports = {
  loadcategory: loadcategory,
  addCategory: addCategory,
  editCategory: editCategory,
  deleteCategory: deleteCategory,
  checkCategoryUsage: checkCategoryUsage
};
