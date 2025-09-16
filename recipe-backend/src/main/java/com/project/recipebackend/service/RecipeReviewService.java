package com.project.recipebackend.service;

import com.project.recipebackend.dto.RecipeWithDetailsDto;
import com.project.recipebackend.entity.Recipe;
import com.project.recipebackend.entity.Review;
import com.project.recipebackend.entity.FavouriteRecipe;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class RecipeReviewService {

    /**
     * Combine recipe(s) with reviews and favorite status
     * Equivalent to combineRecipeReview function in Node.js
     * 
     * @param recipesOrRecipe Single recipe or list of recipes
     * @param reviews List of all reviews
     * @param favouriteRecipes List of favorite recipes for the user
     * @return List of RecipeWithDetailsDto or single RecipeWithDetailsDto
     */
    public Object combineRecipeReview(Object recipesOrRecipe, List<Review> reviews, List<FavouriteRecipe> favouriteRecipes) {
        
        // Check if recipesOrRecipe is a list or single recipe
        List<Recipe> recipes;
        boolean isSingleRecipe = false;
        
        if (recipesOrRecipe instanceof List) {
            recipes = (List<Recipe>) recipesOrRecipe;
        } else if (recipesOrRecipe instanceof Recipe) {
            recipes = Arrays.asList((Recipe) recipesOrRecipe);
            isSingleRecipe = true;
        } else {
            throw new IllegalArgumentException("Input must be a Recipe or List of Recipe");
        }

        log.info("Processing {} recipe(s) with {} reviews and {} favourite recipes", 
                recipes.size(), reviews.size(), favouriteRecipes.size());

        List<RecipeWithDetailsDto> updatedRecipeData = recipes.stream().map(recipe -> {
            String recipeId = recipe.getId();

            // Find matching reviews for this recipe that are enabled
            List<Review> matchingReviews = reviews.stream()
                    .filter(review -> review.getRecipeId().getId().equals(recipeId) && review.getIsEnable() == 1)
                    .collect(Collectors.toList());

            // Calculate rating statistics
            int totalRating = 0;
            Map<String, Integer> ratingCounts = new HashMap<>();
            ratingCounts.put("5", 0);
            ratingCounts.put("4", 0);
            ratingCounts.put("3", 0);
            ratingCounts.put("2", 0);
            ratingCounts.put("1", 0);

            // Calculate total rating and rating counts
            for (Review review : matchingReviews) {
                totalRating += review.getRating();
                String ratingKey = String.valueOf(review.getRating());
                ratingCounts.put(ratingKey, ratingCounts.get(ratingKey) + 1);
            }

            // Calculate average rating
            double averageRating = matchingReviews.size() > 0 ? 
                    (double) totalRating / matchingReviews.size() : 0.0;

            // Include the feature image in the gallery if it exists
            List<String> gallery = new ArrayList<>(recipe.getGallery() != null ? recipe.getGallery() : new ArrayList<>());
            if (recipe.getImage() != null && !gallery.contains(recipe.getImage())) {
                gallery.add(0, recipe.getImage()); // Add the feature image at the beginning
            }

            // Check if the recipe is a favorite
            boolean isFavourite = false;
            if (favouriteRecipes != null && !favouriteRecipes.isEmpty()) {
                isFavourite = favouriteRecipes.stream()
                        .anyMatch(favouriteRecipe -> favouriteRecipe.getRecipeId().getId().equals(recipeId));
            }

            // Create and return the DTO
            RecipeWithDetailsDto dto = new RecipeWithDetailsDto();
            dto.setRecipe(recipe);
            dto.setFavourite(isFavourite);
            dto.setRating(ratingCounts);
            dto.setTotalRating(totalRating);
            dto.setAverageRating(averageRating);
            dto.setReviews(matchingReviews);
            dto.setGallery(gallery);

            log.debug("Recipe {} - Reviews: {}, Average Rating: {:.2f}, Is Favourite: {}", 
                    recipeId, matchingReviews.size(), averageRating, isFavourite);

            return dto;

        }).collect(Collectors.toList());

        // Return single recipe or list based on input
        return isSingleRecipe ? updatedRecipeData.get(0) : updatedRecipeData;
    }

    /**
     * Overloaded method for single recipe
     */
    public RecipeWithDetailsDto combineRecipeReview(Recipe recipe, List<Review> reviews, List<FavouriteRecipe> favouriteRecipes) {
        return (RecipeWithDetailsDto) combineRecipeReview((Object) recipe, reviews, favouriteRecipes);
    }

    /**
     * Overloaded method for list of recipes
     */
    public List<RecipeWithDetailsDto> combineRecipeReview(List<Recipe> recipes, List<Review> reviews, List<FavouriteRecipe> favouriteRecipes) {
        return (List<RecipeWithDetailsDto>) combineRecipeReview((Object) recipes, reviews, favouriteRecipes);
    }

    /**
     * Calculate rating statistics for a recipe
     */
    public Map<String, Object> calculateRatingStats(List<Review> reviews) {
        Map<String, Object> stats = new HashMap<>();
        
        int totalRating = 0;
        Map<String, Integer> ratingCounts = new HashMap<>();
        ratingCounts.put("5", 0);
        ratingCounts.put("4", 0);
        ratingCounts.put("3", 0);
        ratingCounts.put("2", 0);
        ratingCounts.put("1", 0);

        for (Review review : reviews) {
            if (review.getIsEnable() == 1) {
                totalRating += review.getRating();
                String ratingKey = String.valueOf(review.getRating());
                ratingCounts.put(ratingKey, ratingCounts.get(ratingKey) + 1);
            }
        }

        double averageRating = reviews.size() > 0 ? (double) totalRating / reviews.size() : 0.0;

        stats.put("totalRating", totalRating);
        stats.put("averageRating", averageRating);
        stats.put("ratingCounts", ratingCounts);
        stats.put("totalReviews", reviews.size());

        return stats;
    }
} 