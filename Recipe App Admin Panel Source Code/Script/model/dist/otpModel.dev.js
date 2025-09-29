"use strict";

var mongoose = require("mongoose");

var otpSchema = new mongoose.Schema({
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
  expiresAt: {
    type: Date,
    "default": Date.now,
    expires: 300 // OTP expires after 5 minutes (300 seconds)

  }
}, {
  timestamps: true
}); // Add TTL index for automatic deletion

otpSchema.index({
  expiresAt: 1
}, {
  expireAfterSeconds: 0
});
module.exports = mongoose.model("otp", otpSchema);
