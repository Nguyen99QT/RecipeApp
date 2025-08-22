// Importing models
const adminLoginModel = require("../model/adminLoginModel");

const isLogin = async (req, res, next) => {

    try {

        if (req.session.userId) {

            const admin = await adminLoginModel.findById({ _id: req.session.userId });

            if (!admin) {
                throw new Error('Admin not found');
            }

            res.locals.admin = admin;
            next();
        }
        else {

            return res.redirect('/');
        }

    } catch (error) {
        console.log(error.message);
    }
}

const isLogout = async (req, res, next) => {

    try {

        if (req.session.userId) {
            return res.redirect('/dashboard');
        }
        next();

    } catch (error) {
        console.log(error.message);
    }

}

module.exports = {
    isLogin,
    isLogout,
}

