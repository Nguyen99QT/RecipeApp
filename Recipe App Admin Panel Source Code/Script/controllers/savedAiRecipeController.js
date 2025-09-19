// Importing models
const savedAiRecipeModel = require("../model/savedAiRecipeModel");
const userModel = require("../model/userModel");

// Sync saved AI recipes từ Flutter app lên backend
const syncSavedAiRecipes = async (req, res) => {
    try {
        const userId = req.body.userId;
        const { savedRecipes, deviceInfo } = req.body;

        if (!savedRecipes || !Array.isArray(savedRecipes)) {
            return res.json({
                success: false,
                message: "Dữ liệu công thức không hợp lệ."
            });
        }

        // Get user info
        const user = await userModel.findById(userId);
        if (!user) {
            return res.json({
                success: false,
                message: "Người dùng không tồn tại."
            });
        }

        let syncedCount = 0;
        let duplicateCount = 0;
        let errorCount = 0;

        // Process each saved recipe
        for (const recipe of savedRecipes) {
            try {
                // Check if recipe already exists
                const existingRecipe = await savedAiRecipeModel.findOne({
                    id: recipe.id,
                    userId: userId
                });

                if (existingRecipe) {
                    // Update existing recipe if it's newer
                    if (new Date(recipe.createdAt) > existingRecipe.recipeCreatedAt) {
                        await savedAiRecipeModel.updateOne(
                            { _id: existingRecipe._id },
                            {
                                title: recipe.title,
                                description: recipe.description,
                                ingredients: recipe.ingredients,
                                instructions: recipe.instructions,
                                cuisine: recipe.cuisine,
                                preparationTime: recipe.preparationTime,
                                cookingTime: recipe.cookingTime,
                                servings: recipe.servings,
                                difficulty: recipe.difficulty,
                                tags: recipe.tags,
                                imageUrl: recipe.imageUrl,
                                estimatedCalories: recipe.estimatedCalories,
                                recipeCreatedAt: new Date(recipe.createdAt),
                                deviceInfo: deviceInfo,
                                status: 'active'
                            }
                        );
                        syncedCount++;
                    } else {
                        duplicateCount++;
                    }
                } else {
                    // Create new saved recipe
                    const newSavedRecipe = new savedAiRecipeModel({
                        id: recipe.id,
                        title: recipe.title,
                        description: recipe.description,
                        ingredients: recipe.ingredients,
                        instructions: recipe.instructions,
                        cuisine: recipe.cuisine,
                        preparationTime: recipe.preparationTime,
                        cookingTime: recipe.cookingTime,
                        servings: recipe.servings,
                        difficulty: recipe.difficulty,
                        tags: recipe.tags,
                        imageUrl: recipe.imageUrl,
                        estimatedCalories: recipe.estimatedCalories,
                        recipeCreatedAt: new Date(recipe.createdAt),
                        userId: userId,
                        userEmail: user.email,
                        deviceInfo: deviceInfo,
                        status: 'active'
                    });

                    await newSavedRecipe.save();
                    syncedCount++;
                }
            } catch (recipeError) {
                console.error("Error processing recipe:", recipeError);
                errorCount++;
            }
        }

        return res.json({
            success: true,
            message: "Đồng bộ công thức thành công.",
            data: {
                totalRecipes: savedRecipes.length,
                syncedCount,
                duplicateCount,
                errorCount
            }
        });

    } catch (error) {
        console.log(error.message);
        return res.json({
            success: false,
            message: "Có lỗi xảy ra trong quá trình đồng bộ."
        });
    }
};

// Lấy danh sách saved AI recipes của user
const getSavedAiRecipes = async (req, res) => {
    try {
        const userId = req.body.userId;
        const page = parseInt(req.body.page) || 1;
        const limit = parseInt(req.body.limit) || 20;
        const skip = (page - 1) * limit;

        const savedRecipes = await savedAiRecipeModel.find({
            userId: userId,
            status: 'active'
        })
        .sort({ savedAt: -1 })
        .limit(limit)
        .skip(skip);

        const totalCount = await savedAiRecipeModel.countDocuments({
            userId: userId,
            status: 'active'
        });

        return res.json({
            success: true,
            message: "Lấy danh sách công thức thành công.",
            data: {
                recipes: savedRecipes,
                pagination: {
                    currentPage: page,
                    totalPages: Math.ceil(totalCount / limit),
                    totalCount,
                    hasNext: page < Math.ceil(totalCount / limit),
                    hasPrev: page > 1
                }
            }
        });

    } catch (error) {
        console.log(error.message);
        return res.json({
            success: false,
            message: "Có lỗi xảy ra khi lấy danh sách công thức."
        });
    }
};

// Xóa saved AI recipe
const deleteSavedAiRecipe = async (req, res) => {
    try {
        const userId = req.body.userId;
        const { recipeId } = req.body;

        if (!recipeId) {
            return res.json({
                success: false,
                message: "ID công thức không được để trống."
            });
        }

        // Soft delete the recipe
        const result = await savedAiRecipeModel.updateOne(
            { 
                $or: [
                    { _id: recipeId, userId: userId },
                    { id: recipeId, userId: userId }
                ]
            },
            { status: 'deleted' }
        );

        if (result.modifiedCount > 0) {
            return res.json({
                success: true,
                message: "Xóa công thức thành công."
            });
        } else {
            return res.json({
                success: false,
                message: "Không tìm thấy công thức hoặc bạn không có quyền xóa."
            });
        }

    } catch (error) {
        console.log(error.message);
        return res.json({
            success: false,
            message: "Có lỗi xảy ra khi xóa công thức."
        });
    }
};

module.exports = {
    syncSavedAiRecipes,
    getSavedAiRecipes,
    deleteSavedAiRecipe
};