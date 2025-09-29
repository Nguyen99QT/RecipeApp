"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Importing required modules 
var sha256 = require("sha256");

var jwt = require("jsonwebtoken");

var otpGenerator = require("otp-generator"); // Importing models


var userModel = require("../model/userModel");

var categoryModel = require("../model/categoryModel");

var cuisinesModel = require("../model/cuisinesModel");

var recipeModel = require("../model/recipeModel");

var introModel = require("../model/introModel");

var faqModel = require("../model/faqModel");

var adsModel = require("../model/adsModel");

var settingModel = require("../model/settingModel");

var otpModel = require("../model/otpModel");

var ForgotPasswordOtpModel = require("../model/ForgotPasswordOtpModel");

var favouriteRecipeModel = require("../model/favouriteRecipeModel");

var reviewModel = require("../model/reviewModel");

var notificationModel = require("../model/notificationModel"); // Importing services


var combineRecipeReview = require("../services/combineRecipeReview");

var sendOtpMail = require("../services/sendOtpMail"); // Strong password validation function


var validateStrongPassword = function validateStrongPassword(password) {
  // At least 8 characters, contains uppercase, lowercase, number, and special character
  var minLength = 8;
  var hasUpperCase = /[A-Z]/.test(password);
  var hasLowerCase = /[a-z]/.test(password);
  var hasNumbers = /\d/.test(password);
  var hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

  if (password.length < minLength) {
    return {
      valid: false,
      message: "Password must be at least 8 characters long"
    };
  }

  if (!hasUpperCase) {
    return {
      valid: false,
      message: "Password must contain at least one uppercase letter"
    };
  }

  if (!hasLowerCase) {
    return {
      valid: false,
      message: "Password must contain at least one lowercase letter"
    };
  }

  if (!hasNumbers) {
    return {
      valid: false,
      message: "Password must contain at least one number"
    };
  }

  if (!hasSpecialChar) {
    return {
      valid: false,
      message: "Password must contain at least one special character (!@#$%^&*(),.?\":{}|<>)"
    };
  }

  return {
    valid: true,
    message: "Password is strong"
  };
}; // Check if user is already registered


var CheckRegisterUser = function CheckRegisterUser(req, res) {
  var email, existingUser;
  return regeneratorRuntime.async(function CheckRegisterUser$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          email = req.body.email;
          _context.next = 4;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 4:
          existingUser = _context.sent;

          if (!existingUser) {
            _context.next = 7;
            break;
          }

          return _context.abrupt("return", res.status(400).json({
            status: false,
            message: "User already exists with this email"
          }));

        case 7:
          return _context.abrupt("return", res.status(200).json({
            status: true,
            message: "Email is available for registration"
          }));

        case 10:
          _context.prev = 10;
          _context.t0 = _context["catch"](0);
          console.log(_context.t0.message);
          return _context.abrupt("return", res.status(500).json({
            status: false,
            message: _context.t0.message || "Failed to check email availability"
          }));

        case 14:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // User signup


var SignUp = function SignUp(req, res) {
  var _req$body, firstname, lastname, email, country_code, phone, password, passwordValidation, existingUser, hashedPassword, newUser, savedUser, otp, otpData, response;

  return regeneratorRuntime.async(function SignUp$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          console.log('=== SIGNUP REQUEST RECEIVED ===');
          console.log('Request body:', req.body);
          _req$body = req.body, firstname = _req$body.firstname, lastname = _req$body.lastname, email = _req$body.email, country_code = _req$body.country_code, phone = _req$body.phone, password = _req$body.password;
          console.log('Extracted data:', {
            firstname: firstname,
            lastname: lastname,
            email: email,
            country_code: country_code,
            phone: phone,
            password: '***'
          }); // Validate strong password

          passwordValidation = validateStrongPassword(password);

          if (passwordValidation.valid) {
            _context2.next = 9;
            break;
          }

          console.log('Password validation failed:', passwordValidation.message);
          return _context2.abrupt("return", res.status(400).json({
            status: false,
            message: passwordValidation.message
          }));

        case 9:
          _context2.next = 11;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 11:
          existingUser = _context2.sent;

          if (!existingUser) {
            _context2.next = 15;
            break;
          }

          console.log('User already exists:', email);
          return _context2.abrupt("return", res.status(400).json({
            status: false,
            message: "User already exists with this email"
          }));

        case 15:
          // Hash password
          hashedPassword = sha256.x2(password); // Create new user

          newUser = new userModel({
            firstname: firstname,
            lastname: lastname,
            email: email,
            country_code: country_code,
            phone: phone,
            password: hashedPassword
          });
          _context2.next = 19;
          return regeneratorRuntime.awrap(newUser.save());

        case 19:
          savedUser = _context2.sent;
          console.log('User saved successfully:', savedUser._id); // Generate OTP - manual generation to ensure only digits

          otp = Math.floor(1000 + Math.random() * 9000); // Generate 4-digit number

          console.log('Generated OTP:', otp);
          console.log('Is valid number:', !isNaN(otp)); // Save OTP with debugging

          console.log('Creating OTP data:', {
            userId: savedUser._id,
            email: email,
            otp: otp
          });
          otpData = new otpModel({
            userId: savedUser._id,
            email: email,
            otp: otp
          });
          _context2.prev = 26;
          _context2.next = 29;
          return regeneratorRuntime.awrap(otpData.save());

        case 29:
          console.log('OTP saved successfully');
          _context2.next = 36;
          break;

        case 32:
          _context2.prev = 32;
          _context2.t0 = _context2["catch"](26);
          console.log('Error saving OTP:', _context2.t0.message);
          throw new Error('Failed to save OTP: ' + _context2.t0.message);

        case 36:
          _context2.prev = 36;
          _context2.next = 39;
          return regeneratorRuntime.awrap(sendOtpMail(email, otp, firstname, lastname));

        case 39:
          console.log('OTP email sent successfully to:', email, 'OTP:', otp);
          _context2.next = 46;
          break;

        case 42:
          _context2.prev = 42;
          _context2.t1 = _context2["catch"](36);
          console.log('Error sending OTP email:', _context2.t1.message); // Don't throw error here, user is created successfully

          console.log('User created but email failed to send');

        case 46:
          response = {
            status: true,
            message: "User registered successfully. OTP sent to email.",
            userId: savedUser._id
          };
          console.log('=== SIGNUP SUCCESS RESPONSE ===');
          console.log('Response:', response);
          return _context2.abrupt("return", res.status(200).json(response));

        case 52:
          _context2.prev = 52;
          _context2.t2 = _context2["catch"](0);
          console.log('=== SIGNUP ERROR ===');
          console.log('Error message:', _context2.t2.message);
          console.log('Error stack:', _context2.t2.stack);
          return _context2.abrupt("return", res.status(500).json({
            status: false,
            message: _context2.t2.message || "Failed to register user"
          }));

        case 58:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 52], [26, 32], [36, 42]]);
}; // Verify OTP


