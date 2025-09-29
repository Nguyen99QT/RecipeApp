// Importing required modules 

// Importing models
const loginModel = require("../model/adminLoginModel");
const faqModel = require("../model/faqModel");

// Load and render the view for add faq
const loadAddFaq = async (req, res) => {

    try {

        return res.render("addFaq");

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// add faq
const addFaq = async (req, res) => {

    try {

        // Extract data from the request body
        const question = req.body.question;
        const answer = req.body.answer.replace(/"/g, '&quot;');;
        const status = req.body.status;

        // save faq
        const saveFaq = await new faqModel({ question, answer, status }).save();

        return res.redirect('/faq');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// Load and render the view for faq
const loadFaq = async (req, res) => {

    try {

        // fetch all faq
        const faq = await faqModel.find();

        // fetch admin
        const loginData = await loginModel.find();

        return res.render("faq", { faq, loginData });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// Load and render the view for edit faq
const loadEditFaq = async (req, res) => {

    try {

        // Extrcat data from the request query
        const id = req.query.id;

        // fetch faq
        const faq = await faqModel.findOne({ _id: id });

        return res.render("editFaq", { faq });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// edit faq
const editFaq = async (req, res) => {

    try {

        // Extract data from the request body
        const id = req.body.id;
        const question = req.body.question;
        const answer = req.body.answer.replace(/"/g, '&quot;');;
        const status = req.body.status;

        // update faq
        const updatedFaq = await faqModel.findOneAndUpdate({ _id: id }, { question, answer, status }, { new: true });

        return res.redirect("/faq");

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// delete faq
const deleteFaq = async (req, res) => {

    try {

        // Extract data from the request query
        const id = req.query.id;

        // delete faq
        const deletedFaq = await faqModel.deleteOne({ _id: id });

        return res.redirect("back");

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

module.exports = {

    loadAddFaq,
    addFaq,
    loadFaq,
    loadEditFaq,
    editFaq,
    deleteFaq
}
