// Importing required modules 
const nodemailer = require("nodemailer");
const path = require("path");
const hbs = require("nodemailer-express-handlebars");

// Importing models
const mailModel = require("../model/mailModel");

// Function to send OTP verification email
const sendOtpMail = async (email, otp, firstname = 'User', lastname = '') => {

    try {
        console.log('=== SENDING OTP EMAIL ===');
        console.log('Email:', email, 'OTP:', otp, 'Name:', firstname, lastname);

        // Fetch Mail deatails
        const SMTP = await mailModel.findOne();
        console.log('SMTP config found:', SMTP ? 'Yes' : 'No');

        if (!SMTP) {
            throw new Error("Mail details not found - Please configure SMTP settings in admin panel");
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

        console.log('Transporter created with host:', SMTP.host, 'port:', SMTP.port);

        // Path for mail templates
        const templatesPath = path.resolve(__dirname, "../views/mail-templates/");

        console.log('Template path:', templatesPath);

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
        if (!otp || !email) {
            throw new Error("Email and OTP are required");
        }
        
        if (!firstname) firstname = 'User';
        if (!lastname) lastname = '';

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

        console.log('Attempting to send email to:', email);
        console.log('Mail from:', SMTP.senderEmail);
        console.log('Template:', 'otp');

        // Sending the email
        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.error("=== EMAIL SEND FAILED ===");
                console.error("Failed to send mail:", error);
                console.error("Error code:", error.code);
                console.error("Error command:", error.command);
                return { error: error.message };
            } else {
                console.log("=== EMAIL SENT SUCCESSFULLY ===");
                console.log("Email sent:", info.response);
                console.log("Message ID:", info.messageId);
                return { data: info };
            }
        });

    } catch (error) {
        console.error("=== OTP MAIL EXCEPTION ===");
        console.error("Error sending OTP mail:", error.message);
        console.error("Stack trace:", error.stack);
        return { error: error.message };
    }

};

module.exports = sendOtpMail;