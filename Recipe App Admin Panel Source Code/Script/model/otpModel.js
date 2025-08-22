const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({

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
    }

},
    { timestamps: true }
);
module.exports = mongoose.model("otp", otpSchema);