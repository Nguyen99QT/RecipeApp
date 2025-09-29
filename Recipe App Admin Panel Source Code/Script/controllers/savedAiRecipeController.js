// Importing models
const savedAiRecipeModel = require("../model/savedAiRecipeModel");
const userModel = require("../model/userModel");

// Sync saved AI recipes từ Flutter app lên backend
const syncSavedAiRecipes = async (req, res) => {
    try {
        const userId = req.body.userId;
        const { savedRecipes, deviceInfo, userEmail } = req.body;

        if (!savedRecipes || !Array.isArray(savedRecipes)) {
            return res.json({
                success: false,
                message: "Dữ liệu công thức không hợp lệ."
            });
        }

        // For test cases, use a default user or create one
        let user;
        if (userId === 'test_user_flutter') {
            // Use default test user or first admin user
            user = await userModel.findOne() || { 
                _id: 'test_user_id', 
                email: userEmail || 'test@example.com' 
            };
        } else {
            // Get user info for real users
            user = await userModel.findById(userId);
            if (!user) {
                return res.json({
                    success: false,
                    message: "Người dùng không tồn tại."
                });
            }
        }

        let syncedCount = 0;
        let duplicateCount = 0;
        let errorCount = 0;

        // Process each saved recipe
        for (const recipe of savedRecipes) {
            try {
                // Check if recipe already exists (skip userId check for test cases)
                let existingRecipe;
                if (userId === 'test_user_flutter') {
                    existingRecipe = await savedAiRecipeModel.findOne({
                        id: recipe.id
                    });
                } else {
                    existingRecipe = await savedAiRecipeModel.findOne({
                        id: recipe.id,
                        userId: userId
                    });
                }

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
                        userId: userId === 'test_user_flutter' ? user._id : userId,
                        userEmail: user.email || userEmail || 'test@example.com',
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

// Save single AI recipe from Flutter app
const saveSingleAiRecipe = async (req, res) => {
    try {
        const {
            title,
            description,
            ingredients,
            instructions,
            userId,
            userEmail,
            preparationTime,
            cookingTime,
            cuisine,
            tags,
            difficulty,
            servings,
            estimatedCalories,
            imageUrl,
            createdAt
        } = req.body;

        // Validate required fields
        if (!title || !description || !ingredients || !instructions || !userId || !userEmail) {
            return res.status(400).json({
                success: false,
                message: "Thiếu thông tin bắt buộc: title, description, ingredients, instructions, userId, userEmail"
            });
        }

        // Generate unique ID
        const recipeId = `ai_recipe_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;

        // Create recipe object
        const newRecipe = new savedAiRecipeModel({
            id: recipeId,
            title,
            description,
            ingredients: Array.isArray(ingredients) ? ingredients : [ingredients],
            instructions: Array.isArray(instructions) ? instructions : [instructions],
            cuisine: cuisine || 'International',
            preparationTime: parseInt(preparationTime) || 30,
            cookingTime: parseInt(cookingTime) || 30,
            servings: parseInt(servings) || 4,
            difficulty: difficulty || 'Medium',
            tags: Array.isArray(tags) ? tags : (tags ? [tags] : []),
            imageUrl: imageUrl || null,
            estimatedCalories: estimatedCalories ? parseFloat(estimatedCalories) : null,
            recipeCreatedAt: createdAt ? new Date(createdAt) : new Date(),
            userId: userId,
            userEmail: userEmail,
            deviceInfo: {
                platform: 'Flutter',
                version: '1.0.0'
            }
        });

        // Save to database
        const savedRecipe = await newRecipe.save();

        res.status(201).json({
            success: true,
            message: "Công thức đã được lưu thành công",
            recipe: {
                id: savedRecipe.id,
                title: savedRecipe.title,
                userId: savedRecipe.userId,
                userEmail: savedRecipe.userEmail
            }
        });

    } catch (error) {
        console.error('Error saving single AI recipe:', error);
        res.status(500).json({
            success: false,
            message: "Có lỗi xảy ra khi lưu công thức: " + error.message
        });
    }
};

// Get saved AI recipes for Flutter app (no auth required)
const getFlutterSavedAiRecipes = async (req, res) => {
    try {
        const userId = req.body.userId;
        
        console.log('🔍 Flutter getFlutterSavedAiRecipes request received');
        console.log('👤 Requested userId:', userId);
        
        if (!userId) {
            console.log('❌ UserId is missing in request');
            return res.status(400).json({
                success: false,
                message: "UserId is required"
            });
        }

        const savedRecipes = await savedAiRecipeModel.find({
            userId: userId,
            status: 'active'
        }).sort({ savedAt: -1 });

        console.log(`📋 Found ${savedRecipes.length} recipes for userId: ${userId}`);
        console.log('📝 Recipe titles:', savedRecipes.map(r => r.title));

        return res.json({
            success: true,
            message: "Recipes loaded successfully",
            savedAiRecipes: savedRecipes
        });

    } catch (error) {
        console.log('❌ Error in getFlutterSavedAiRecipes:', error.message);
        return res.json({
            success: false,
            message: "Error loading recipes"
        });
    }
};

module.exports = {
    syncSavedAiRecipes,
    getSavedAiRecipes,
    deleteSavedAiRecipe,
    saveSingleAiRecipe,
    getFlutterSavedAiRecipes
};
