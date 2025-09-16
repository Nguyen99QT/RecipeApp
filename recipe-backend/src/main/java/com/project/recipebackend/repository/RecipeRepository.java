package com.project.recipebackend.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import com.project.recipebackend.entity.Recipe;

@Repository
public interface RecipeRepository extends MongoRepository<Recipe, String> {

    List<Recipe> findByCategoryId(String categoryId);

    void deleteByCategoryId(String categoryId);

    List<Recipe> findByNameContainingIgnoreCase(String name);

    List<Recipe> findByCuisinesId(String cuisinesId);

    void deleteByCuisinesId(String cuisinesId);

}