var VerifyOtp = function VerifyOtp(req, res) {
  var _req$body2, userId, email, otp, otpData, finalUserId;

  return regeneratorRuntime.async(function VerifyOtp$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          console.log('=== VERIFY OTP REQUEST ===');
          console.log('Request body:', req.body);
          _req$body2 = req.body, userId = _req$body2.userId, email = _req$body2.email, otp = _req$body2.otp;
          console.log('Extracted userId:', userId, 'email:', email, 'otp:', otp);

          if (!userId) {
            _context3.next = 12;
            break;
          }

          _context3.next = 8;
          return regeneratorRuntime.awrap(otpModel.findOne({
            userId: userId,
            otp: otp
          }));

        case 8:
          otpData = _context3.sent;
          console.log('OTP search by userId - found:', otpData);
          _context3.next = 21;
          break;

        case 12:
          if (!email) {
            _context3.next = 19;
            break;
          }

          _context3.next = 15;
          return regeneratorRuntime.awrap(otpModel.findOne({
            email: email,
            otp: otp
          }));

        case 15:
          otpData = _context3.sent;
          console.log('OTP search by email - found:', otpData);
          _context3.next = 21;
          break;

        case 19:
          console.log('=== MISSING PARAMETERS ===');
          return _context3.abrupt("return", res.status(400).json({
            status: false,
            message: "Missing userId or email parameter"
          }));

        case 21:
          if (otpData) {
            _context3.next = 25;
            break;
          }

          console.log('=== OTP VERIFICATION FAILED ===');
          console.log('No matching OTP found for', userId ? "userId: ".concat(userId) : "email: ".concat(email), 'otp:', otp);
          return _context3.abrupt("return", res.status(400).json({
            status: false,
            message: "Invalid OTP"
          }));

        case 25:
          // Get userId from otpData if not provided
          finalUserId = userId || otpData.userId; // Update user verification status

          _context3.next = 28;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate(finalUserId, {
            isOTPVerified: 1
          }));

        case 28:
          console.log('User verification status updated for userId:', finalUserId); // Delete OTP

          _context3.next = 31;
          return regeneratorRuntime.awrap(otpModel.deleteOne({
            _id: otpData._id
          }));

        case 31:
          console.log('OTP deleted successfully');
          console.log('=== OTP VERIFICATION SUCCESS ===');
          return _context3.abrupt("return", res.status(200).json({
            status: true,
            message: "OTP verified successfully"
          }));

        case 36:
          _context3.prev = 36;
          _context3.t0 = _context3["catch"](0);
          console.error('=== VERIFY OTP ERROR ===');
          console.error('Error message:', _context3.t0.message);
          console.error('Error stack:', _context3.t0.stack);
          return _context3.abrupt("return", res.status(500).json({
            status: false,
            message: _context3.t0.message || "Failed to verify OTP"
          }));

        case 42:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 36]]);
}; // User signin


var SignIn = function SignIn(req, res) {
  var _req$body3, email, password, hashedPassword, user, token, response;

  return regeneratorRuntime.async(function SignIn$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          console.log('=== SIGNIN REQUEST RECEIVED ===');
          console.log('Request body:', req.body);
          _req$body3 = req.body, email = _req$body3.email, password = _req$body3.password;
          console.log('Login attempt for email:', email);
          hashedPassword = sha256.x2(password);
          _context4.next = 8;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email,
            password: hashedPassword
          }));

        case 8:
          user = _context4.sent;

          if (user) {
            _context4.next = 12;
            break;
          }

          console.log('Login failed: Invalid credentials for', email);
          return _context4.abrupt("return", res.status(400).json({
            status: false,
            message: "Invalid email or password"
          }));

        case 12:
          if (!(user.is_active === 0)) {
            _context4.next = 15;
            break;
          }

          console.log('Login failed: Account deactivated for', email);
          return _context4.abrupt("return", res.status(400).json({
            status: false,
            message: "Your account has been deactivated. Please contact admin for support.",
            isDeactivated: true
          }));

        case 15:
          if (!(user.isOTPVerified === 0)) {
            _context4.next = 18;
            break;
          }

          console.log('Login failed: Email not verified for', email);
          return _context4.abrupt("return", res.status(400).json({
            status: false,
            message: "Please verify your email first",
            isVerified: false,
            userId: user._id
          }));

        case 18:
          // Generate JWT token
          token = jwt.sign({
            id: user._id
          }, process.env.JWT_SECRET_KEY, {
            expiresIn: '30d'
          });
          response = {
            status: true,
            message: "Login successful",
            token: token,
            user: {
              id: user._id,
              firstname: user.firstname,
              lastname: user.lastname,
              email: user.email,
              phone: user.phone,
              avatar: user.avatar
            }
          };
          console.log('=== SIGNIN SUCCESS RESPONSE ===');
          console.log('User logged in:', email);
          console.log('Response:', _objectSpread({}, response, {
            token: 'TOKEN_HIDDEN'
          }));
          return _context4.abrupt("return", res.status(200).json(response));

        case 26:
          _context4.prev = 26;
          _context4.t0 = _context4["catch"](0);
          console.log('=== SIGNIN ERROR ===');
          console.log('Error message:', _context4.t0.message);
          console.log('Error stack:', _context4.t0.stack);
          return _context4.abrupt("return", res.status(500).json({
            status: false,
            message: _context4.t0.message || "Failed to sign in"
          }));

        case 32:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 26]]);
}; // Check if account is verified


var isVerifyAccount = function isVerifyAccount(req, res) {
  var _req$body4, userId, email, user;

  return regeneratorRuntime.async(function isVerifyAccount$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _req$body4 = req.body, userId = _req$body4.userId, email = _req$body4.email;

          if (!userId) {
            _context5.next = 8;
            break;
          }

          _context5.next = 5;
          return regeneratorRuntime.awrap(userModel.findById(userId));

        case 5:
          user = _context5.sent;
          _context5.next = 15;
          break;

        case 8:
          if (!email) {
            _context5.next = 14;
            break;
          }

          _context5.next = 11;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 11:
          user = _context5.sent;
          _context5.next = 15;
          break;

        case 14:
          return _context5.abrupt("return", res.status(400).json({
            status: false,
            message: "userId or email is required"
          }));

        case 15:
          if (user) {
            _context5.next = 17;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found"
          }));

        case 17:
          return _context5.abrupt("return", res.status(200).json({
            status: true,
            isVerified: user.isOTPVerified === 1
          }));

        case 20:
          _context5.prev = 20;
          _context5.t0 = _context5["catch"](0);
          console.log(_context5.t0.message);
          return _context5.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 24:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 20]]);
}; // Resend OTP


var resendOtp = function resendOtp(req, res) {
  var _req$body5, userId, email, user, recentOtp, otp, otpData;

  return regeneratorRuntime.async(function resendOtp$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _req$body5 = req.body, userId = _req$body5.userId, email = _req$body5.email;

          if (!userId) {
            _context6.next = 8;
            break;
          }

          _context6.next = 5;
          return regeneratorRuntime.awrap(userModel.findById(userId));

        case 5:
          user = _context6.sent;
          _context6.next = 15;
          break;

        case 8:
          if (!email) {
            _context6.next = 14;
            break;
          }

          _context6.next = 11;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 11:
          user = _context6.sent;
          _context6.next = 15;
          break;

        case 14:
          return _context6.abrupt("return", res.status(400).json({
            status: false,
            message: "Either userId or email is required"
          }));

        case 15:
          if (user) {
            _context6.next = 17;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found"
          }));

        case 17:
          _context6.next = 19;
          return regeneratorRuntime.awrap(otpModel.findOne({
            userId: user._id,
            createdAt: {
              $gte: new Date(Date.now() - 60000)
            } // 60 seconds ago

          }));

        case 19:
          recentOtp = _context6.sent;

          if (!recentOtp) {
            _context6.next = 22;
            break;
          }

          return _context6.abrupt("return", res.status(429).json({
            status: false,
            message: "Please wait 60 seconds before requesting a new OTP"
          }));

        case 22:
          _context6.next = 24;
          return regeneratorRuntime.awrap(otpModel.deleteMany({
            userId: user._id
          }));

        case 24:
          // Generate new OTP
          otp = Math.floor(1000 + Math.random() * 9000); // Consistent with signup
          // Save new OTP (with automatic expiration)

          otpData = new otpModel({
            userId: user._id,
            email: user.email,
            otp: otp
          });
          _context6.next = 28;
          return regeneratorRuntime.awrap(otpData.save());

        case 28:
          _context6.next = 30;
          return regeneratorRuntime.awrap(sendOtpMail(user.email, otp, user.firstname || 'User', user.lastname || ''));

        case 30:
          return _context6.abrupt("return", res.status(200).json({
            status: true,
            message: "OTP sent successfully. Valid for 5 minutes."
          }));

        case 33:
          _context6.prev = 33;
          _context6.t0 = _context6["catch"](0);
          console.log(_context6.t0.message);
          return _context6.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 37:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 33]]);
}; // Forgot password


