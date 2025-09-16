package com.project.recipebackend.controller;

import com.project.recipebackend.entity.Category;
import com.project.recipebackend.entity.Recipe;
import com.project.recipebackend.repository.CategoryRepository;
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
@RequestMapping("/api/admin/category")
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private FavouriteRecipeRepository favouriteRecipeRepository;

    @Autowired
    private FileService fileService;

    @PostMapping("/add")
    public ResponseEntity<?> addCategory(@RequestBody Map<String, String> request, HttpSession session) {
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
                    "message", "Category name is required"
                ));
            }

            Category category = new Category();
            category.setName(name.trim());
            
            categoryRepository.save(category);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Category added successfully",
                "data", category
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while adding category"
            ));
        }
    }

    @GetMapping("/list")
    public ResponseEntity<?> getAllCategories(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Category> categories = categoryRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", categories
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching categories"
            ));
        }
    }

    @PutMapping("/edit")
    public ResponseEntity<?> editCategory(@RequestBody Map<String, String> request, HttpSession session) {
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
                    "message", "Category ID and name are required"
                ));
            }

            Optional<Category> categoryOptional = categoryRepository.findById(id);
            
            if (categoryOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Category category = categoryOptional.get();
            category.setName(name.trim());
            
            categoryRepository.save(category);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Category updated successfully",
                "data", category
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while updating category"
            ));
        }
    }

    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteCategory(@RequestParam String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            // Find all recipes in this category
            List<Recipe> recipes = recipeRepository.findByCategoryId(id);

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

            // Delete all recipes in this category
            recipeRepository.deleteByCategoryId(id);

            // Delete the category
            categoryRepository.deleteById(id);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Category and associated data deleted successfully"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while deleting category"
            ));
        }
    }
} 