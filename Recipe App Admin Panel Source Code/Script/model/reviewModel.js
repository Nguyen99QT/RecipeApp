const mongoose = require("mongoose");

const reviewSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    recipeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'recipes',
        required: false // Allow null for app feedback
    },
    rating: {
        type: Number,
        required: true,
        min: 1,
        max: 5
    },
    comment: {
        type: String,
        required: false // Allow empty comments
    },
    feedbackType: {
        type: String,
        enum: ['recipe', 'app'],
        default: 'recipe'
    },
    isApproved: {
        type: Boolean,
        default: false // Reviews need admin approval before showing to public
    },
    isEnable: {
        type: Boolean,
        default: false
    }

},
    {
        timestamps: true
    }
);


module.exports = mongoose.model("reviews", reviewSchema);
