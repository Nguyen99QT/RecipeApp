const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema({

    date: {
        type: String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    }

},
    {
        timestamps: true
    }
);

module.exports = mongoose.model('notification', notificationSchema);