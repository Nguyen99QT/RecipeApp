// Importing models
const settingModel = require("../model/settingModel");
const adminLoginModel = require("../model/adminLoginModel");
const userNotificationModel = require("../model/userNotificationModel");
const notificationModel = require("../model/notificationModel");

// Importing the service function to send notification
const sendPushNotification = require("../services/sendPushNotification");

// Load view for private policy
const loadPrivatePolicy = async (req, res) => {

    try {

        // fetch private policy
        let setting = await settingModel.findOne();

        return res.render("privatePolicy", { setting });

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for terms and conditions
const loadTermsAndConditions = async (req, res) => {

    try {


        // fetch terms and conditions
        let setting = await settingModel.findOne();

        return res.render("termsConditions", { setting });

    } catch (error) {
        console.log(error.message);
    }
}

// add private policy 
const addPrivatePolicy = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request body
            const privatePolicy = req.body.privatePolicy.replace(/"/g, '&quot;');

            const setting = await settingModel.findOne();

            if (!setting) {
                // Create a new private policy  if none exists
                const newSetting = new settingModel({ privatePolicy: privatePolicy });
                await newSetting.save();

                req.flash('success', 'Private Policy added successfully....');
                return res.redirect('back');

            } else {
                // Update existing private policy 
                await settingModel.findOneAndUpdate({ _id: setting._id }, { $set: { privatePolicy: privatePolicy } });

                req.flash('success', 'Private Policy updated successfully....');
                return res.redirect('back');
            }
        }
        else {

            req.flash('error', 'You have no access to change private policy, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

// add terms and conditions
const addTermsAndConditional = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request body
            const terms_and_conditions = req.body.terms_and_conditions.replace(/"/g, '&quot;');

            const setting = await settingModel.findOne();

            if (!setting) {
                // Create a new terms and conditions if none exists
                const newSetting = new settingModel({ termsAndConditions: terms_and_conditions });
                await newSetting.save();

                req.flash('success', 'Terms and conditions added successfully....');
                return res.redirect('back');

            } else {
                // Update existing terms and conditions
                const updatedData = await settingModel.findOneAndUpdate({ _id: setting._id }, { $set: { termsAndConditions: terms_and_conditions } });

                req.flash('success', 'Terms and conditions updated successfully....');
                return res.redirect('back');
            }
        }
        else {

            req.flash('error', 'You have no access to change terms and conditions, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for send custom notification
const loadSendNotification = async (req, res) => {

    try {

        return res.render("sendNotification");

    } catch (error) {
        console.log(error.message);
    }
}

// send notification
const sendNotification = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 0) {

            req.flash('error', 'You have no access send notification, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

        // Extract data from the request body
        const title = req.body.title;
        const description = req.body.description.replace(/"/g, '&quot;');

        if (!title || !description) {
            req.flash('error', 'Both title and description are required.');
            return res.redirect('back');
        }

        // fetch user token
        const FindTokens = await userNotificationModel.find();
        const registrationTokens = FindTokens.map(item => item.registrationToken);

        // date
        const currentDate = new Date();
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const formattedDate = currentDate.toLocaleDateString('en-US', options);

        // save notification
        const newNotification = await notificationModel({ title: title, date: formattedDate, message: description }).save();

        // send notification
        await sendPushNotification(registrationTokens, title, description);

        req.flash('success', 'Notification sent successfully!');
        return res.redirect('back');

    } catch (error) {
        console.error("Error in sendNotification:", error.message);
        return res.redirect('back');
    }
}

module.exports = {

    loadPrivatePolicy,
    addPrivatePolicy,
    loadTermsAndConditions,
    addTermsAndConditional,
    loadSendNotification,
    sendNotification

}