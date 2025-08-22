// Importing required modules 

// Importing models
const loginModel = require("../model/adminLoginModel");
const introModel = require("../model/introModel");

// Importing the service function to delete uploaded files
const { deleteImages } = require("../services/deleteImage");

// Load and render the view for add intro
const loadAddIntro = async (req, res) => {

    try {

        return res.render("addIntro");

    } catch (error) {
        console.log(error.message);
    }
}

// add intro
const addIntro = async (req, res) => {

    try {

        const loginData = await loginModel.findById(req.session.adminId);

        if (loginData && loginData.is_admin === 0) {

            // delete upload image
            deleteImages(req.file.filename);

            req.flash('error', 'You do not have permission to add intro. As a demo admin, you can only view the content.');
            return res.redirect('back');
        }

        // Extract data from the request body
        const image = req.file.filename;
        const title = req.body.title;
        const description = req.body.description;

        // save intro
        const newIntro = new introModel({ image, title, description }).save();

        return res.redirect('/intro');

    } catch (error) {
        console.log(error.mssage);
    }
}

// Load and render the view for intro
const loadIntro = async (req, res) => {

    try {

        // fetch all intro
        const intro = await introModel.find();

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("intro", { intro, IMAGE_URL: process.env.IMAGE_URL, loginData });

    } catch (error) {
        console.log(error.message);
    }
}

// Load and render the view for edit intro
const loadEditIntro = async (req, res) => {

    try {

        // Extract data from the request query
        const id = req.query.id;

        // fetch intro using id
        const intro = await introModel.findOne({ _id: id });

        return res.render("editIntro", { intro, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
    }
}

// edit intro
const editIntro = async (req, res) => {

    try {

        // Extract data from the request body
        const id = req.body.id;
        const title = req.body.title;
        const description = req.body.description;
        const oldImage = req.body.oldImage;

        let image = oldImage;
        if (req.file) {
            // delete old image
            deleteImages(oldImage);
            image = req.file.filename;
        }

        // update intro
        const updateIntro = await introModel.findOneAndUpdate({ _id: id }, { $set: { title, description, image } });

        return res.redirect("/intro")

    } catch (error) {
        console.log(error.message);
    }
}

// delete intro
const deleteIntro = async (req, res) => {

    try {

        // Extract data from the request query
        const id = req.query.id;

        // fetch intro using id
        const intro = await introModel.findById(id);

        // delete image
        deleteImages(intro.image);

        // delete intro
        const deletedIntro = await introModel.deleteOne({ _id: id });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    loadAddIntro,
    addIntro,
    loadIntro,
    loadEditIntro,
    editIntro,
    deleteIntro
}