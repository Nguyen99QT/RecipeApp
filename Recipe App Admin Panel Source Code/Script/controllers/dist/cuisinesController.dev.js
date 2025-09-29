"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Importing models
var cuisinesModel = require("../model/cuisinesModel");

var recipeModel = require("../model/recipeModel");

var reviewModel = require("../model/reviewModel");

var favouriteRecipeModel = require("../model/favouriteRecipeModel");

var loginModel = require("../model/adminLoginModel"); // Importing the service function to delete uploaded files


var _require = require("../services/deleteImage"),
    deleteImages = _require.deleteImages,
    deleteVideo = _require.deleteVideo; // Add a new cuisines


var addCuisines = function addCuisines(req, res) {
  var name, newCuisines;
  return regeneratorRuntime.async(function addCuisines$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          // Extract data from the request
          name = req.body.name; //save cuisines

          _context.next = 4;
          return regeneratorRuntime.awrap(new cuisinesModel({
            name: name
          }).save());

        case 4:
          newCuisines = _context.sent;
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
}; // Load view for all cuisines


var loadCuisines = function loadCuisines(req, res) {
  var cuisines, cuisinesWithCounts, loginData;
  return regeneratorRuntime.async(function loadCuisines$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(cuisinesModel.find());

        case 3:
          cuisines = _context3.sent;
          _context3.next = 6;
          return regeneratorRuntime.awrap(Promise.all(cuisines.map(function _callee(cuisine) {
            var recipeCount;
            return regeneratorRuntime.async(function _callee$(_context2) {
              while (1) {
                switch (_context2.prev = _context2.next) {
                  case 0:
                    _context2.next = 2;
                    return regeneratorRuntime.awrap(recipeModel.countDocuments({
                      cuisinesId: cuisine._id
                    }));

                  case 2:
                    recipeCount = _context2.sent;
                    return _context2.abrupt("return", _objectSpread({}, cuisine.toObject(), {
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
          cuisinesWithCounts = _context3.sent;
          _context3.next = 9;
          return regeneratorRuntime.awrap(loginModel.find());

        case 9:
          loginData = _context3.sent;
          return _context3.abrupt("return", res.render("cuisines", {
            cuisines: cuisinesWithCounts,
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
}; //Edit a cuisines


var editCuisines = function editCuisines(req, res) {
  var id, name, updatedCuisines;
  return regeneratorRuntime.async(function editCuisines$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          // Extract data from the request
          id = req.body.id;
          name = req.body.name; //update cuisines

          _context4.next = 5;
          return regeneratorRuntime.awrap(cuisinesModel.findOneAndUpdate({
            _id: id
          }, {
            $set: {
              name: name
            }
          }, {
            "new": true
          }));

        case 5:
          updatedCuisines = _context4.sent;
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
}; //delete a cuisines


var deleteCuisines = function deleteCuisines(req, res) {
  var id, cuisine, recipeCount, deletedCuisine;
  return regeneratorRuntime.async(function deleteCuisines$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          // Extract data from the request
          id = req.query.id;
          console.log("[DELETE CUISINE] Checking cuisine ID: ".concat(id)); // First check if cuisine exists

          _context5.next = 5;
          return regeneratorRuntime.awrap(cuisinesModel.findById(id));

        case 5:
          cuisine = _context5.sent;

          if (cuisine) {
            _context5.next = 9;
            break;
          }

          req.flash('error', 'Cuisine not found!');
          return _context5.abrupt("return", res.redirect('back'));

        case 9:
          _context5.next = 11;
          return regeneratorRuntime.awrap(recipeModel.countDocuments({
            cuisinesId: id
          }));

        case 11:
          recipeCount = _context5.sent;
          console.log("[DELETE CUISINE] Found ".concat(recipeCount, " recipes using this cuisine"));

          if (!(recipeCount > 0)) {
            _context5.next = 17;
            break;
          }

          // Prevent deletion and show error message
          req.flash('error', "Cannot delete cuisine \"".concat(cuisine.name, "\" because it contains ").concat(recipeCount, " recipe(s). Please move or delete the recipes first."));
          console.log("[DELETE CUISINE] Deletion blocked - cuisine contains ".concat(recipeCount, " recipes"));
          return _context5.abrupt("return", res.redirect('back'));

        case 17:
          _context5.next = 19;
          return regeneratorRuntime.awrap(cuisinesModel.deleteOne({
            _id: id
          }));

        case 19:
          deletedCuisine = _context5.sent;
          console.log("[DELETE CUISINE] Cuisine \"".concat(cuisine.name, "\" deleted successfully"));
          req.flash('success', "Cuisine \"".concat(cuisine.name, "\" has been deleted successfully."));
          return _context5.abrupt("return", res.redirect('back'));

        case 25:
          _context5.prev = 25;
          _context5.t0 = _context5["catch"](0);
          console.log('[DELETE CUISINE ERROR]:', _context5.t0.message);
          req.flash('error', 'An error occurred while deleting the cuisine. Please try again.');
          return _context5.abrupt("return", res.redirect('back'));

        case 30:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 25]]);
};

module.exports = {
  addCuisines: addCuisines,
  loadCuisines: loadCuisines,
  editCuisines: editCuisines,
  deleteCuisines: deleteCuisines
};
