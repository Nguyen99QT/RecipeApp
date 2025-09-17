"use strict";

// Importing required modules 
var sha256 = require("sha256"); // Importing models


var userModel = require("../model/userModel");

var categoryModel = require("../model/categoryModel");

var cuisinesModel = require("../model/cuisinesModel");

var recipeModel = require("../model/recipeModel");

var adminLoginModel = require("../model/adminLoginModel"); // Importing the service function to delete uploaded files


var _require = require("../services/deleteImage"),
    deleteImages = _require.deleteImages; // Load view for login


var loadLogin = function loadLogin(req, res) {
  return regeneratorRuntime.async(function loadLogin$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          return _context.abrupt("return", res.render("login"));

        case 4:
          _context.prev = 4;
          _context.t0 = _context["catch"](0);
          console.log(_context.t0.message);

        case 7:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 4]]);
}; //login


var login = function login(req, res) {
  var email, password, isExistEmail;
  return regeneratorRuntime.async(function login$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          // Extract data from the request body
          email = req.body.email;
          password = sha256.x2(req.body.password);
          _context2.next = 5;
          return regeneratorRuntime.awrap(adminLoginModel.findOne({
            email: email
          }));

        case 5:
          isExistEmail = _context2.sent;

          if (isExistEmail) {
            _context2.next = 11;
            break;
          }

          req.flash('error', 'We’re sorry, something went wrong when attempting to sign in.');
          return _context2.abrupt("return", res.redirect('back'));

        case 11:
          if (!(password !== isExistEmail.password)) {
            _context2.next = 16;
            break;
          }

          req.flash('error', 'We’re sorry, something went wrong when attempting to sign in.');
          return _context2.abrupt("return", res.redirect('back'));

        case 16:
          req.session.userId = isExistEmail._id;
          return _context2.abrupt("return", res.redirect("/dashboard"));

        case 18:
          _context2.next = 23;
          break;

        case 20:
          _context2.prev = 20;
          _context2.t0 = _context2["catch"](0);
          console.log(_context2.t0.message);

        case 23:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 20]]);
}; // Load view for dashboard


var loadDashboard = function loadDashboard(req, res) {
  var totalCategory, totalCuisines, totalRecipe, totalUser;
  return regeneratorRuntime.async(function loadDashboard$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(categoryModel.countDocuments());

        case 3:
          totalCategory = _context3.sent;
          _context3.next = 6;
          return regeneratorRuntime.awrap(cuisinesModel.countDocuments());

        case 6:
          totalCuisines = _context3.sent;
          _context3.next = 9;
          return regeneratorRuntime.awrap(recipeModel.countDocuments());

        case 9:
          totalRecipe = _context3.sent;
          _context3.next = 12;
          return regeneratorRuntime.awrap(userModel.countDocuments());

        case 12:
          totalUser = _context3.sent;
          return _context3.abrupt("return", res.render("dashboard", {
            totalCategory: totalCategory,
            totalCuisines: totalCuisines,
            totalRecipe: totalRecipe,
            totalUser: totalUser
          }));

        case 16:
          _context3.prev = 16;
          _context3.t0 = _context3["catch"](0);
          console.log(_context3.t0.message);

        case 19:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 16]]);
}; // Load view for user


var loadUser = function loadUser(req, res) {
  var user;
  return regeneratorRuntime.async(function loadUser$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(userModel.find());

        case 3:
          user = _context4.sent;
          return _context4.abrupt("return", res.render("user", {
            user: user,
            IMAGE_URL: process.env.IMAGE_URL
          }));

        case 7:
          _context4.prev = 7;
          _context4.t0 = _context4["catch"](0);
          console.log(_context4.t0.message);

        case 10:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; //for active user


var isActiveUser = function isActiveUser(req, res) {
  var loginData, id, currentUser;
  return regeneratorRuntime.async(function isActiveUser$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          loginData = _context5.sent;

          if (!(loginData && loginData.is_admin === 1)) {
            _context5.next = 14;
            break;
          }

          // Extract data from the request
          id = req.query.id; // Find current user

          _context5.next = 8;
          return regeneratorRuntime.awrap(userModel.findById({
            _id: id
          }));

        case 8:
          currentUser = _context5.sent;
          _context5.next = 11;
          return regeneratorRuntime.awrap(userModel.findByIdAndUpdate({
            _id: id
          }, {
            $set: {
              is_active: currentUser.is_active === 0 ? 1 : 0
            }
          }, {
            "new": true
          }));

        case 11:
          return _context5.abrupt("return", res.redirect('back'));

        case 14:
          req.flash('error', 'You have no access to active/disactive user, Only admin have access to this functionality...!!');
          return _context5.abrupt("return", res.redirect('back'));

        case 16:
          _context5.next = 21;
          break;

        case 18:
          _context5.prev = 18;
          _context5.t0 = _context5["catch"](0);
          console.log(_context5.t0.message);

        case 21:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 18]]);
}; // Load view for profile


