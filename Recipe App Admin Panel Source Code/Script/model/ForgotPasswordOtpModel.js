const mongoose = require("mongoose");

const ForgotPasswordOtpSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user',
        required: true
    },
    email: {
        type: String,
        required: true
    },
    otp: {
        type: Number,
        required: true
    },
    isOTPVerified: {
        type: Number,
        default: 0
    },
    expiresAt: {
        type: Date,
        default: Date.now,
        expires: 600 // Forgot password OTP expires after 10 minutes (600 seconds)
    }
},
    { timestamps: true }
);

// Add TTL index for automatic deletion
ForgotPasswordOtpSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });

module.exports = mongoose.model("ForgotPasswordOpt", ForgotPasswordOtpSchema);
