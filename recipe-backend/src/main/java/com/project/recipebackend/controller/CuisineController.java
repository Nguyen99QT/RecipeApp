package com.project.recipebackend.controller;

import com.project.recipebackend.entity.Cuisines;
import com.project.recipebackend.entity.Recipe;
import com.project.recipebackend.repository.CuisineRepository;
import com.project.recipebackend.repository.RecipeRepository;
import com.project.recipebackend.repository.ReviewRepository;
import com.project.recipebackend.repository.FavouriteRecipeRepository;
import com.project.recipebackend.service.FileService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin/cuisine")
public class CuisineController {

    @Autowired
    private CuisineRepository cuisineRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private FavouriteRecipeRepository favouriteRecipeRepository;

    @Autowired
    private FileService fileService;

    @PostMapping("/add")
    public ResponseEntity<?> addCuisine(@RequestBody Map<String, String> request, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            String name = request.get("name");
            
            if (name == null || name.trim().isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Cuisine name is required"
                ));
            }

            Cuisines cuisine = new Cuisines();
            cuisine.setName(name.trim());
            
            cuisineRepository.save(cuisine);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Cuisine added successfully",
                "data", cuisine
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while adding cuisine"
            ));
        }
    }

    @GetMapping("/list")
    public ResponseEntity<?> getAllCuisines(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Cuisines> cuisines = cuisineRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", cuisines
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching cuisines"
            ));
        }
    }

    @PutMapping("/edit")
    public ResponseEntity<?> editCuisine(@RequestBody Map<String, String> request, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            String id = request.get("id");
            String name = request.get("name");

            if (id == null || name == null || name.trim().isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Cuisine ID and name are required"
                ));
            }

            Optional<Cuisines> cuisineOptional = cuisineRepository.findById(id);
            
            if (cuisineOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Cuisines cuisine = cuisineOptional.get();
            cuisine.setName(name.trim());
            
            cuisineRepository.save(cuisine);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Cuisine updated successfully",
                "data", cuisine
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while updating cuisine"
            ));
        }
    }

    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteCuisine(@RequestParam String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            // Find all recipes in this cuisine
            List<Recipe> recipes = recipeRepository.findByCuisinesId(id);

            // Delete associated files and data for each recipe
            for (Recipe recipe : recipes) {
                // Delete main image
                if (recipe.getImage() != null) {
                    fileService.deleteImage(recipe.getImage());
                }

                // Delete gallery images
                if (recipe.getGallery() != null) {
                    for (String galleryImage : recipe.getGallery()) {
                        fileService.deleteImage(galleryImage);
                    }
                }

                // Delete video if exists
                if (recipe.getVideo() != null) {
                    fileService.deleteVideo(recipe.getVideo());
                }

                // Delete reviews for this recipe
                reviewRepository.deleteByRecipeId(recipe.getId());

                // Delete favourite recipes
                favouriteRecipeRepository.deleteByRecipeId(recipe.getId());
            }

            // Delete all recipes in this cuisine
            recipeRepository.deleteByCuisinesId(id);

            // Delete the cuisine
            cuisineRepository.deleteById(id);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Cuisine and associated data deleted successfully"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while deleting cuisine"
            ));
        }
    }
} 