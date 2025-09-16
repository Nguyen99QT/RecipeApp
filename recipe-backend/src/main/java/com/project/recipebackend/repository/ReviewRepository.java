package com.project.recipebackend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import com.project.recipebackend.entity.Review;
import java.util.List;

@Repository
public interface ReviewRepository extends MongoRepository<Review, String> {
    List<Review> findByIsEnable(boolean isEnable);
    List<Review> findByIsEnable(Integer isEnable);
    void deleteByRecipeId(String recipeId);
    List<Review> findByRecipeIdAndIsEnable(String recipeId, boolean isEnable);
    List<Review> findByRecipeId(String recipeId);
} 