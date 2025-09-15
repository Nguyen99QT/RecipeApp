const mongoose = require("mongoose");

const aiRecipeSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    recipeName: {
        type: String,
        required: true
    },
    recipeContent: {
        type: String,
        required: true
    },
    ingredients: {
        type: [String],
        default: []
    },
    servingSize: {
        type: Number,
        default: 2
    },
    cookingTime: {
        type: Number,
        default: 30
    },
    difficultyLevel: {
        type: String,
        enum: ['Easy', 'Medium', 'Hard'],
        default: 'Easy'
    },
    isAiGenerated: {
        type: Boolean,
        default: true
    },
    tags: {
        type: [String],
        default: []
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    updatedAt: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model("aiRecipes", aiRecipeSchema);
