// Importing required modules 
const express = require("express");

// Create an instance of the express router
const routes = express();

// Importing middleware functions for upload image
const { uploadAvatar } = require("../middleware/uploadSingleFile");

// Importing middleware functions for check user authentication
const { checkAuthorization } = require("../middleware/checkAuthentication");

// Import controllers
const apiController = require("../controllers/apiController");

//Routes For Sign Up
routes.post("/CheckRegisterUser", apiController.CheckRegisterUser);

routes.post("/Signup", apiController.SignUp);

routes.post("/VerifyOtp", apiController.VerifyOtp);

//Routes For Sign In    
routes.post("/SignIn", apiController.SignIn);

routes.post("/isVerifyAccount", apiController.isVerifyAccount);

routes.post("/resendOtp", apiController.resendOtp);

//Routes For Forgot Password and Reset Password
routes.post("/ForgotPassword", apiController.ForgotPassword);

routes.post("/ForgotPasswordVerification", apiController.ForgotPasswordVerification);

routes.post("/ResetPassword", apiController.ResetPassword);

//Routes For User Edit
routes.post("/UserEdit", checkAuthorization, apiController.UserEdit);

routes.post("/GetUser", checkAuthorization, apiController.GetUser);

routes.post("/UploadImage", checkAuthorization, uploadAvatar, apiController.UploadImage);

routes.post("/ChangePassword", checkAuthorization, apiController.ChangePassword);

routes.post("/DeleteAccountUser", checkAuthorization, apiController.DeleteAccountUser);

// Routes For Intro
routes.post("/getAllIntro", apiController.getAllIntro);

//Routes For Category
routes.post("/GetAllCategory", apiController.GetAllCategory);

//Routes For Cuisines
routes.post("/GetAllCuisines", apiController.GetAllCuisines);

//Routes For Recipe
routes.post("/GetAllRecipe", apiController.GetAllRecipe);

routes.post("/popularRecipe", apiController.popularRecipe);

routes.post("/recommendedRecipe", apiController.recommendedRecipe);

routes.post("/GetRecipeById", apiController.GetRecipeById)

routes.post("/GetRecipeByCategoryId", apiController.GetRecipeByCategoryId);

routes.post("/FilterRecipe", apiController.FilterRecipe);

routes.post("/SearchRecipes", apiController.SearchRecipes);

//Routes For Favourite
routes.post("/AddFavouriteRecipe", checkAuthorization, apiController.AddFavouriteRecipe);

routes.post("/GetAllFavouriteRecipes", checkAuthorization, apiController.GetAllFavouriteRecipes);

routes.post("/DeleteFavouriteRecipe", checkAuthorization, apiController.DeleteFavouriteRecipe);

//Routes For Reviews
routes.post("/AddReview", checkAuthorization, apiController.AddReview);

routes.post("/GetReviewByRecipeId", apiController.GetReviewByRecipeId);

// Routes For FAQ
routes.post("/getAllFaq", apiController.getAllFaq);

// Routes For ads
routes.post("/getAdmob", apiController.getAdmob);
routes.get("/getAdmob", apiController.getAdmob);

//Routes For Policy and terms
routes.post("/GetPolicyAndTerms", apiController.GetPolicyAndTerms);

//Routes For NotiFiaction
routes.post("/GetAllNotification", apiController.GetAllNotification);

//Routes For AI Generated Recipes
const aiRecipeController = require("../controllers/aiRecipeController");
routes.post("/saveAiRecipe", checkAuthorization, aiRecipeController.saveAiRecipe);
routes.post("/getUserAiRecipes", checkAuthorization, aiRecipeController.getUserAiRecipes);
routes.post("/deleteAiRecipe", checkAuthorization, aiRecipeController.deleteAiRecipe);
routes.post("/updateAiRecipe", checkAuthorization, aiRecipeController.updateAiRecipe);

module.exports = routes;