var ForgotPassword = function ForgotPassword(req, res) {
  var email, user, otp, otpData;
  return regeneratorRuntime.async(function ForgotPassword$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          email = req.body.email;
          _context7.next = 4;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 4:
          user = _context7.sent;

          if (user) {
            _context7.next = 7;
            break;
          }

          return _context7.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found with this email"
          }));

        case 7:
          // Generate OTP - using simple random number generation
          otp = Math.floor(1000 + Math.random() * 9000); // Generate 4-digit number (1000-9999)
          // Delete existing forgot password OTP

          _context7.next = 10;
          return regeneratorRuntime.awrap(ForgotPasswordOtpModel.deleteMany({
            userId: user._id
          }));

        case 10:
          // Save OTP
          otpData = new ForgotPasswordOtpModel({
            userId: user._id,
            email: email,
            otp: otp
          });
          _context7.next = 13;
          return regeneratorRuntime.awrap(otpData.save());

        case 13:
          _context7.next = 15;
          return regeneratorRuntime.awrap(sendOtpMail(email, otp, user.firstname || 'User', user.lastname || ''));

        case 15:
          return _context7.abrupt("return", res.status(200).json({
            status: true,
            message: "OTP sent to your email",
            userId: user._id
          }));

        case 18:
          _context7.prev = 18;
          _context7.t0 = _context7["catch"](0);
          console.log(_context7.t0.message);
          return _context7.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 22:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 18]]);
}; // Forgot password verification


var ForgotPasswordVerification = function ForgotPasswordVerification(req, res) {
  var _req$body6, userId, email, otp, otpData, user;

  return regeneratorRuntime.async(function ForgotPasswordVerification$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          _context8.prev = 0;
          console.log('=== FORGOT PASSWORD VERIFICATION REQUEST ===');
          console.log('Request body:', req.body);
          _req$body6 = req.body, userId = _req$body6.userId, email = _req$body6.email, otp = _req$body6.otp;

          if (!userId) {
            _context8.next = 11;
            break;
          }

          console.log('Searching OTP by userId:', userId);
          _context8.next = 8;
          return regeneratorRuntime.awrap(ForgotPasswordOtpModel.findOne({
            userId: userId,
            otp: otp
          }));

        case 8:
          otpData = _context8.sent;
          _context8.next = 27;
          break;

        case 11:
          if (!email) {
            _context8.next = 25;
            break;
          }

          console.log('Searching OTP by email:', email); // Find user first to get userId

          _context8.next = 15;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 15:
          user = _context8.sent;

          if (user) {
            _context8.next = 19;
            break;
          }

          console.log('User not found with email:', email);
          return _context8.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found"
          }));

        case 19:
          console.log('Found user:', user._id);
          _context8.next = 22;
          return regeneratorRuntime.awrap(ForgotPasswordOtpModel.findOne({
            userId: user._id,
            otp: otp
          }));

        case 22:
          otpData = _context8.sent;
          _context8.next = 27;
          break;

        case 25:
          console.log('Missing userId and email parameters');
          return _context8.abrupt("return", res.status(400).json({
            status: false,
            message: "Either userId or email is required"
          }));

        case 27:
          if (otpData) {
            _context8.next = 30;
            break;
          }

          console.log('Invalid OTP - not found in database');
          return _context8.abrupt("return", res.status(400).json({
            status: false,
            message: "Invalid OTP"
          }));

        case 30:
          console.log('OTP verification successful');
          return _context8.abrupt("return", res.status(200).json({
            status: true,
            message: "OTP verified successfully",
            userId: otpData.userId
          }));

        case 34:
          _context8.prev = 34;
          _context8.t0 = _context8["catch"](0);
          console.error('ForgotPasswordVerification error:', _context8.t0.message);
          return _context8.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 38:
        case "end":
          return _context8.stop();
      }
    }
  }, null, null, [[0, 34]]);
}; // Reset password


var ResetPassword = function ResetPassword(req, res) {
  var _req$body7, userId, email, otp, newPassword, confirmPassword, passwordValidation, finalUserId, otpData, user, recentOtp, hashedPassword;

  return regeneratorRuntime.async(function ResetPassword$(_context9) {
    while (1) {
      switch (_context9.prev = _context9.next) {
        case 0:
          _context9.prev = 0;
          console.log('=== RESET PASSWORD REQUEST ===');
          console.log('Request body:', req.body);
          _req$body7 = req.body, userId = _req$body7.userId, email = _req$body7.email, otp = _req$body7.otp, newPassword = _req$body7.newPassword, confirmPassword = _req$body7.confirmPassword; // Validate required fields

          if (newPassword) {
            _context9.next = 6;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: "New password is required"
          }));

        case 6:
          if (confirmPassword) {
            _context9.next = 8;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: "Confirm password is required"
          }));

        case 8:
          if (!(newPassword !== confirmPassword)) {
            _context9.next = 10;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: "Password and confirm password do not match"
          }));

        case 10:
          // Validate strong password
          passwordValidation = validateStrongPassword(newPassword);

          if (passwordValidation.valid) {
            _context9.next = 14;
            break;
          }

          console.log('Password validation failed:', passwordValidation.message);
          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: passwordValidation.message
          }));

        case 14:
          finalUserId = userId;

          if (!(!finalUserId && email)) {
            _context9.next = 25;
            break;
          }

          console.log('Finding user by email:', email);
          _context9.next = 19;
          return regeneratorRuntime.awrap(userModel.findOne({
            email: email
          }));

        case 19:
          user = _context9.sent;

          if (user) {
            _context9.next = 23;
            break;
          }

          console.log('User not found with email:', email);
          return _context9.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found"
          }));

        case 23:
          finalUserId = user._id;
          console.log('Found user ID:', finalUserId);

        case 25:
          if (finalUserId) {
            _context9.next = 27;
            break;
          }

          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: "Either userId or email is required"
          }));

        case 27:
          _context9.next = 29;
          return regeneratorRuntime.awrap(ForgotPasswordOtpModel.findOne({
            userId: finalUserId
          }));

        case 29:
          recentOtp = _context9.sent;

          if (recentOtp) {
            _context9.next = 33;
            break;
          }

          console.log('No OTP found for user - please verify OTP first');
          return _context9.abrupt("return", res.status(400).json({
            status: false,
            message: "Please verify OTP first"
          }));

        case 33:
          hashedPassword = sha256.x2(newPassword); // Update password

          _context9.next = 36;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate(finalUserId, {
            password: hashedPassword
          }));

        case 36:
          console.log('Password updated for user:', finalUserId); // Delete all OTP records for this user

          _context9.next = 39;
          return regeneratorRuntime.awrap(ForgotPasswordOtpModel.deleteMany({
            userId: finalUserId
          }));

        case 39:
          console.log('OTP records deleted for user:', finalUserId);
          return _context9.abrupt("return", res.status(200).json({
            status: true,
            message: "Password reset successfully"
          }));

        case 43:
          _context9.prev = 43;
          _context9.t0 = _context9["catch"](0);
          console.error('ResetPassword error:', _context9.t0.message);
          return _context9.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 47:
        case "end":
          return _context9.stop();
      }
    }
  }, null, null, [[0, 43]]);
}; // Edit user profile


