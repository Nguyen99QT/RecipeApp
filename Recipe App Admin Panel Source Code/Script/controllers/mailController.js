// Importing required modules 

// Importing models
const loginModel = require("../model/adminLoginModel");
const mailModel = require("../model/mailModel");

// Load and render the mail view
const loadMailConfig = async (req, res) => {

    try {

        // fetch mail details
        const mailData = await mailModel.findOne();

        return res.render("mailConfig", { mailData });

    } catch (error) {
        console.log(error.message);
    }
}

//edit mail config
const mailConfig = async (req, res) => {

    try {

        const loginData = await loginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request
            const id = req.body.id;
            const host = req.body.host;
            const port = req.body.port;
            const mail_username = req.body.mail_username;
            const mail_password = req.body.mail_password;
            const encryption = req.body.encryption;
            const senderEmail = req.body.senderEmail;

            // Attempt to find the existing mail configuration record
            const existingMailConfig = await mailModel.findOne();

            if (existingMailConfig) {

                // Attempt to find and update an existing document
                result = await mailModel.findByIdAndUpdate(id, { host, port, mail_username, mail_password, encryption, senderEmail }, { new: true });

                req.flash("success", "Mail configuration updated successfully.");
                return res.redirect('back');

            } else {

                // Create a new document if no id is provided
                result = await mailModel.create({ host, port, mail_username, mail_password, encryption, senderEmail });

                req.flash("success", "Mail configuration added successfully.");
                return res.redirect('back');
            }

        }
        else {

            req.flash('error', 'You have no access to edit mail configurations, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}


module.exports = {

    loadMailConfig,
    mailConfig
}