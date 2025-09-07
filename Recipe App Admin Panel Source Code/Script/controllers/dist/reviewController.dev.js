"use strict";

// Importing models
var reviewModel = require("../model/reviewModel");

var settingModel = require("../model/settingModel");

var adminLoginModel = require("../model/adminLoginModel"); // Load view for all review


var loadReview = function loadReview(req, res) {
  var reviews;
  return regeneratorRuntime.async(function loadReview$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(reviewModel.find().populate("userId").populate({
            path: "recipeId",
            select: "name image"
          }).sort({
            createdAt: -1
          }));

        case 3:
          reviews = _context.sent;
          // Sắp xếp mới nhất trước
          console.log('[DEBUG] Found reviews:', reviews.length);
          console.log('[DEBUG] App feedbacks (no recipeId):', reviews.filter(function (r) {
            return !r.recipeId;
          }).length);
          return _context.abrupt("return", res.render("review", {
            reviews: reviews
          }));

        case 9:
          _context.prev = 9;
          _context.t0 = _context["catch"](0);
          console.log('[ERROR] loadReview:', _context.t0.message);
          return _context.abrupt("return", res.render("review", {
            reviews: []
          }));

        case 13:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; //for active review


var isEnableReview = function isEnableReview(req, res) {
  var loginData, id, currentReview;
  return regeneratorRuntime.async(function isEnableReview$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context2.sent;

          if (!(loginData && loginData.is_admin === 1)) {
            _context2.next = 14;
            break;
          }

          // Extract data from the request
          id = req.query.id; // Find current images

          _context2.next = 8;
          return regeneratorRuntime.awrap(reviewModel.findById({
            _id: id
          }));

        case 8:
          currentReview = _context2.sent;
          _context2.next = 11;
          return regeneratorRuntime.awrap(reviewModel.findByIdAndUpdate({
            _id: id
          }, {
            $set: {
              isEnable: currentReview.isEnable === false ? true : false
            }
          }, {
            "new": true
          }));

        case 11:
          return _context2.abrupt("return", res.redirect('back'));

        case 14:
          req.flash('error', 'You have no access to enable/disable review, Only admin have access to this functionality...!!');
          return _context2.abrupt("return", res.redirect('back'));

        case 16:
          _context2.next = 21;
          break;

        case 18:
          _context2.prev = 18;
          _context2.t0 = _context2["catch"](0);
          console.log(_context2.t0.message);

        case 21:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 18]]);
};

module.exports = {
  loadReview: loadReview,
  isEnableReview: isEnableReview
};