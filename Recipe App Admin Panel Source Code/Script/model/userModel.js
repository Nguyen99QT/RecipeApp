const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({

    firstname: {
        type: String,
        require: true
    },
    lastname: {
        type: String,
        require: true
    },
    email: {
        type: String,
        require: true,
        unique: true
    },
    country_code: {
        type: String,
        require: true,
        trim: true
    },
    phone: {
        type: String,
        require: true,
        trim: true
    },
    password: {
        type: String,
        require: true,
        trim: true
    },
    avatar: {
        type: String,
        default: ""
    },
    // OTP (One-Time Password) verification status
    isOTPVerified: {
        type: Number,
        default: 0,
    },
    is_active: {
        type: Number,
        default: 1,
    }

},
    {
        timestamps: true
    }
);

module.exports = new mongoose.model("users", userSchema);

