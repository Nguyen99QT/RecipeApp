// IMPROVED APPROACH: Soft Delete với options

const deleteCategory = async (req, res) => {
    try {
        const id = req.query.id;
        const deleteMode = req.query.mode || 'soft'; // 'soft', 'hard', 'reassign'
        
        console.log(`[DELETE CATEGORY] Mode: ${deleteMode}, ID: ${id}`);
        
        const recipes = await recipeModel.find({ categoryId: id });
        const recipeCount = recipes.length;
        
        if (recipeCount > 0) {
            switch(deleteMode) {
                case 'soft':
                    // Mark category as inactive, keep recipes
                    await categoryModel.findByIdAndUpdate(id, { 
                        isActive: false,
                        deletedAt: new Date(),
                        status: 'deleted'
                    });
                    
                    // Option: Move recipes to "Uncategorized"
                    const uncategorizedCat = await categoryModel.findOne({ name: 'Uncategorized' }) ||
                                           await new categoryModel({ name: 'Uncategorized' }).save();
                    
                    await recipeModel.updateMany(
                        { categoryId: id },
                        { categoryId: uncategorizedCat._id }
                    );
                    
                    console.log(`[SOFT DELETE] ${recipeCount} recipes moved to Uncategorized`);
                    break;
                    
                case 'reassign':
                    // Admin must specify target category
                    const targetCategoryId = req.query.targetId;
                    if (!targetCategoryId) {
                        return res.status(400).json({
                            status: false,
                            message: 'Target category required for reassignment'
                        });
                    }
                    
                    await recipeModel.updateMany(
                        { categoryId: id },
                        { categoryId: targetCategoryId }
                    );
                    
                    await categoryModel.deleteOne({ _id: id });
                    console.log(`[REASSIGN] ${recipeCount} recipes moved to new category`);
                    break;
                    
                case 'hard':
                    // Current cascade delete logic
                    await performHardDelete(id, recipes);
                    console.log(`[HARD DELETE] Category and ${recipeCount} recipes permanently deleted`);
                    break;
                    
                default:
                    return res.status(400).json({
                        status: false,
                        message: 'Invalid delete mode'
                    });
            }
        } else {
            // Safe to delete empty category
            await categoryModel.deleteOne({ _id: id });
            console.log(`[SAFE DELETE] Empty category deleted`);
        }
        
        return res.redirect('back');
        
    } catch (error) {
        console.log('[DELETE CATEGORY ERROR]:', error.message);
        return res.status(500).json({
            status: false,
            message: 'Error deleting category: ' + error.message
        });
    }
}

// Separate function for hard delete
const performHardDelete = async (categoryId, recipes) => {
    // Current cascade delete logic here
    await Promise.all(recipes.map(async (item) => {
        deleteImages(item.image);
        item.gallery.map(image => deleteImages(image));
        if (item.video) deleteVideo(item.video);
        await reviewModel.deleteMany({ recipeId: item._id });
        await favouriteRecipeModel.deleteMany({ recipeId: item._id });
    }));
    
    await recipeModel.deleteMany({ categoryId });
    await categoryModel.deleteOne({ _id: categoryId });
}
