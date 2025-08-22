const mongoose = require("mongoose");

const favouriteRecipeSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    recipeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'recipes',
        required: true
    }
},
    {
        timestamps: true
    }
);

module.exports = new mongoose.model("favouriteRecipes", favouriteRecipeSchema);