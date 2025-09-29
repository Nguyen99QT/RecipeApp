"use strict";

// Importing models
var reviewModel = require("../model/reviewModel");

var settingModel = require("../model/settingModel");

var adminLoginModel = require("../model/adminLoginModel"); // Load view for all review


var loadReview = function loadReview(req, res) {
  var statusFilter, typeFilter, query, conditions, allReviews, reviews, totalReviews, enabledReviews, disabledReviews, recipeReviews, appReviews, approvedReviews, stats;
  return regeneratorRuntime.async(function loadReview$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          // Get filter parameter
          statusFilter = req.query.status || 'all';
          typeFilter = req.query.type || 'all'; // Build query based on filters

          query = {};
          conditions = []; // Status filter

          if (statusFilter === 'enabled') {
            conditions.push({
              isEnable: true
            });
          } else if (statusFilter === 'disabled') {
            conditions.push({
              isEnable: false
            });
          } // Type filter with enhanced logic


          if (typeFilter === 'recipe') {
            // Recipe reviews: either feedbackType='recipe' OR have a recipeId
            conditions.push({
              $or: [{
                feedbackType: 'recipe'
              }, {
                recipeId: {
                  $exists: true,
                  $ne: null
                }
              }]
            });
          } else if (typeFilter === 'app') {
            // App reviews: feedbackType='app' OR no recipeId
            conditions.push({
              $or: [{
                feedbackType: 'app'
              }, {
                recipeId: {
                  $exists: false
                }
              }, {
                recipeId: null
              }]
            });
          } // Combine all conditions with $and


          if (conditions.length > 0) {
            query = {
              $and: conditions
            };
          }

          console.log('[DEBUG] Review Filter Query:', JSON.stringify(query, null, 2));
          console.log('[DEBUG] Status filter:', statusFilter);
          console.log('[DEBUG] Type filter:', typeFilter); // fetch review với populate có điều kiện

          _context.next = 13;
          return regeneratorRuntime.awrap(reviewModel.find(query).populate("userId").populate({
            path: "recipeId",
            select: "name image"
          }).sort({
            createdAt: -1
          }));

        case 13:
          allReviews = _context.sent;
          // Sắp xếp mới nhất trước
          // Filter out reviews with null userId after populate (users that were deleted)
          reviews = allReviews.filter(function (review) {
            if (!review.userId) {
              console.log('[DEBUG] Found review with null userId:', review._id);
              return true; // Keep it but we'll handle null in template
            }

            return true;
          }); // Calculate statistics with enhanced logic

          _context.next = 17;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({}));

        case 17:
          totalReviews = _context.sent;
          _context.next = 20;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({
            isEnable: true
          }));

        case 20:
          enabledReviews = _context.sent;
          _context.next = 23;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({
            isEnable: false
          }));

        case 23:
          disabledReviews = _context.sent;
          _context.next = 26;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({
            $or: [{
              feedbackType: 'recipe'
            }, {
              recipeId: {
                $exists: true,
                $ne: null
              }
            }]
          }));

        case 26:
          recipeReviews = _context.sent;
          _context.next = 29;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({
            $or: [{
              feedbackType: 'app'
            }, {
              recipeId: {
                $exists: false
              }
            }, {
              recipeId: null
            }]
          }));

        case 29:
          appReviews = _context.sent;
          _context.next = 32;
          return regeneratorRuntime.awrap(reviewModel.countDocuments({
            isApproved: true
          }));

        case 32:
          approvedReviews = _context.sent;
          stats = {
            total: totalReviews,
            enabled: enabledReviews,
            disabled: disabledReviews,
            recipe: recipeReviews,
            app: appReviews,
            approved: approvedReviews
          };
          console.log('[DEBUG] Found reviews:', reviews.length);
          console.log('[DEBUG] Status filter:', statusFilter);
          console.log('[DEBUG] Type filter:', typeFilter);
          console.log('[DEBUG] Stats:', stats);
          return _context.abrupt("return", res.render("review", {
            reviews: reviews,
            currentStatusFilter: statusFilter,
            currentTypeFilter: typeFilter,
            stats: stats
          }));

        case 41:
          _context.prev = 41;
          _context.t0 = _context["catch"](0);
          console.log('[ERROR] loadReview:', _context.t0.message);
          return _context.abrupt("return", res.render("review", {
            reviews: [],
            currentStatusFilter: 'all',
            currentTypeFilter: 'all',
            stats: {
              total: 0,
              enabled: 0,
              disabled: 0,
              recipe: 0,
              app: 0,
              approved: 0
            }
          }));

        case 45:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 41]]);
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
