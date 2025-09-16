package com.project.recipebackend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import com.project.recipebackend.entity.FavouriteRecipe;
import java.util.List;
import java.util.Optional;

@Repository
public interface FavouriteRecipeRepository extends MongoRepository<FavouriteRecipe, String> {
    List<FavouriteRecipe> findByUserId_Id(String userId);
    void deleteByRecipeId(String recipeId);
    Optional<FavouriteRecipe> findByUserIdAndRecipeId(String userId, String recipeId);
} 