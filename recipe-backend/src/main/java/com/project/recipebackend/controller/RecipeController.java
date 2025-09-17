package com.project.recipebackend.controller;

import com.project.recipebackend.entity.*;
import com.project.recipebackend.repository.*;
import com.project.recipebackend.service.*;
import com.project.recipebackend.enums.DifficultyLevel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin/recipe")
public class RecipeController {

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CuisineRepository cuisineRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private FavouriteRecipeRepository favouriteRecipeRepository;

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private FileService fileService;

    @Autowired
    private PushNotificationService pushNotificationService;

    @Autowired
    private UserNotificationRepository userNotificationRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    // 1. Get form data for adding recipe
    @GetMapping("/add-form-data")
    public ResponseEntity<?> getAddFormData(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Category> categories = categoryRepository.findAll();
            List<Cuisines> cuisines = cuisineRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", Map.of(
                    "categories", categories,
                    "cuisines", cuisines
                )
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching form data"
            ));
        }
    }

    // 2. Add new recipe
    @PostMapping("/add")
    public ResponseEntity<?> addRecipe(
            @RequestParam("recipename") String name,
            @RequestParam("ingredientslist") String[] ingredients,
            @RequestParam("category") String categoryId,
            @RequestParam("cuisines") String cuisinesId,
            @RequestParam("prepTime") String prepTime,
            @RequestParam("cookTime") String cookTime,
            @RequestParam("totalCookTime") String totalCookTime,
            @RequestParam("servings") String servings,
            @RequestParam("difficultyLevel") String difficultyLevel,
            @RequestParam("url") String url,
            @RequestParam("overview") String overview,
            @RequestParam("how_to_cook") String howToCook,
            @RequestParam("image") MultipartFile image,
            @RequestParam(value = "video", required = false) MultipartFile video,
            @RequestParam(value = "gallery", required = false) MultipartFile[] gallery,
            HttpSession session) {
        
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            // Upload main image
            String imageName = fileUploadService.uploadSingleImage(image);

            // Upload video if provided
            String videoName = null;
            if (video != null && !video.isEmpty()) {
                // TODO: Implement video upload
                // videoName = fileUploadService.uploadVideo(video);
            }

            // Upload gallery images
            List<String> galleryImages = new ArrayList<>();
            if (gallery != null && gallery.length > 0) {
                galleryImages = fileUploadService.uploadMultipleImages(gallery);
            }

            // Create recipe - matching the original Node.js structure
            Recipe recipe = new Recipe();
            recipe.setName(name);
            recipe.setIngredients(Arrays.asList(ingredients.split(",")));
            recipe.setCategoryId(categoryRepository.findById(categoryId).get());
            recipe.setCuisinesId(cuisineRepository.findById(cuisinesId).get());
            recipe.setPrepTime(prepTime);
            recipe.setCookTime(cookTime);
            recipe.setTotalCookTime(totalCookTime);
            recipe.setServings(servings);
            // Convert String to DifficultyLevel enum
            recipe.setDifficultyLevel(DifficultyLevel.valueOf(difficultyLevel.toUpperCase()));
            recipe.setUrl(url);
            recipe.setOverview(overview.replace("\"", "&quot;"));
            recipe.setHow_to_cook(howToCook.replace("\"", "&quot;"));
            recipe.setImage(imageName);
            recipe.setVideo(videoName);
            recipe.setGallery(galleryImages);

            Recipe savedRecipe = recipeRepository.save(recipe);

            // Send push notification to users - matching original Node.js logic
            try {
                List<UserNotification> userNotifications = userNotificationRepository.findAll();
                List<String> registrationTokens = userNotifications.stream()
                    .map(UserNotification::getRegistrationToken)
                    .collect(Collectors.toList());

                // Notification details
                String title = "Check Out Our Newest Recipe!";
                String message = "Great news for food lovers! We've just added a fresh new recipe. Check it out and get ready to enjoy a delightful new dish.";
                
                // Format current date
                LocalDateTime currentDate = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy");
                String formattedDate = currentDate.format(formatter);

                // Save notification to database
                Notification notification = new Notification(title, formattedDate, message);
                notificationRepository.save(notification);

                // Send push notification
                if (!registrationTokens.isEmpty()) {
                    pushNotificationService.sendToMultipleDevices(registrationTokens, title, message, Map.of());
                }
                
            } catch (Exception notificationError) {
                // Log error but don't fail the recipe creation
                System.err.println("Failed to send push notification: " + notificationError.getMessage());
            }
            
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Recipe added successfully",
                "data", savedRecipe
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while adding recipe: " + e.getMessage()
            ));
        }
    }

    // 3. Get all recipes for admin
    @GetMapping("/list")
    public ResponseEntity<?> getAllRecipes(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Recipe> recipes = recipeRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", recipes
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching recipes"
            ));
        }
    }

    // 4. Get recipe for editing
    @GetMapping("/edit/{id}")
    public ResponseEntity<?> getRecipeForEdit(@PathVariable String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();
            List<Category> categories = categoryRepository.findAll();
            List<Cuisines> cuisines = cuisineRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", Map.of(
                    "recipe", recipe,
                    "categories", categories,
                    "cuisines", cuisines
                )
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching recipe"
            ));
        }
    }

    // 5. Edit recipe
    @PutMapping("/edit/{id}")
    public ResponseEntity<?> editRecipe(
            @PathVariable String id,
            @RequestParam("recipename") String name,
            @RequestParam("ingredientslist") String[] ingredients,
            @RequestParam("category") String categoryId,
            @RequestParam("cuisines") String cuisinesId,
            @RequestParam("prepTime") String prepTime,
            @RequestParam("cookTime") String cookTime,
            @RequestParam("totalCookTime") String totalCookTime,
            @RequestParam("servings") String servings,
            @RequestParam("difficultyLevel") String difficultyLevel,
            @RequestParam("url") String url,
            @RequestParam("overview") String overview,
            @RequestParam("how_to_cook") String howToCook,
            @RequestParam(value = "image", required = false) MultipartFile image,
            @RequestParam(value = "video", required = false) MultipartFile video,
            HttpSession session) {
        
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();

            // Update basic fields
            recipe.setName(name);
            recipe.setIngredients(Arrays.asList(ingredients.split(",")));
            recipe.setCategoryId(categoryRepository.findById(categoryId).get());
            recipe.setCuisinesId(cuisineRepository.findById(cuisinesId).get());
            recipe.setPrepTime(prepTime);
            recipe.setCookTime(cookTime);
            recipe.setServings(servings);
            recipe.setDifficultyLevel(DifficultyLevel.valueOf(difficulty.toUpperCase()));
            recipe.setUrl(url);
            recipe.setOverview(overview.replace("\"", "&quot;"));
            recipe.setHow_to_cook(howToCook.replace("\"", "&quot;"));

            // Update image if provided
            if (image != null && !image.isEmpty()) {
                // Delete old image
                if (recipe.getImage() != null) {
                    fileService.deleteImage(recipe.getImage());
                }
                // Upload new image
                String imageName = fileUploadService.uploadSingleImage(image);
                recipe.setImage(imageName);
            }

            // Update video if provided
            if (video != null && !video.isEmpty()) {
                // Delete old video
                if (recipe.getVideo() != null) {
                    fileService.deleteVideo(recipe.getVideo());
                }
                // TODO: Upload new video
                // String videoName = fileUploadService.uploadVideo(video);
                // recipe.setVideo(videoName);
            }

            Recipe updatedRecipe = recipeRepository.save(recipe);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Recipe updated successfully",
                "data", updatedRecipe
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while updating recipe: " + e.getMessage()
            ));
        }
    }

    // 6. Delete recipe
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteRecipe(@PathVariable String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();

            // Delete associated files
            if (recipe.getImage() != null) {
                fileService.deleteImage(recipe.getImage());
            }

            if (recipe.getVideo() != null) {
                fileService.deleteVideo(recipe.getVideo());
            }

            if (recipe.getGallery() != null) {
                for (String galleryImage : recipe.getGallery()) {
                    fileService.deleteImage(galleryImage);
                }
            }

            // Delete related data
            reviewRepository.deleteByRecipeId(id);
            favouriteRecipeRepository.deleteByRecipeId(id);

            // Delete recipe
            recipeRepository.deleteById(id);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Recipe deleted successfully"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while deleting recipe"
            ));
        }
    }

    // 7. Get gallery images for a recipe
    @GetMapping("/{id}/gallery")
    public ResponseEntity<?> getRecipeGallery(@PathVariable String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();
            List<String> gallery = recipe.getGallery() != null ? recipe.getGallery() : new ArrayList<>();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", Map.of(
                    "recipeId", id,
                    "recipeName", recipe.getName(),
                    "gallery", gallery
                )
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching gallery"
            ));
        }
    }

    // 8. Add image to gallery
    @PostMapping("/{id}/gallery/add")
    public ResponseEntity<?> addGalleryImage(
            @PathVariable String id,
            @RequestParam("image") MultipartFile image,
            HttpSession session) {
        
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();

            // Upload image
            String imageName = fileUploadService.uploadSingleImage(image);

            // Add to gallery
            List<String> gallery = recipe.getGallery() != null ? new ArrayList<>(recipe.getGallery()) : new ArrayList<>();
            gallery.add(imageName);
            recipe.setGallery(gallery);

            recipeRepository.save(recipe);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Image added to gallery successfully",
                "imageName", imageName
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while adding image: " + e.getMessage()
            ));
        }
    }

    // 9. Delete image from gallery
    @DeleteMapping("/{id}/gallery/delete")
    public ResponseEntity<?> deleteGalleryImage(
            @PathVariable String id,
            @RequestParam("imageName") String imageName,
            HttpSession session) {
        
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Recipe> recipeOptional = recipeRepository.findById(id);
            if (recipeOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Recipe recipe = recipeOptional.get();

            // Remove from gallery
            List<String> gallery = recipe.getGallery() != null ? new ArrayList<>(recipe.getGallery()) : new ArrayList<>();
            gallery.remove(imageName);
            recipe.setGallery(gallery);

            recipeRepository.save(recipe);

            // Delete physical file
            fileService.deleteImage(imageName);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Image deleted from gallery successfully"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while deleting image"
            ));
        }
    }
} 