async function combineRecipeReview(recipesOrRecipe, reviews, favouriteRecipes) {

    // Check if recipesOrRecipe is an array
    const recipes = Array.isArray(recipesOrRecipe) ? recipesOrRecipe : [recipesOrRecipe];

    const updatedRecipeData = await Promise.all(recipes.map(async (recipe) => {
        const recipeId = recipe._id;

        // particular recipe review
        const matchingReviews = reviews.filter(review => review.recipeId.equals(recipeId) && review.isEnable === true);

        let totalRating = 0;
        let ratingCounts = { '5': 0, '4': 0, '3': 0, '2': 0, '1': 0 };

        // calculated rating
        matchingReviews.forEach(review => {
            totalRating += review.rating;
            ratingCounts[review.rating]++;
        });

        // calculated average rating
        const averageRating = matchingReviews.length > 0 ? totalRating / matchingReviews.length : 0;

        // Include the feature image in the gallery if it exists
        let gallery = recipe.gallery || [] ||null;
        if (recipe.image && !gallery.includes(recipe.image)) {
            gallery.unshift(recipe.image); // Adds the feature image at the beginning of the gallery array
        }

        let isFavourite = false;
        
        // Checking if the recipe is a favorite
        if (favouriteRecipes.length > 0) {
            isFavourite = favouriteRecipes.some(favouriteRecipe => favouriteRecipe.recipeId.equals(recipeId));
        }

        return {
            ...recipe.toObject(),
            isFavourite: isFavourite,
            rating: ratingCounts,
            totalRating,
            averageRating,
            reviews: matchingReviews
        };

    }));

    return Array.isArray(recipesOrRecipe) ? updatedRecipeData : updatedRecipeData[0];
}

module.exports = combineRecipeReview;
