const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema({

    name: {
        type: String,
        require: true,
        trim:true
    }
},
    {
        timestamps: true
    }
);

module.exports = new mongoose.model("categories",categorySchema);