var loadProfile = function loadProfile(req, res) {
  var profile;
  return regeneratorRuntime.async(function loadProfile$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(adminLoginModel.findById(req.session.userId));

        case 3:
          profile = _context6.sent;
          return _context6.abrupt("return", res.render("profile", {
            profile: profile,
            IMAGE_URL: process.env.IMAGE_URL
          }));

        case 7:
          _context6.prev = 7;
          _context6.t0 = _context6["catch"](0);
          console.log(_context6.t0.message);

        case 10:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Load view for  edit profile


var loadEditProfile = function loadEditProfile(req, res) {
  var id, profile;
  return regeneratorRuntime.async(function loadEditProfile$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          // Extract data from the request
          id = req.query.id;
          _context7.next = 4;
          return regeneratorRuntime.awrap(adminLoginModel.findById(id));

        case 4:
          profile = _context7.sent;
          return _context7.abrupt("return", res.render("editprofile", {
            profile: profile,
            IMAGE_URL: process.env.IMAGE_URL
          }));

        case 8:
          _context7.prev = 8;
          _context7.t0 = _context7["catch"](0);
          console.log(_context7.t0.message);

        case 11:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 8]]);
}; //edit profile


var editProfile = function editProfile(req, res) {
  var id, oldImage, avatar, profile;
  return regeneratorRuntime.async(function editProfile$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          _context8.prev = 0;
          // Extract data from the request
          id = req.body.id;
          oldImage = req.body.oldImage;
          avatar = oldImage;

          if (req.file) {
            deleteImages(oldImage);
            avatar = req.file.filename;
          }

          _context8.next = 7;
          return regeneratorRuntime.awrap(adminLoginModel.findOneAndUpdate({
            _id: id
          }, {
            $set: {
              name: req.body.name,
              contact: req.body.contact,
              avatar: avatar
            }
          }, {
            "new": true
          }));

        case 7:
          profile = _context8.sent;
          return _context8.abrupt("return", res.redirect("/profile"));

        case 11:
          _context8.prev = 11;
          _context8.t0 = _context8["catch"](0);
          console.log(_context8.t0.message);

        case 14:
        case "end":
          return _context8.stop();
      }
    }
  }, null, null, [[0, 11]]);
}; //Load and render the change password


var loadChangePassword = function loadChangePassword(req, res) {
  return regeneratorRuntime.async(function loadChangePassword$(_context9) {
    while (1) {
      switch (_context9.prev = _context9.next) {
        case 0:
          _context9.prev = 0;
          return _context9.abrupt("return", res.render("changePassword"));

        case 4:
          _context9.prev = 4;
          _context9.t0 = _context9["catch"](0);
          console.log(_context9.t0.message);

        case 7:
        case "end":
          return _context9.stop();
      }
    }
  }, null, null, [[0, 4]]);
}; //change password


var changePassword = function changePassword(req, res) {
  var oldpassword, newpassword, comfirmpassword, matchPassword;
  return regeneratorRuntime.async(function changePassword$(_context10) {
    while (1) {
      switch (_context10.prev = _context10.next) {
        case 0:
          _context10.prev = 0;
          oldpassword = sha256.x2(req.body.oldpassword);
          newpassword = sha256.x2(req.body.newpassword);
          comfirmpassword = sha256.x2(req.body.comfirmpassword);

          if (!(newpassword !== comfirmpassword)) {
            _context10.next = 7;
            break;
          }

          req.flash('error', 'Confirm password does not match');
          return _context10.abrupt("return", res.redirect('back'));

        case 7:
          _context10.next = 9;
          return regeneratorRuntime.awrap(adminLoginModel.findOne({
            password: oldpassword
          }));

        case 9:
          matchPassword = _context10.sent;

          if (matchPassword) {
            _context10.next = 13;
            break;
          }

          req.flash('error', 'Current password is wrong, please try again');
          return _context10.abrupt("return", res.redirect('back'));

        case 13:
          _context10.next = 15;
          return regeneratorRuntime.awrap(adminLoginModel.findOneAndUpdate({
            password: oldpassword
          }, {
            $set: {
              password: newpassword
            }
          }, {
            "new": true
          }));

        case 15:
          return _context10.abrupt("return", res.redirect("/dashboard"));

        case 18:
          _context10.prev = 18;
          _context10.t0 = _context10["catch"](0);
          console.log(_context10.t0.message);

        case 21:
        case "end":
          return _context10.stop();
      }
    }
  }, null, null, [[0, 18]]);
}; //logout


var logout = function logout(req, res) {
  return regeneratorRuntime.async(function logout$(_context11) {
    while (1) {
      switch (_context11.prev = _context11.next) {
        case 0:
          try {
            // Destroy the session
            req.session.destroy(function (err) {
              if (err) {
                console.error('Error destroying session:', err);
                return res.status(500).send('Internal Server Error');
              } // Clear the cookie


              res.clearCookie('connect.sid');
              return res.redirect("/login");
            });
          } catch (error) {
            console.log(error.message);
          }

        case 1:
        case "end":
          return _context11.stop();
      }
    }
  });
};

module.exports = {
  loadLogin: loadLogin,
  login: login,
  loadProfile: loadProfile,
  loadEditProfile: loadEditProfile,
  editProfile: editProfile,
  loadDashboard: loadDashboard,
  loadUser: loadUser,
  isActiveUser: isActiveUser,
  loadChangePassword: loadChangePassword,
  changePassword: changePassword,
  logout: logout
};