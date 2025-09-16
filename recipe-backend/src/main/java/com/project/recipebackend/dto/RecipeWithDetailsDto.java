package com.project.recipebackend.dto;

import com.project.recipebackend.entity.Recipe;
import com.project.recipebackend.entity.Review;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecipeWithDetailsDto {
    private Recipe recipe;
    private boolean favourite;
    private Map<String, Integer> rating; // Rating counts for 1-5 stars
    private int totalRating;
    private double averageRating;
    private List<Review> reviews;
    private List<String> gallery; // Combined gallery with featured image
} 