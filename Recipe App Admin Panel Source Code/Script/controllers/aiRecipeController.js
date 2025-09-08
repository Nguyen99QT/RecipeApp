const aiRecipeModel = require("../model/aiRecipeModel");
const userModel = require("../model/userModel");

// Save AI Generated Recipe
const saveAiRecipe = async (req, res) => {
    try {
        const { recipeName, recipeContent, ingredients, servingSize, cookingTime, difficultyLevel } = req.body;
        const userId = req.userId;

        const newAiRecipe = new aiRecipeModel({
            userId,
            recipeName,
            recipeContent,
            ingredients,
            servingSize,
            cookingTime,
            difficultyLevel,
            isAiGenerated: true,
            createdAt: new Date()
        });

        await newAiRecipe.save();

        return res.status(200).json({
            status: true,
            message: "AI Recipe saved successfully",
            data: newAiRecipe
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get AI Generated Recipes by User
const getUserAiRecipes = async (req, res) => {
    try {
        const userId = req.userId;

        const aiRecipes = await aiRecipeModel.find({ userId })
            .sort({ createdAt: -1 });

        return res.status(200).json({
            status: true,
            data: aiRecipes
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get All AI Generated Recipes (Admin)
const getAllAiRecipes = async (req, res) => {
    try {
        const aiRecipes = await aiRecipeModel.find()
            .populate('userId', 'firstname lastname email')
            .sort({ createdAt: -1 });

        return res.status(200).json({
            status: true,
            data: aiRecipes
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Delete AI Recipe
const deleteAiRecipe = async (req, res) => {
    try {
        const { recipeId } = req.body;
        const userId = req.userId;

        await aiRecipeModel.deleteOne({ _id: recipeId, userId });

        return res.status(200).json({
            status: true,
            message: "AI Recipe deleted successfully"
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Update AI Recipe
const updateAiRecipe = async (req, res) => {
    try {
        const { recipeId, recipeName, recipeContent, ingredients, servingSize, cookingTime, difficultyLevel } = req.body;
        const userId = req.userId;

        const updatedRecipe = await aiRecipeModel.findOneAndUpdate(
            { _id: recipeId, userId },
            {
                recipeName,
                recipeContent,
                ingredients,
                servingSize,
                cookingTime,
                difficultyLevel,
                updatedAt: new Date()
            },
            { new: true }
        );

        if (!updatedRecipe) {
            return res.status(404).json({
                status: false,
                message: "AI Recipe not found"
            });
        }

        return res.status(200).json({
            status: true,
            message: "AI Recipe updated successfully",
            data: updatedRecipe
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

module.exports = {
    saveAiRecipe,
    getUserAiRecipes,
    getAllAiRecipes,
    deleteAiRecipe,
    updateAiRecipe
};
