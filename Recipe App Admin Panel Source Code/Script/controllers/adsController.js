// Importing required modules 

// Importing models
const loginModel = require("../model/adminLoginModel");
const adsModel = require("../model/adsModel");

// Load and render the ad configuration view
const loadAdConfig = async (req, res) => {

    try {

        // Fetch ad details
        const adData = await adsModel.findOne();

        return res.render("ads", { adData });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// Update iOS ad configuration
const updateIOSAdConfig = async (req, res) => {

    try {

        const loginData = await loginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request
            const id = req.body.id;

            // iOS ad configuration fields
            const ios_is_enable = req.body.ios_is_enable ? req.body.ios_is_enable : 0;
            const ios_app_ad_id = req.body.ios_app_ad_id;
            const ios_banner_ad_id = req.body.ios_banner_ad_id;
            const ios_banner_ad_id_is_enable = req.body.ios_banner_ad_id_is_enable ? req.body.ios_banner_ad_id_is_enable : 0;
            const ios_interstitial_ad_id = req.body.ios_interstitial_ad_id;
            const ios_interstitial_ad_id_is_enable = req.body.ios_interstitial_ad_id_is_enable ? req.body.ios_interstitial_ad_id_is_enable : 0;
            const ios_rewarded_ads = req.body.ios_rewarded_ads;
            const ios_rewarded_ads_is_enable = req.body.ios_rewarded_ads_is_enable ? req.body.ios_rewarded_ads_is_enable : 0

            // Attempt to find the existing ad configuration record
            let existingAdConfig = await adsModel.findOne();

            if (existingAdConfig) {
                // Update the existing document with iOS fields
                const result = await adsModel.findByIdAndUpdate(id, {
                    ios_is_enable,
                    ios_app_ad_id,
                    ios_banner_ad_id,
                    ios_banner_ad_id_is_enable,
                    ios_interstitial_ad_id,
                    ios_interstitial_ad_id_is_enable,
                    ios_rewarded_ads,
                    ios_rewarded_ads_is_enable
                }, { new: true });

                req.flash("success", "iOS ad configuration updated successfully.");
            } else {
                // Create a new document with iOS fields if no id is provided
                const result = await adsModel.create({
                    ios_is_enable,
                    ios_app_ad_id,
                    ios_banner_ad_id,
                    ios_banner_ad_id_is_enable,
                    ios_interstitial_ad_id,
                    ios_interstitial_ad_id_is_enable,
                    ios_rewarded_ads,
                    ios_rewarded_ads_is_enable
                });

                req.flash("success", "iOS ad configuration added successfully.");
            }

            return res.redirect('back');

        } else {

            req.flash('error', 'You do not have access to edit ad configurations. Only admins have access to this functionality.');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while updating the iOS ad configuration.');
        return res.redirect('back');
    }
}

// Update Android ad configuration
const updateAndroidAdConfig = async (req, res) => {

    try {

        const loginData = await loginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request
            const id = req.body.id;

            // Android ad configuration fields
            const android_is_enable = req.body.android_is_enable ? req.body.android_is_enable : 0;
            const android_app_ad_id = req.body.android_app_ad_id;
            const android_banner_ad_id = req.body.android_banner_ad_id;
            const android_banner_ad_id_is_enable = req.body.android_banner_ad_id_is_enable ? req.body.android_banner_ad_id_is_enable : 0;
            const android_interstitial_ad_id = req.body.android_interstitial_ad_id;
            const android_interstitial_ad_id_is_enable = req.body.android_interstitial_ad_id_is_enable ? req.body.android_interstitial_ad_id_is_enable : 0;
            const android_rewarded_ads = req.body.android_rewarded_ads;
            const android_rewarded_ads_is_enable = req.body.android_rewarded_ads_is_enable ? req.body.android_rewarded_ads_is_enable : 0

            // Attempt to find the existing ad configuration record
            let existingAdConfig = await adsModel.findOne();

            if (existingAdConfig) {
                // Update the existing document with Android fields
                const result = await adsModel.findByIdAndUpdate(id, {
                    android_is_enable,
                    android_app_ad_id,
                    android_banner_ad_id,
                    android_banner_ad_id_is_enable,
                    android_interstitial_ad_id,
                    android_interstitial_ad_id_is_enable,
                    android_rewarded_ads,
                    android_rewarded_ads_is_enable
                }, { new: true });

                req.flash("success", "Android ad configuration updated successfully.");
            } else {
                // Create a new document with Android fields if no id is provided
                const result = await adsModel.create({
                    android_is_enable,
                    android_app_ad_id,
                    android_banner_ad_id,
                    android_banner_ad_id_is_enable,
                    android_interstitial_ad_id,
                    android_interstitial_ad_id_is_enable,
                    android_rewarded_ads,
                    android_rewarded_ads_is_enable
                });

                req.flash("success", "Android ad configuration added successfully.");
            }

            return res.redirect('back');

        } else {
            req.flash('error', 'You do not have access to edit ad configurations. Only admins have access to this functionality.');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while updating the Android ad configuration.');
        return res.redirect('back');
    }
}

module.exports = {

    loadAdConfig,
    updateAndroidAdConfig,
    updateIOSAdConfig
}
