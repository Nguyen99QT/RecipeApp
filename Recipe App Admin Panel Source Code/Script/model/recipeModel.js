const mongoose = require("mongoose");

const recipeSchema = new mongoose.Schema({

    image: {
        type: String,
        required: true,
        trim: true
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    categoryId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'categories'
    },
    cuisinesId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'cuisines'
    },
    ingredients: [{
        type: String,
        trim: true,
    }],
    prepTime: {
        type: String,
        required: true,
        trim: true
    },
    cookTime: {
        type: String,
        required: true,
        trim: true
    },
    totalCookTime: {
        type: String,
        required: true,
        trim: true
    },
    servings: {
        type: String,
        required: true,
        trim: true
    },
    difficultyLevel: {
        type: String,
        enum: ["Easy", "Medium", "Hard"],
        default: "Easy",
        trim: true
    },
    gallery: [{
        type: String,
        trim: true,
    }],
    video: {
        type: String,
        trim: true,
    },
    url: {
        type: String,
        trim: true,
    },
    overview: {
        type: String,
        required: true,
        trim: true
    },
    how_to_cook: {
        type: String,
        required: true,
        trim: true
    },
    status: {
        type: Number,
        default: 1,
        enum: [0, 1] // 0 = inactive, 1 = active
    }

},
    {
        timestamps: true
    }
);


module.exports = mongoose.model("recipes", recipeSchema);