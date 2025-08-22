const mongoose = require("mongoose");

const faqSchema = new mongoose.Schema({

    question: {
        type: String,
        required: true,
        trim: true
    },
    answer: {
        type: String,
        required: true,
        trim: true
    },
    status: {
        type: String,
        enum: ["Publish", "UnPublish"],
        default: "Publish",
        trim: true
    }
},
    {
        timestamps: true
    }
);

module.exports = mongoose.model("faq", faqSchema);