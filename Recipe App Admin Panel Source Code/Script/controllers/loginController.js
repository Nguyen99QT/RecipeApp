// Importing required modules 
const sha256 = require("sha256");

// Importing models
const userModel = require("../model/userModel");
const categoryModel = require("../model/categoryModel");
const cuisinesModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const adminLoginModel = require("../model/adminLoginModel");

// Importing the service function to delete uploaded files
const { deleteImages } = require("../services/deleteImage");

// Load view for login
const loadLogin = async (req, res) => {

    try {

        return res.render("login");

    } catch (error) {
        console.log(error.message);
    }
}

//login
const login = async (req, res) => {

    try {


        // Extract data from the request body
        const email = req.body.email;
        const password = sha256.x2(req.body.password);

        const isExistEmail = await adminLoginModel.findOne({ email });

        if (!isExistEmail) {

            req.flash('error', 'We’re sorry, something went wrong when attempting to sign in.');
            return res.redirect('back');

        } else {

            if (password !== isExistEmail.password) {

                req.flash('error', 'We’re sorry, something went wrong when attempting to sign in.');
                return res.redirect('back');

            } else {

                req.session.userId = isExistEmail._id;
                return res.redirect("/dashboard");

            }
        }

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for dashboard
const loadDashboard = async (req, res) => {

    try {

        // count
        const totalCategory = await categoryModel.countDocuments();
        const totalCuisines = await cuisinesModel.countDocuments();
        const totalRecipe = await recipeModel.countDocuments();
        const totalUser = await userModel.countDocuments();

        return res.render("dashboard", { totalCategory, totalCuisines, totalRecipe, totalUser })

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for user
const loadUser = async (req, res) => {

    try {

        const user = await userModel.find();

        return res.render("user", { user, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
    }
}

//for active user
const isActiveUser = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request
            const id = req.query.id;

            // Find current user
            const currentUser = await userModel.findById({ _id: id });

            await userModel.findByIdAndUpdate({ _id: id }, { $set: { is_active: currentUser.is_active === 0 ? 1 : 0 } }, { new: true });

            return res.redirect('back');
        }
        else {

            req.flash('error', 'You have no access to active/disactive user, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for profile
const loadProfile = async (req, res) => {

    try {

        const profile = await adminLoginModel.findById(req.session.userId);

        return res.render("profile", { profile, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
    }
}


// Load view for  edit profile
const loadEditProfile = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        const profile = await adminLoginModel.findById(id);

        return res.render("editprofile", { profile, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
    }
}

//edit profile
const editProfile = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.body.id;
        const oldImage = req.body.oldImage;

        let avatar = oldImage;
        if (req.file) {
            deleteImages(oldImage);
            avatar = req.file.filename;
        }

        const profile = await adminLoginModel.findOneAndUpdate({ _id: id }, { $set: { name: req.body.name, contact: req.body.contact, avatar: avatar } }, { new: true });

        return res.redirect("/profile");

    } catch (error) {
        console.log(error.message);
    }
}

//Load and render the change password
const loadChangePassword = async (req, res) => {

    try {

        return res.render("changePassword");

    } catch (error) {
        console.log(error.message);
    }
}

//change password
const changePassword = async (req, res) => {

    try {

        const oldpassword = sha256.x2(req.body.oldpassword);
        const newpassword = sha256.x2(req.body.newpassword);
        const comfirmpassword = sha256.x2(req.body.comfirmpassword);

        if (newpassword !== comfirmpassword) {
            req.flash('error', 'Confirm password does not match');
            return res.redirect('back');
        }

        const matchPassword = await adminLoginModel.findOne({ password: oldpassword });

        if (!matchPassword) {
            req.flash('error', 'Current password is wrong, please try again');
            return res.redirect('back');
        }

        await adminLoginModel.findOneAndUpdate({ password: oldpassword }, { $set: { password: newpassword } }, { new: true });

        return res.redirect("/dashboard")

    } catch (error) {
        console.log(error.message);
    }
}

//logout
const logout = async (req, res) => {

    try {

        // Destroy the session
        req.session.destroy(function (err) {
            if (err) {
                console.error('Error destroying session:', err);
                return res.status(500).send('Internal Server Error');
            }

            // Clear the cookie
            res.clearCookie('connect.sid');

            return res.redirect("/login");
        });

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    loadLogin,
    login,
    loadProfile,
    loadEditProfile,
    editProfile,
    loadDashboard,
    loadUser,
    isActiveUser,
    loadChangePassword,
    changePassword,
    logout
}