var UserEdit = function UserEdit(req, res) {
  var _req$body8, firstname, lastname, phone, country_code, userId, updatedUser;

  return regeneratorRuntime.async(function UserEdit$(_context10) {
    while (1) {
      switch (_context10.prev = _context10.next) {
        case 0:
          _context10.prev = 0;
          _req$body8 = req.body, firstname = _req$body8.firstname, lastname = _req$body8.lastname, phone = _req$body8.phone, country_code = _req$body8.country_code;
          userId = req.userId;
          _context10.next = 5;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate(userId, {
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            country_code: country_code
          }, {
            "new": true
          }).select('-password'));

        case 5:
          updatedUser = _context10.sent;
          return _context10.abrupt("return", res.status(200).json({
            status: true,
            message: "Profile updated successfully",
            user: updatedUser
          }));

        case 9:
          _context10.prev = 9;
          _context10.t0 = _context10["catch"](0);
          console.log(_context10.t0.message);
          return _context10.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 13:
        case "end":
          return _context10.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Get user details


var GetUser = function GetUser(req, res) {
  var userId, user;
  return regeneratorRuntime.async(function GetUser$(_context11) {
    while (1) {
      switch (_context11.prev = _context11.next) {
        case 0:
          _context11.prev = 0;
          userId = req.userId;
          _context11.next = 4;
          return regeneratorRuntime.awrap(userModel.findById(userId).select('-password'));

        case 4:
          user = _context11.sent;

          if (user) {
            _context11.next = 7;
            break;
          }

          return _context11.abrupt("return", res.status(404).json({
            status: false,
            message: "User not found"
          }));

        case 7:
          return _context11.abrupt("return", res.status(200).json({
            status: true,
            user: user
          }));

        case 10:
          _context11.prev = 10;
          _context11.t0 = _context11["catch"](0);
          console.log(_context11.t0.message);
          return _context11.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 14:
        case "end":
          return _context11.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // Upload user image


var UploadImage = function UploadImage(req, res) {
  var userId, updatedUser;
  return regeneratorRuntime.async(function UploadImage$(_context12) {
    while (1) {
      switch (_context12.prev = _context12.next) {
        case 0:
          _context12.prev = 0;
          userId = req.userId;

          if (req.file) {
            _context12.next = 4;
            break;
          }

          return _context12.abrupt("return", res.status(400).json({
            status: false,
            message: "No image uploaded"
          }));

        case 4:
          _context12.next = 6;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate(userId, {
            avatar: req.file.filename
          }, {
            "new": true
          }).select('-password'));

        case 6:
          updatedUser = _context12.sent;
          return _context12.abrupt("return", res.status(200).json({
            status: true,
            message: "Image uploaded successfully",
            user: updatedUser
          }));

        case 10:
          _context12.prev = 10;
          _context12.t0 = _context12["catch"](0);
          console.log(_context12.t0.message);
          return _context12.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 14:
        case "end":
          return _context12.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // Change password


var ChangePassword = function ChangePassword(req, res) {
  var _req$body9, oldPassword, newPassword, userId, passwordValidation, hashedOldPassword, user, hashedNewPassword;

  return regeneratorRuntime.async(function ChangePassword$(_context13) {
    while (1) {
      switch (_context13.prev = _context13.next) {
        case 0:
          _context13.prev = 0;
          _req$body9 = req.body, oldPassword = _req$body9.oldPassword, newPassword = _req$body9.newPassword;
          userId = req.userId; // Validate strong password

          passwordValidation = validateStrongPassword(newPassword);

          if (passwordValidation.valid) {
            _context13.next = 7;
            break;
          }

          console.log('Password validation failed:', passwordValidation.message);
          return _context13.abrupt("return", res.status(400).json({
            status: false,
            message: passwordValidation.message
          }));

        case 7:
          hashedOldPassword = sha256.x2(oldPassword);
          _context13.next = 10;
          return regeneratorRuntime.awrap(userModel.findOne({
            _id: userId,
            password: hashedOldPassword
          }));

        case 10:
          user = _context13.sent;

          if (user) {
            _context13.next = 13;
            break;
          }

          return _context13.abrupt("return", res.status(400).json({
            status: false,
            message: "Current password is incorrect"
          }));

        case 13:
          hashedNewPassword = sha256.x2(newPassword);
          _context13.next = 16;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate(userId, {
            password: hashedNewPassword
          }));

        case 16:
          return _context13.abrupt("return", res.status(200).json({
            status: true,
            message: "Password changed successfully"
          }));

        case 19:
          _context13.prev = 19;
          _context13.t0 = _context13["catch"](0);
          console.log(_context13.t0.message);
          return _context13.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 23:
        case "end":
          return _context13.stop();
      }
    }
  }, null, null, [[0, 19]]);
}; // Delete user account


var DeleteAccountUser = function DeleteAccountUser(req, res) {
  var userId;
  return regeneratorRuntime.async(function DeleteAccountUser$(_context14) {
    while (1) {
      switch (_context14.prev = _context14.next) {
        case 0:
          _context14.prev = 0;
          userId = req.userId;
          _context14.next = 4;
          return regeneratorRuntime.awrap(userModel.findByIdAndDelete(userId));

        case 4:
          _context14.next = 6;
          return regeneratorRuntime.awrap(favouriteRecipeModel.deleteMany({
            userId: userId
          }));

        case 6:
          _context14.next = 8;
          return regeneratorRuntime.awrap(reviewModel.deleteMany({
            userId: userId
          }));

        case 8:
          return _context14.abrupt("return", res.status(200).json({
            status: true,
            message: "Account deleted successfully"
          }));

        case 11:
          _context14.prev = 11;
          _context14.t0 = _context14["catch"](0);
          console.log(_context14.t0.message);
          return _context14.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 15:
        case "end":
          return _context14.stop();
      }
    }
  }, null, null, [[0, 11]]);
}; // Get all intro


var getAllIntro = function getAllIntro(req, res) {
  var intros;
  return regeneratorRuntime.async(function getAllIntro$(_context15) {
    while (1) {
      switch (_context15.prev = _context15.next) {
        case 0:
          _context15.prev = 0;
          _context15.next = 3;
          return regeneratorRuntime.awrap(introModel.find().sort({
            createdAt: 1
          }));

        case 3:
          intros = _context15.sent;
          return _context15.abrupt("return", res.status(200).json({
            status: true,
            data: intros
          }));

        case 7:
          _context15.prev = 7;
          _context15.t0 = _context15["catch"](0);
          console.log(_context15.t0.message);
          return _context15.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context15.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get all categories


var GetAllCategory = function GetAllCategory(req, res) {
  var categories;
  return regeneratorRuntime.async(function GetAllCategory$(_context16) {
    while (1) {
      switch (_context16.prev = _context16.next) {
        case 0:
          _context16.prev = 0;
          _context16.next = 3;
          return regeneratorRuntime.awrap(categoryModel.find().sort({
            createdAt: -1
          }));

        case 3:
          categories = _context16.sent;
          return _context16.abrupt("return", res.status(200).json({
            status: true,
            data: categories
          }));

        case 7:
          _context16.prev = 7;
          _context16.t0 = _context16["catch"](0);
          console.log(_context16.t0.message);
          return _context16.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context16.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get all cuisines


var GetAllCuisines = function GetAllCuisines(req, res) {
  var cuisines;
  return regeneratorRuntime.async(function GetAllCuisines$(_context17) {
    while (1) {
      switch (_context17.prev = _context17.next) {
        case 0:
          _context17.prev = 0;
          _context17.next = 3;
          return regeneratorRuntime.awrap(cuisinesModel.find().sort({
            createdAt: -1
          }));

        case 3:
          cuisines = _context17.sent;
          return _context17.abrupt("return", res.status(200).json({
            status: true,
            data: cuisines
          }));

        case 7:
          _context17.prev = 7;
          _context17.t0 = _context17["catch"](0);
          console.log(_context17.t0.message);
          return _context17.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context17.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get all recipes


var GetAllRecipe = function GetAllRecipe(req, res) {
  var recipes;
  return regeneratorRuntime.async(function GetAllRecipe$(_context18) {
    while (1) {
      switch (_context18.prev = _context18.next) {
        case 0:
          _context18.prev = 0;
          _context18.next = 3;
          return regeneratorRuntime.awrap(recipeModel.find().populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }));

        case 3:
          recipes = _context18.sent;
          return _context18.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 7:
          _context18.prev = 7;
          _context18.t0 = _context18["catch"](0);
          console.log(_context18.t0.message);
          return _context18.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context18.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get popular recipes


var popularRecipe = function popularRecipe(req, res) {
  var recipes;
  return regeneratorRuntime.async(function popularRecipe$(_context19) {
    while (1) {
      switch (_context19.prev = _context19.next) {
        case 0:
          _context19.prev = 0;
          _context19.next = 3;
          return regeneratorRuntime.awrap(recipeModel.find().populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }).limit(10));

        case 3:
          recipes = _context19.sent;
          return _context19.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 7:
          _context19.prev = 7;
          _context19.t0 = _context19["catch"](0);
          console.log(_context19.t0.message);
          return _context19.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context19.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get recommended recipes


var recommendedRecipe = function recommendedRecipe(req, res) {
  var recipes;
  return regeneratorRuntime.async(function recommendedRecipe$(_context20) {
    while (1) {
      switch (_context20.prev = _context20.next) {
        case 0:
          _context20.prev = 0;
          _context20.next = 3;
          return regeneratorRuntime.awrap(recipeModel.find().populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }).limit(10));

        case 3:
          recipes = _context20.sent;
          return _context20.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 7:
          _context20.prev = 7;
          _context20.t0 = _context20["catch"](0);
          console.log(_context20.t0.message);
          return _context20.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context20.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get recipe by ID


var GetRecipeById = function GetRecipeById(req, res) {
  var recipeId, recipe, reviews, recipeWithReviews;
  return regeneratorRuntime.async(function GetRecipeById$(_context21) {
    while (1) {
      switch (_context21.prev = _context21.next) {
        case 0:
          _context21.prev = 0;
          recipeId = req.body.recipeId;
          _context21.next = 4;
          return regeneratorRuntime.awrap(recipeModel.findById(recipeId).populate('categoryId', 'name').populate('cuisinesId', 'name'));

        case 4:
          recipe = _context21.sent;

          if (recipe) {
            _context21.next = 7;
            break;
          }

          return _context21.abrupt("return", res.status(404).json({
            status: false,
            message: "Recipe not found"
          }));

        case 7:
          _context21.next = 9;
          return regeneratorRuntime.awrap(reviewModel.find({
            isEnable: true
          }));

        case 9:
          reviews = _context21.sent;
          _context21.next = 12;
          return regeneratorRuntime.awrap(combineRecipeReview(recipe, reviews, []));

        case 12:
          recipeWithReviews = _context21.sent;
          return _context21.abrupt("return", res.status(200).json({
            status: true,
            data: recipeWithReviews
          }));

        case 16:
          _context21.prev = 16;
          _context21.t0 = _context21["catch"](0);
          console.log(_context21.t0.message);
          return _context21.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 20:
        case "end":
          return _context21.stop();
      }
    }
  }, null, null, [[0, 16]]);
}; // Get recipes by category ID


var GetRecipeByCategoryId = function GetRecipeByCategoryId(req, res) {
  var categoryId, recipes;
  return regeneratorRuntime.async(function GetRecipeByCategoryId$(_context22) {
    while (1) {
      switch (_context22.prev = _context22.next) {
        case 0:
          _context22.prev = 0;
          categoryId = req.body.categoryId;
          _context22.next = 4;
          return regeneratorRuntime.awrap(recipeModel.find({
            categoryId: categoryId
          }).populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }));

        case 4:
          recipes = _context22.sent;
          return _context22.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 8:
          _context22.prev = 8;
          _context22.t0 = _context22["catch"](0);
          console.log(_context22.t0.message);
          return _context22.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 12:
        case "end":
          return _context22.stop();
      }
    }
  }, null, null, [[0, 8]]);
}; // Filter recipes


var FilterRecipe = function FilterRecipe(req, res) {
  var _req$body10, categoryId, cuisinesIdList, difficultyLevel, query, recipes;

  return regeneratorRuntime.async(function FilterRecipe$(_context23) {
    while (1) {
      switch (_context23.prev = _context23.next) {
        case 0:
          _context23.prev = 0;
          _req$body10 = req.body, categoryId = _req$body10.categoryId, cuisinesIdList = _req$body10.cuisinesIdList, difficultyLevel = _req$body10.difficultyLevel;
          console.log('[DEBUG] FilterRecipe API called');
          console.log('[DEBUG] categoryId:', categoryId);
          console.log('[DEBUG] cuisinesIdList:', cuisinesIdList);
          console.log('[DEBUG] difficultyLevel:', difficultyLevel);
          query = {}; // Filter by category

          if (categoryId && categoryId.trim() !== '') {
            query.categoryId = categoryId;
          } // Filter by cuisines (support both single ID and array)


          if (cuisinesIdList) {
            if (Array.isArray(cuisinesIdList) && cuisinesIdList.length > 0) {
              // If it's an array, use $in operator
              query.cuisinesId = {
                $in: cuisinesIdList
              };
            } else if (typeof cuisinesIdList === 'string' && cuisinesIdList.trim() !== '') {
              // If it's a single string
              query.cuisinesId = cuisinesIdList;
            }
          } // Filter by difficulty level


          if (difficultyLevel && difficultyLevel.trim() !== '') {
            query.difficultyLevel = difficultyLevel;
          }

          console.log('[DEBUG] MongoDB query:', JSON.stringify(query));
          _context23.next = 13;
          return regeneratorRuntime.awrap(recipeModel.find(query).populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }));

        case 13:
          recipes = _context23.sent;
          console.log('[DEBUG] Found filtered recipes:', recipes.length);
          return _context23.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 18:
          _context23.prev = 18;
          _context23.t0 = _context23["catch"](0);
          console.log('[ERROR] FilterRecipe:', _context23.t0.message);
          return _context23.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 22:
        case "end":
          return _context23.stop();
      }
    }
  }, null, null, [[0, 18]]);
}; // Search recipes


var SearchRecipes = function SearchRecipes(req, res) {
  var _req$body11, recipeName, searchTerm, searchQuery, recipes;

  return regeneratorRuntime.async(function SearchRecipes$(_context24) {
    while (1) {
      switch (_context24.prev = _context24.next) {
        case 0:
          _context24.prev = 0;
          _req$body11 = req.body, recipeName = _req$body11.recipeName, searchTerm = _req$body11.searchTerm; // Support both recipeName (from Flutter) and searchTerm parameters

          searchQuery = recipeName || searchTerm || '';
          console.log('[DEBUG] SearchRecipes API called');
          console.log('[DEBUG] recipeName:', recipeName);
          console.log('[DEBUG] searchTerm:', searchTerm);
          console.log('[DEBUG] searchQuery:', searchQuery);

          if (!(!searchQuery || searchQuery.trim() === '')) {
            _context24.next = 14;
            break;
          }

          console.log('[DEBUG] No search query - returning all recipes');
          _context24.next = 11;
          return regeneratorRuntime.awrap(recipeModel.find({}).populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }));

        case 11:
          recipes = _context24.sent;
          _context24.next = 18;
          break;

        case 14:
          // Search for recipes matching the query
          console.log('[DEBUG] Searching for recipes with query:', searchQuery);
          _context24.next = 17;
          return regeneratorRuntime.awrap(recipeModel.find({
            $or: [{
              name: {
                $regex: searchQuery,
                $options: 'i'
              }
            }, {
              ingredients: {
                $regex: searchQuery,
                $options: 'i'
              }
            }, {
              overview: {
                $regex: searchQuery,
                $options: 'i'
              }
            }]
          }).populate('categoryId', 'name').populate('cuisinesId', 'name').sort({
            createdAt: -1
          }));

        case 17:
          recipes = _context24.sent;

        case 18:
          console.log('[DEBUG] Found recipes:', recipes.length);
          return _context24.abrupt("return", res.status(200).json({
            status: true,
            data: recipes
          }));

        case 22:
          _context24.prev = 22;
          _context24.t0 = _context24["catch"](0);
          console.log('[ERROR] SearchRecipes:', _context24.t0.message);
          return _context24.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 26:
        case "end":
          return _context24.stop();
      }
    }
  }, null, null, [[0, 22]]);
}; // Add favourite recipe


var AddFavouriteRecipe = function AddFavouriteRecipe(req, res) {
  var recipeId, userId, existingFavourite, favourite;
  return regeneratorRuntime.async(function AddFavouriteRecipe$(_context25) {
    while (1) {
      switch (_context25.prev = _context25.next) {
        case 0:
          _context25.prev = 0;
          recipeId = req.body.recipeId;
          userId = req.userId;
          _context25.next = 5;
          return regeneratorRuntime.awrap(favouriteRecipeModel.findOne({
            userId: userId,
            recipeId: recipeId
          }));

        case 5:
          existingFavourite = _context25.sent;

          if (!existingFavourite) {
            _context25.next = 8;
            break;
          }

          return _context25.abrupt("return", res.status(400).json({
            status: false,
            message: "Recipe already added to favourites"
          }));

        case 8:
          favourite = new favouriteRecipeModel({
            userId: userId,
            recipeId: recipeId
          });
          _context25.next = 11;
          return regeneratorRuntime.awrap(favourite.save());

        case 11:
          return _context25.abrupt("return", res.status(200).json({
            status: true,
            message: "Recipe added to favourites"
          }));

        case 14:
          _context25.prev = 14;
          _context25.t0 = _context25["catch"](0);
          console.log(_context25.t0.message);
          return _context25.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 18:
        case "end":
          return _context25.stop();
      }
    }
  }, null, null, [[0, 14]]);
}; // Get all favourite recipes


var GetAllFavouriteRecipes = function GetAllFavouriteRecipes(req, res) {
  var userId, favourites;
  return regeneratorRuntime.async(function GetAllFavouriteRecipes$(_context26) {
    while (1) {
      switch (_context26.prev = _context26.next) {
        case 0:
          _context26.prev = 0;
          userId = req.userId;
          _context26.next = 4;
          return regeneratorRuntime.awrap(favouriteRecipeModel.find({
            userId: userId
          }).populate({
            path: 'recipeId',
            populate: [{
              path: 'categoryId',
              select: 'name'
            }, {
              path: 'cuisinesId',
              select: 'name'
            }]
          }).sort({
            createdAt: -1
          }));

        case 4:
          favourites = _context26.sent;
          return _context26.abrupt("return", res.status(200).json({
            status: true,
            data: favourites
          }));

        case 8:
          _context26.prev = 8;
          _context26.t0 = _context26["catch"](0);
          console.log(_context26.t0.message);
          return _context26.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 12:
        case "end":
          return _context26.stop();
      }
    }
  }, null, null, [[0, 8]]);
}; // Delete favourite recipe


var DeleteFavouriteRecipe = function DeleteFavouriteRecipe(req, res) {
  var recipeId, userId;
  return regeneratorRuntime.async(function DeleteFavouriteRecipe$(_context27) {
    while (1) {
      switch (_context27.prev = _context27.next) {
        case 0:
          _context27.prev = 0;
          recipeId = req.body.recipeId;
          userId = req.userId;
          _context27.next = 5;
          return regeneratorRuntime.awrap(favouriteRecipeModel.deleteOne({
            userId: userId,
            recipeId: recipeId
          }));

        case 5:
          return _context27.abrupt("return", res.status(200).json({
            status: true,
            message: "Recipe removed from favourites"
          }));

        case 8:
          _context27.prev = 8;
          _context27.t0 = _context27["catch"](0);
          console.log(_context27.t0.message);
          return _context27.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 12:
        case "end":
          return _context27.stop();
      }
    }
  }, null, null, [[0, 8]]);
}; // Add review


var AddReview = function AddReview(req, res) {
  var _req$body12, recipeId, rating, review, comment, userId, reviewText, newReview;

  return regeneratorRuntime.async(function AddReview$(_context28) {
    while (1) {
      switch (_context28.prev = _context28.next) {
        case 0:
          _context28.prev = 0;
          _req$body12 = req.body, recipeId = _req$body12.recipeId, rating = _req$body12.rating, review = _req$body12.review, comment = _req$body12.comment;
          userId = req.userId;
          console.log('[DEBUG] AddReview API called');
          console.log('[DEBUG] userId:', userId);
          console.log('[DEBUG] recipeId:', recipeId);
          console.log('[DEBUG] rating:', rating);
          console.log('[DEBUG] review:', review);
          console.log('[DEBUG] comment:', comment); // Support both 'review' and 'comment' parameters

          reviewText = review || comment || '';

          if (!(!recipeId || !rating)) {
            _context28.next = 12;
            break;
          }

          return _context28.abrupt("return", res.status(400).json({
            status: false,
            message: "Recipe ID and rating are required"
          }));

        case 12:
          newReview = new reviewModel({
            userId: userId,
            recipeId: recipeId,
            rating: rating,
            comment: reviewText
          });
          _context28.next = 15;
          return regeneratorRuntime.awrap(newReview.save());

        case 15:
          console.log('[DEBUG] Review saved successfully');
          return _context28.abrupt("return", res.status(200).json({
            status: true,
            message: "Review added successfully"
          }));

        case 19:
          _context28.prev = 19;
          _context28.t0 = _context28["catch"](0);
          console.log('[ERROR] AddReview:', _context28.t0.message);
          return _context28.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 23:
        case "end":
          return _context28.stop();
      }
    }
  }, null, null, [[0, 19]]);
}; // Add app feedback (for general feedback from settings)


var AddAppFeedback = function AddAppFeedback(req, res) {
  var _req$body13, rating, comment, userId, newFeedback;

  return regeneratorRuntime.async(function AddAppFeedback$(_context29) {
    while (1) {
      switch (_context29.prev = _context29.next) {
        case 0:
          _context29.prev = 0;
          _req$body13 = req.body, rating = _req$body13.rating, comment = _req$body13.comment;
          userId = req.userId;
          console.log('[DEBUG] AddAppFeedback API called');
          console.log('[DEBUG] userId:', userId);
          console.log('[DEBUG] rating:', rating);
          console.log('[DEBUG] comment:', comment);

          if (rating) {
            _context29.next = 9;
            break;
          }

          return _context29.abrupt("return", res.status(400).json({
            status: false,
            message: "Rating is required"
          }));

        case 9:
          newFeedback = new reviewModel({
            userId: userId,
            recipeId: null,
            // null for app feedback
            rating: rating,
            comment: comment || '',
            feedbackType: 'app' // distinguish app feedback from recipe feedback

          });
          _context29.next = 12;
          return regeneratorRuntime.awrap(newFeedback.save());

        case 12:
          console.log('[DEBUG] App feedback saved successfully');
          return _context29.abrupt("return", res.status(200).json({
            status: true,
            message: "Feedback submitted successfully"
          }));

        case 16:
          _context29.prev = 16;
          _context29.t0 = _context29["catch"](0);
          console.log('[ERROR] AddAppFeedback:', _context29.t0.message);
          return _context29.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 20:
        case "end":
          return _context29.stop();
      }
    }
  }, null, null, [[0, 16]]);
}; // Get reviews by recipe ID (only approved reviews for public)


var GetReviewByRecipeId = function GetReviewByRecipeId(req, res) {
  var recipeId, reviews;
  return regeneratorRuntime.async(function GetReviewByRecipeId$(_context30) {
    while (1) {
      switch (_context30.prev = _context30.next) {
        case 0:
          _context30.prev = 0;
          recipeId = req.body.recipeId;
          console.log('[DEBUG] GetReviewByRecipeId called for recipeId:', recipeId); // Only return enabled reviews for public viewing (simplified system)

          _context30.next = 5;
          return regeneratorRuntime.awrap(reviewModel.find({
            recipeId: recipeId,
            isEnable: true,
            // Only enabled reviews
            $or: [{
              feedbackType: 'recipe'
            }, // New reviews with feedbackType
            {
              feedbackType: {
                $exists: false
              }
            }, // Old reviews without feedbackType
            {
              feedbackType: null
            } // Reviews with null feedbackType
            ]
          }).populate('userId', 'firstname lastname avatar').sort({
            createdAt: -1
          }));

        case 5:
          reviews = _context30.sent;
          console.log('[DEBUG] Found approved reviews:', reviews.length);
          return _context30.abrupt("return", res.status(200).json({
            status: true,
            data: reviews
          }));

        case 10:
          _context30.prev = 10;
          _context30.t0 = _context30["catch"](0);
          console.log('[ERROR] GetReviewByRecipeId:', _context30.t0.message);
          return _context30.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 14:
        case "end":
          return _context30.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // Get all FAQ


var getAllFaq = function getAllFaq(req, res) {
  var faqs;
  return regeneratorRuntime.async(function getAllFaq$(_context31) {
    while (1) {
      switch (_context31.prev = _context31.next) {
        case 0:
          _context31.prev = 0;
          _context31.next = 3;
          return regeneratorRuntime.awrap(faqModel.find().sort({
            createdAt: -1
          }));

        case 3:
          faqs = _context31.sent;
          return _context31.abrupt("return", res.status(200).json({
            status: true,
            data: faqs
          }));

        case 7:
          _context31.prev = 7;
          _context31.t0 = _context31["catch"](0);
          console.log(_context31.t0.message);
          return _context31.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context31.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get admob ads


var getAdmob = function getAdmob(req, res) {
  var ads;
  return regeneratorRuntime.async(function getAdmob$(_context32) {
    while (1) {
      switch (_context32.prev = _context32.next) {
        case 0:
          _context32.prev = 0;
          _context32.next = 3;
          return regeneratorRuntime.awrap(adsModel.find());

        case 3:
          ads = _context32.sent;
          return _context32.abrupt("return", res.status(200).json({
            status: true,
            data: ads
          }));

        case 7:
          _context32.prev = 7;
          _context32.t0 = _context32["catch"](0);
          console.log(_context32.t0.message);
          return _context32.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context32.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get policy and terms


var GetPolicyAndTerms = function GetPolicyAndTerms(req, res) {
  var settings;
  return regeneratorRuntime.async(function GetPolicyAndTerms$(_context33) {
    while (1) {
      switch (_context33.prev = _context33.next) {
        case 0:
          _context33.prev = 0;
          _context33.next = 3;
          return regeneratorRuntime.awrap(settingModel.find());

        case 3:
          settings = _context33.sent;
          return _context33.abrupt("return", res.status(200).json({
            status: true,
            data: settings
          }));

        case 7:
          _context33.prev = 7;
          _context33.t0 = _context33["catch"](0);
          console.log(_context33.t0.message);
          return _context33.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 11:
        case "end":
          return _context33.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get unread notification count


var GetUnreadNotificationCount = function GetUnreadNotificationCount(req, res) {
  var userId, shouldLog, notifications, unreadCount, _iteratorNormalCompletion, _didIteratorError, _iteratorError, _iterator, _step, notification, readByUser;

  return regeneratorRuntime.async(function GetUnreadNotificationCount$(_context34) {
    while (1) {
      switch (_context34.prev = _context34.next) {
        case 0:
          _context34.prev = 0;
          userId = req.query.userId;

          if (userId) {
            _context34.next = 4;
            break;
          }

          return _context34.abrupt("return", res.status(400).json({
            status: false,
            message: "User ID is required"
          }));

        case 4:
          // Reduce debug logging to prevent spam - only log occasionally
          shouldLog = Math.random() < 0.05; // Log only ~5% of requests

          if (shouldLog) {
            console.log("[DEBUG] GetUnreadNotificationCount - userId: ".concat(userId));
          } // Get all enabled notifications


          _context34.next = 8;
          return regeneratorRuntime.awrap(notificationModel.find({
            isEnabled: {
              $ne: false
            }
          }));

        case 8:
          notifications = _context34.sent;
          // Count unread notifications (those not in user's readNotifications array)
          unreadCount = 0;
          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context34.prev = 13;

          for (_iterator = notifications[Symbol.iterator](); !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
            notification = _step.value;
            readByUser = notification.readNotifications && notification.readNotifications.includes(userId);

            if (!readByUser) {
              unreadCount++;
            }
          }

          _context34.next = 21;
          break;

        case 17:
          _context34.prev = 17;
          _context34.t0 = _context34["catch"](13);
          _didIteratorError = true;
          _iteratorError = _context34.t0;

        case 21:
          _context34.prev = 21;
          _context34.prev = 22;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 24:
          _context34.prev = 24;

          if (!_didIteratorError) {
            _context34.next = 27;
            break;
          }

          throw _iteratorError;

        case 27:
          return _context34.finish(24);

        case 28:
          return _context34.finish(21);

        case 29:
          if (shouldLog) {
            console.log("[DEBUG] Found ".concat(notifications.length, " enabled notifications"));
            console.log("[DEBUG] User ".concat(userId, " has ").concat(unreadCount, " unread notifications"));
          }

          res.status(200).json({
            status: true,
            data: {
              unreadCount: unreadCount
            }
          });
          _context34.next = 37;
          break;

        case 33:
          _context34.prev = 33;
          _context34.t1 = _context34["catch"](0);
          console.error('Error getting unread notification count:', _context34.t1);
          res.status(500).json({
            status: false,
            message: "Internal server error"
          });

        case 37:
        case "end":
          return _context34.stop();
      }
    }
  }, null, null, [[0, 33], [13, 17, 21, 29], [22,, 24, 28]]);
}; // Mark notifications as read


var MarkNotificationAsRead = function MarkNotificationAsRead(req, res) {
  var _req$body14, userId, notificationIds, updateQuery, result;

  return regeneratorRuntime.async(function MarkNotificationAsRead$(_context35) {
    while (1) {
      switch (_context35.prev = _context35.next) {
        case 0:
          _context35.prev = 0;
          _req$body14 = req.body, userId = _req$body14.userId, notificationIds = _req$body14.notificationIds;

          if (userId) {
            _context35.next = 4;
            break;
          }

          return _context35.abrupt("return", res.status(400).json({
            status: false,
            message: "User ID is required"
          }));

        case 4:
          if (notificationIds && Array.isArray(notificationIds) && notificationIds.length > 0) {
            // Mark specific notifications as read
            updateQuery = {
              _id: {
                $in: notificationIds
              }
            };
          } else {
            // Mark all notifications as read
            updateQuery = {
              isEnabled: {
                $ne: false
              }
            };
          } // Add userId to readNotifications array if not already present


          _context35.next = 7;
          return regeneratorRuntime.awrap(notificationModel.updateMany(_objectSpread({}, updateQuery, {
            readNotifications: {
              $ne: userId
            }
          }), {
            $push: {
              readNotifications: userId
            }
          }));

        case 7:
          result = _context35.sent;
          console.log("[DEBUG] Marked ".concat(result.modifiedCount, " notifications as read for user ").concat(userId));
          res.status(200).json({
            status: true,
            message: "Notifications marked as read",
            data: {
              modifiedCount: result.modifiedCount
            }
          });
          _context35.next = 16;
          break;

        case 12:
          _context35.prev = 12;
          _context35.t0 = _context35["catch"](0);
          console.error('Error marking notifications as read:', _context35.t0);
          res.status(500).json({
            status: false,
            message: "Internal server error"
          });

        case 16:
        case "end":
          return _context35.stop();
      }
    }
  }, null, null, [[0, 12]]);
}; // Get all notifications


var GetAllNotification = function GetAllNotification(req, res) {
  var showAll, filter, notifications, mappedNotifications;
  return regeneratorRuntime.async(function GetAllNotification$(_context36) {
    while (1) {
      switch (_context36.prev = _context36.next) {
        case 0:
          _context36.prev = 0;
          // Allow admin to see all notifications (including disabled) for debugging
          showAll = req.query.showAll === 'true';
          filter = {};

          if (!showAll) {
            // For normal app users: only show enabled notifications
            filter = {
              isEnabled: {
                $ne: false
              }
            };
          }

          console.log("[DEBUG] GetAllNotification - showAll: ".concat(showAll, ", filter:"), filter);
          _context36.next = 7;
          return regeneratorRuntime.awrap(notificationModel.find(filter).populate('recipeId', 'name image').sort({
            createdAt: -1
          }));

        case 7:
          notifications = _context36.sent;
          console.log("[DEBUG] Found ".concat(notifications.length, " notifications")); // Map fields to match Flutter app expectations

          mappedNotifications = notifications.map(function (notification) {
            return {
              _id: notification._id,
              title: notification.title,
              description: notification.message,
              // Map message to description for Flutter app
              message: notification.message,
              // Keep original for backward compatibility
              date: notification.date,
              type: notification.type,
              recipeId: notification.recipeId,
              recipeName: notification.recipeName,
              isEnabled: notification.isEnabled,
              createdAt: notification.createdAt,
              updatedAt: notification.updatedAt
            };
          });
          return _context36.abrupt("return", res.status(200).json({
            status: true,
            data: {
              notification: mappedNotifications
            }
          }));

        case 13:
          _context36.prev = 13;
          _context36.t0 = _context36["catch"](0);
          console.log(_context36.t0.message);
          return _context36.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 17:
        case "end":
          return _context36.stop();
      }
    }
  }, null, null, [[0, 13]]);
}; // Admin API: Get all reviews for approval


var GetAllReviewsForApproval = function GetAllReviewsForApproval(req, res) {
  var reviews;
  return regeneratorRuntime.async(function GetAllReviewsForApproval$(_context37) {
    while (1) {
      switch (_context37.prev = _context37.next) {
        case 0:
          _context37.prev = 0;
          console.log('[DEBUG] GetAllReviewsForApproval called');
          _context37.next = 4;
          return regeneratorRuntime.awrap(reviewModel.find({
            feedbackType: 'recipe' // Only recipe reviews, not app feedback

          }).populate('userId', 'firstname lastname avatar').populate('recipeId', 'name image').sort({
            createdAt: -1
          }));

        case 4:
          reviews = _context37.sent;
          console.log('[DEBUG] Found total reviews for approval:', reviews.length);
          return _context37.abrupt("return", res.status(200).json({
            status: true,
            data: reviews
          }));

        case 9:
          _context37.prev = 9;
          _context37.t0 = _context37["catch"](0);
          console.log('[ERROR] GetAllReviewsForApproval:', _context37.t0.message);
          return _context37.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 13:
        case "end":
          return _context37.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Admin API: Approve review


var ApproveReview = function ApproveReview(req, res) {
  var reviewId, updatedReview;
  return regeneratorRuntime.async(function ApproveReview$(_context38) {
    while (1) {
      switch (_context38.prev = _context38.next) {
        case 0:
          _context38.prev = 0;
          reviewId = req.body.reviewId;
          console.log('[DEBUG] ApproveReview called for reviewId:', reviewId);
          _context38.next = 5;
          return regeneratorRuntime.awrap(reviewModel.findByIdAndUpdate(reviewId, {
            isApproved: true
          }, {
            "new": true
          }));

        case 5:
          updatedReview = _context38.sent;

          if (updatedReview) {
            _context38.next = 8;
            break;
          }

          return _context38.abrupt("return", res.status(404).json({
            status: false,
            message: "Review not found"
          }));

        case 8:
          console.log('[DEBUG] Review approved successfully');
          return _context38.abrupt("return", res.status(200).json({
            status: true,
            message: "Review approved successfully",
            data: updatedReview
          }));

        case 12:
          _context38.prev = 12;
          _context38.t0 = _context38["catch"](0);
          console.log('[ERROR] ApproveReview:', _context38.t0.message);
          return _context38.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 16:
        case "end":
          return _context38.stop();
      }
    }
  }, null, null, [[0, 12]]);
}; // Admin API: Reject review


var RejectReview = function RejectReview(req, res) {
  var reviewId, updatedReview;
  return regeneratorRuntime.async(function RejectReview$(_context39) {
    while (1) {
      switch (_context39.prev = _context39.next) {
        case 0:
          _context39.prev = 0;
          reviewId = req.body.reviewId;
          console.log('[DEBUG] RejectReview called for reviewId:', reviewId);
          _context39.next = 5;
          return regeneratorRuntime.awrap(reviewModel.findByIdAndUpdate(reviewId, {
            isApproved: false
          }, {
            "new": true
          }));

        case 5:
          updatedReview = _context39.sent;

          if (updatedReview) {
            _context39.next = 8;
            break;
          }

          return _context39.abrupt("return", res.status(404).json({
            status: false,
            message: "Review not found"
          }));

        case 8:
          console.log('[DEBUG] Review rejected successfully');
          return _context39.abrupt("return", res.status(200).json({
            status: true,
            message: "Review rejected successfully",
            data: updatedReview
          }));

        case 12:
          _context39.prev = 12;
          _context39.t0 = _context39["catch"](0);
          console.log('[ERROR] RejectReview:', _context39.t0.message);
          return _context39.abrupt("return", res.status(500).json({
            status: false,
            message: "Internal server error"
          }));

        case 16:
        case "end":
          return _context39.stop();
      }
    }
  }, null, null, [[0, 12]]);
};

module.exports = {
  CheckRegisterUser: CheckRegisterUser,
  SignUp: SignUp,
  VerifyOtp: VerifyOtp,
  SignIn: SignIn,
  isVerifyAccount: isVerifyAccount,
  resendOtp: resendOtp,
  ForgotPassword: ForgotPassword,
  ForgotPasswordVerification: ForgotPasswordVerification,
  ResetPassword: ResetPassword,
  UserEdit: UserEdit,
  GetUser: GetUser,
  UploadImage: UploadImage,
  ChangePassword: ChangePassword,
  DeleteAccountUser: DeleteAccountUser,
  getAllIntro: getAllIntro,
  GetAllCategory: GetAllCategory,
  GetAllCuisines: GetAllCuisines,
  GetAllRecipe: GetAllRecipe,
  popularRecipe: popularRecipe,
  recommendedRecipe: recommendedRecipe,
  GetRecipeById: GetRecipeById,
  GetRecipeByCategoryId: GetRecipeByCategoryId,
  FilterRecipe: FilterRecipe,
  SearchRecipes: SearchRecipes,
  AddFavouriteRecipe: AddFavouriteRecipe,
  GetAllFavouriteRecipes: GetAllFavouriteRecipes,
  DeleteFavouriteRecipe: DeleteFavouriteRecipe,
  AddReview: AddReview,
  AddAppFeedback: AddAppFeedback,
  GetReviewByRecipeId: GetReviewByRecipeId,
  GetAllReviewsForApproval: GetAllReviewsForApproval,
  ApproveReview: ApproveReview,
  RejectReview: RejectReview,
  getAllFaq: getAllFaq,
  getAdmob: getAdmob,
  GetPolicyAndTerms: GetPolicyAndTerms,
  GetUnreadNotificationCount: GetUnreadNotificationCount,
  MarkNotificationAsRead: MarkNotificationAsRead,
  GetAllNotification: GetAllNotification
};
