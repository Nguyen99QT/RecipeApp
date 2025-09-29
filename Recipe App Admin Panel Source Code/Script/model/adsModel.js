const mongoose = require("mongoose");

const adsSchema = new mongoose.Schema({

    android_is_enable: {
        type: Number,
        default: 0
    },
    android_app_ad_id: {
        type: String,
        trim: true
    },
    android_banner_ad_id: {
        type: String,
        trim: true
    },
    android_banner_ad_id_is_enable: {
        type: Number,
        default: 0
    },
    android_interstitial_ad_id: {
        type: String,
        trim: true
    },
    android_interstitial_ad_id_is_enable: {
        type: Number,
        default: 0
    },
    android_rewarded_ads: {
        type: String,
        trim: true
    },
    android_rewarded_ads_is_enable: {
        type: Number,
        default: 0
    },
    ios_is_enable: {
        type: Number,
        default: 0
    },
    ios_app_ad_id: {
        type: String,
        trim: true
    },
    ios_banner_ad_id: {
        type: String,
        trim: true
    },
    ios_banner_ad_id_is_enable: {
        type: Number,
        default: 0
    },
    ios_interstitial_ad_id: {
        type: String,
        trim: true
    },
    ios_interstitial_ad_id_is_enable: {
        type: Number,
        default: 0
    },
    ios_rewarded_ads: {
        type: String,
        trim: true
    },
    ios_rewarded_ads_is_enable: {
        type: Number,
        default: 0
    },

},
    {
        timestamps: true
    }
);

module.exports = mongoose.model("ads", adsSchema);
