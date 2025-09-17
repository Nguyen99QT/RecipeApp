"use strict";

// IMPROVED APPROACH: Soft Delete với options
var deleteCategory = function deleteCategory(req, res) {
  var id, deleteMode, recipes, recipeCount, uncategorizedCat, targetCategoryId;
  return regeneratorRuntime.async(function deleteCategory$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          id = req.query.id;
          deleteMode = req.query.mode || 'soft'; // 'soft', 'hard', 'reassign'

          console.log("[DELETE CATEGORY] Mode: ".concat(deleteMode, ", ID: ").concat(id));
          _context.next = 6;
          return regeneratorRuntime.awrap(recipeModel.find({
            categoryId: id
          }));

        case 6:
          recipes = _context.sent;
          recipeCount = recipes.length;

          if (!(recipeCount > 0)) {
            _context.next = 42;
            break;
          }

          _context.t0 = deleteMode;
          _context.next = _context.t0 === 'soft' ? 12 : _context.t0 === 'reassign' ? 26 : _context.t0 === 'hard' ? 35 : 39;
          break;

        case 12:
          _context.next = 14;
          return regeneratorRuntime.awrap(categoryModel.findByIdAndUpdate(id, {
            isActive: false,
            deletedAt: new Date(),
            status: 'deleted'
          }));

        case 14:
          _context.next = 16;
          return regeneratorRuntime.awrap(categoryModel.findOne({
            name: 'Uncategorized'
          }));

        case 16:
          _context.t1 = _context.sent;

          if (_context.t1) {
            _context.next = 21;
            break;
          }

          _context.next = 20;
          return regeneratorRuntime.awrap(new categoryModel({
            name: 'Uncategorized'
          }).save());

        case 20:
          _context.t1 = _context.sent;

        case 21:
          uncategorizedCat = _context.t1;
          _context.next = 24;
          return regeneratorRuntime.awrap(recipeModel.updateMany({
            categoryId: id
          }, {
            categoryId: uncategorizedCat._id
          }));

        case 24:
          console.log("[SOFT DELETE] ".concat(recipeCount, " recipes moved to Uncategorized"));
          return _context.abrupt("break", 40);

        case 26:
          // Admin must specify target category
          targetCategoryId = req.query.targetId;

          if (targetCategoryId) {
            _context.next = 29;
            break;
          }

          return _context.abrupt("return", res.status(400).json({
            status: false,
            message: 'Target category required for reassignment'
          }));

        case 29:
          _context.next = 31;
          return regeneratorRuntime.awrap(recipeModel.updateMany({
            categoryId: id
          }, {
            categoryId: targetCategoryId
          }));

        case 31:
          _context.next = 33;
          return regeneratorRuntime.awrap(categoryModel.deleteOne({
            _id: id
          }));

        case 33:
          console.log("[REASSIGN] ".concat(recipeCount, " recipes moved to new category"));
          return _context.abrupt("break", 40);

        case 35:
          _context.next = 37;
          return regeneratorRuntime.awrap(performHardDelete(id, recipes));

        case 37:
          console.log("[HARD DELETE] Category and ".concat(recipeCount, " recipes permanently deleted"));
          return _context.abrupt("break", 40);

        case 39:
          return _context.abrupt("return", res.status(400).json({
            status: false,
            message: 'Invalid delete mode'
          }));

        case 40:
          _context.next = 45;
          break;

        case 42:
          _context.next = 44;
          return regeneratorRuntime.awrap(categoryModel.deleteOne({
            _id: id
          }));

        case 44:
          console.log("[SAFE DELETE] Empty category deleted");

        case 45:
          return _context.abrupt("return", res.redirect('back'));

        case 48:
          _context.prev = 48;
          _context.t2 = _context["catch"](0);
          console.log('[DELETE CATEGORY ERROR]:', _context.t2.message);
          return _context.abrupt("return", res.status(500).json({
            status: false,
            message: 'Error deleting category: ' + _context.t2.message
          }));

        case 52:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 48]]);
}; // Separate function for hard delete


var performHardDelete = function performHardDelete(categoryId, recipes) {
  return regeneratorRuntime.async(function performHardDelete$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.next = 2;
          return regeneratorRuntime.awrap(Promise.all(recipes.map(function _callee(item) {
            return regeneratorRuntime.async(function _callee$(_context2) {
              while (1) {
                switch (_context2.prev = _context2.next) {
                  case 0:
                    deleteImages(item.image);
                    item.gallery.map(function (image) {
                      return deleteImages(image);
                    });
                    if (item.video) deleteVideo(item.video);
                    _context2.next = 5;
                    return regeneratorRuntime.awrap(reviewModel.deleteMany({
                      recipeId: item._id
                    }));

                  case 5:
                    _context2.next = 7;
                    return regeneratorRuntime.awrap(favouriteRecipeModel.deleteMany({
                      recipeId: item._id
                    }));

                  case 7:
                  case "end":
                    return _context2.stop();
                }
              }
            });
          })));

        case 2:
          _context3.next = 4;
          return regeneratorRuntime.awrap(recipeModel.deleteMany({
            categoryId: categoryId
          }));

        case 4:
          _context3.next = 6;
          return regeneratorRuntime.awrap(categoryModel.deleteOne({
            _id: categoryId
          }));

        case 6:
        case "end":
          return _context3.stop();
      }
    }
  });
};