const mongoose = require("mongoose");


const recommendedRecipeSchema = new mongoose.Schema({

    deviceId: {
        type: String,
        trim: true
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    categoryId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'categories'
    },
    cuisinesId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'cuisines'
    }
},
    {
        timestamps: true
    }
);


module.exports = new mongoose.model("recommendedRecipe", recommendedRecipeSchema);