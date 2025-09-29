"use strict";

// Importing required modules 
var express = require("express"); // Create an instance of the express router


var routes = express(); // Configure EJS as the templating engine

routes.set('view engine', 'ejs'); // Configure the views directory for "static-files"

routes.set('views', './views/admin'); // Configure static files

routes.use(express["static"]('public')); // Importing middleware functions for admin authentication

var _require = require("../middleware/auth"),
    isLogin = _require.isLogin,
    isLogout = _require.isLogout; // Importing middleware function to uploaded multiple file


var multiplefile = require("../middleware/uploadMultipleFile"); // Importing middleware function to uploaded single file


var _require2 = require("../middleware/uploadSingleFile"),
    uploadImage = _require2.uploadImage; // Import controllers


var loginController = require("../controllers/loginController");

var categoryController = require("../controllers/categoryController");

var cuisinesController = require("../controllers/cuisinesController");

var recipeController = require("../controllers/recipeController");

var reviewController = require("../controllers/reviewController");

var introController = require("../controllers/introController");

var faqController = require("../controllers/faqController");

var mailController = require("../controllers/mailController");

var adsController = require("../controllers/adsController");

var settingController = require("../controllers/settingController");

var notificationController = require("../controllers/notificationController"); //Routes For Login


routes.get("/", isLogout, loginController.loadLogin);
routes.post("/", loginController.login); //Routes For Profile

routes.get("/profile", isLogin, loginController.loadProfile);
routes.get("/edit-profile", isLogin, loginController.loadEditProfile);
routes.post("/edit-profile", uploadImage, loginController.editProfile); //Routes Change Password

routes.get('/changePassword', isLogin, loginController.loadChangePassword);
routes.post('/changePassword', loginController.changePassword); //Routes For Dashboard

routes.get("/dashboard", isLogin, loginController.loadDashboard); // Routes For Intro

routes.get("/add-intro", isLogin, introController.loadAddIntro);
routes.post("/add-intro", uploadImage, introController.addIntro);
routes.get("/intro", isLogin, introController.loadIntro);
routes.get("/edit-intro", isLogin, introController.loadEditIntro);
routes.post("/edit-intro", uploadImage, introController.editIntro);
routes.get("/delete-intro", isLogin, introController.deleteIntro); //Routes For Category

routes.post("/category", multiplefile, categoryController.addCategory);
routes.get("/category", isLogin, categoryController.loadcategory);
routes.post("/edit-category", categoryController.editCategory);
routes.get("/check-category-usage", isLogin, categoryController.checkCategoryUsage);
routes.get("/delete-category", isLogin, categoryController.deleteCategory); //Routes For Cuisines

routes.post("/cuisines", cuisinesController.addCuisines);
routes.get("/cuisines", isLogin, cuisinesController.loadCuisines);
routes.post("/edit-cuisines", cuisinesController.editCuisines);
routes.get("/delete-cuisines", isLogin, cuisinesController.deleteCuisines); //Routes For  Recipe

routes.get("/add-recipe", isLogin, recipeController.loadAddRecipe);
routes.post("/add-recipe", multiplefile, recipeController.addRecipe);
routes.get("/recipe", isLogin, recipeController.loadRecipe);
routes.get("/edit-recipe", isLogin, recipeController.loadEditRecipe);
routes.post("/edit-recipe", multiplefile, recipeController.editRecipe);
routes.get("/delete-recipe", isLogin, recipeController.deleteRecipe); // Routes For Gallery

routes.get("/gallery", isLogin, recipeController.loadGallery);
routes.post("/add-image", multiplefile, recipeController.addImage);
routes.post("/edit-image", uploadImage, recipeController.editImage);
routes.get("/delete-image", recipeController.deleteGalleryImage); // Routes For Review

routes.get("/review", isLogin, reviewController.loadReview);
routes.get("/enable-review", isLogin, reviewController.isEnableReview); // Routes For User

routes.get("/user", isLogin, loginController.loadUser);
routes.get("/active-user", loginController.isActiveUser); // Routes For Setting

routes.get("/private-policy", isLogin, settingController.loadPrivatePolicy);
routes.post("/private-policy", settingController.addPrivatePolicy);
routes.get("/terms-and-condition", isLogin, settingController.loadTermsAndConditions);
routes.post("/terms-and-condition", settingController.addTermsAndConditional); // Routes For Notification

routes.get("/send-notification", isLogin, settingController.loadSendNotification);
routes.post("/send-notification", settingController.sendNotification);
routes.post("/update-notification", settingController.updateNotification);
routes.get("/notification-history", isLogin, settingController.loadNotificationHistory);
routes.post("/toggle-notification-status/:id", isLogin, settingController.toggleNotificationStatus);
routes["delete"]("/delete-notification/:id", isLogin, settingController.deleteNotification); // Routes For abs

routes.get("/ads", isLogin, adsController.loadAdConfig);
routes.post("/android-ad-config", adsController.updateAndroidAdConfig);
routes.post("/ios-ad-config", adsController.updateIOSAdConfig); // Routes For Faq

routes.get("/add-faq", isLogin, faqController.loadAddFaq);
routes.post("/add-faq", faqController.addFaq);
routes.get("/faq", isLogin, faqController.loadFaq);
routes.get("/edit-faq", isLogin, faqController.loadEditFaq);
routes.post("/edit-faq", faqController.editFaq);
routes.get('/delete-faq', faqController.deleteFaq); // Routes For Mail Config

routes.get("/mail-config", isLogin, mailController.loadMailConfig);
routes.post("/mail-config", mailController.mailConfig); // Routes For AI Recipes

var aiRecipeAdminController = require("../controllers/aiRecipeAdminController");

routes.get("/ai-recipes", isLogin, aiRecipeAdminController.loadAiRecipes);
routes.get("/ai-recipe-detail", isLogin, aiRecipeAdminController.viewAiRecipe);
routes.get("/delete-ai-recipe", isLogin, aiRecipeAdminController.deleteAiRecipe);
routes.get("/ai-recipe-stats", isLogin, aiRecipeAdminController.getAiRecipeStats); // Routes For Notifications Management

routes.get("/notifications", isLogin, notificationController.loadNotifications);
routes.get("/notifications/create", isLogin, notificationController.loadCreateNotification);
routes.post("/notifications/create", isLogin, notificationController.createNotification);
routes.get("/notifications/toggle/:id", isLogin, notificationController.toggleNotification);
routes.get("/notifications/delete/:id", isLogin, notificationController.deleteNotification);
routes.get("/api/notification-stats", isLogin, notificationController.getNotificationStats); //Routes For Log Out

routes.get("/logout", isLogin, loginController.logout); // Redirects unmatched routes to the root path

routes.get("*", function _callee(req, res) {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          return _context.abrupt("return", res.redirect('/'));

        case 1:
        case "end":
          return _context.stop();
      }
    }
  });
});
module.exports = routes;
