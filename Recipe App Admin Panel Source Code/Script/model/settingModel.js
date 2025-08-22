const mongoose = require("mongoose");

const settingSchema = new mongoose.Schema({

    privatePolicy: {
        type: String,
        default: ""
    },
    termsAndConditions: {
        type: String,
        default: ""
    }
},
    {
        timestamps: true
    }
);

module.exports = new mongoose.model("setting", settingSchema);