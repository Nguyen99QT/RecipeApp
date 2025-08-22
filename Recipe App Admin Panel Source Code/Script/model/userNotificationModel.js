const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    registrationToken: {
        type: String,
        required: true
    },
    deviceId: {
        type: String,
        required: true
    }
    
},
    {
        timestamps: true
    }
);

module.exports = mongoose.model('userNotification', notificationSchema);

