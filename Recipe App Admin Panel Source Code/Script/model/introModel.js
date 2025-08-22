const mongoose = require("mongoose");

const introSchema = new mongoose.Schema({

    image: {
        type: String,
        required: true,
        trim: true
    },
    title: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    }
},
    {
        timestamps: true
    }
);


module.exports = mongoose.model("intro", introSchema);