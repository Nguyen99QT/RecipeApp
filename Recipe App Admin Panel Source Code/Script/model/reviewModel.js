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
        required: true
    },
    rating: {
        type: Number,
        required: true,
        min: 1,
        max: 5
    },
    comment: {
        type: String,
        required: true
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


module.exports = new mongoose.model("reviews", reviewSchema);