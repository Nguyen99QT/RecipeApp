const mongoose = require("mongoose");

const cuisinesSchema = new mongoose.Schema({
    
    name: {
        type: String,
        required: true,
        trim:true
    }
},
    {
        timestamps: true
    }
);

module.exports = new mongoose.model("cuisines", cuisinesSchema);