const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Schema for saved AI recipes
const savedAiRecipeSchema = new Schema({
    id: {
        type: String,
        required: true,
        unique: true
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    ingredients: [{
        type: String,
        required: true
    }],
    instructions: [{
        type: String,
        required: true
    }],
    cuisine: {
        type: String,
        required: true
    },
    preparationTime: {
        type: Number,
        required: true
    },
    cookingTime: {
        type: Number,
        required: true
    },
    servings: {
        type: Number,
        required: true
    },
    difficulty: {
        type: String,
        required: true
    },
    tags: [{
        type: String
    }],
    imageUrl: {
        type: String,
        default: null
    },
    estimatedCalories: {
        type: Number,
        default: null
    },
    recipeCreatedAt: {
        type: Date,
        required: true
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    userEmail: {
        type: String,
        required: true
    },
    savedAt: {
        type: Date,
        default: Date.now
    },
    deviceInfo: {
        platform: String,
        version: String
    },
    status: {
        type: String,
        enum: ['active', 'deleted'],
        default: 'active'
    }
}, {
    timestamps: true
});

// Index for better query performance
savedAiRecipeSchema.index({ userId: 1, savedAt: -1 });
savedAiRecipeSchema.index({ userEmail: 1 });
savedAiRecipeSchema.index({ cuisine: 1 });
savedAiRecipeSchema.index({ tags: 1 });

module.exports = mongoose.model('SavedAiRecipe', savedAiRecipeSchema, 'savedairecipes');
