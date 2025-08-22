// Importing required modules 
const nodemailer = require("nodemailer");
const path = require("path");
const hbs = require("nodemailer-express-handlebars");

// Importing models
const mailModel = require("../model/mailModel");

// Function to send OTP verification email
const sendOtpMail = async (email, otp, firstname = 'User', lastname = '') => {

    try {

        // Fetch Mail deatails
        const SMTP = await mailModel.findOne();

        if (!SMTP) {
            throw new Error("Mail details not found");
        }

        // Mail transporter configuration
        const transporter = nodemailer.createTransport({
            host: SMTP.host,
            port: SMTP.port,
            secure: false,
            requireTLS: true,
            auth: {
                user: SMTP.mail_username,
                pass: SMTP.mail_password
            }
        });

        // Path for mail templates
        const templatesPath = path.resolve(__dirname, "../views/mail-templates/");

        // Handlebars setup for nodemailer
        const handlebarOptions = {
            viewEngine: {
                partialsDir: templatesPath,
                defaultLayout: false,
            },
            viewPath: templatesPath,
        };

        transporter.use('compile', hbs(handlebarOptions));

        // Validate input parameters
        if (!otp || !email || !firstname || !lastname) {
            throw new Error("Invalid input parameters");
        }

        const mailOptions = {
            from: SMTP.senderEmail,
            template: "otp",
            to: email,
            subject: 'OTP Verification',
            context: {
                OTP: otp,
                email: email,
                firstname: firstname,
                lastname: lastname
            }
        };

        // Sending the email
        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.error("Failed to send mail:", error);
            } else {
                console.log("Email sent:", info.response);
            }
        });

    } catch (error) {
        console.error("Error sending OTP mail:", error.message);
        throw error;
    }

};

module.exports = sendOtpMail;