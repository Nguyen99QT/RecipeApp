package com.project.recipebackend.controller;

import com.project.recipebackend.entity.*;
import com.project.recipebackend.repository.*;
import com.project.recipebackend.service.*;
import java.util.Optional;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CuisineRepository cuisineRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private OtpRepository otpRepository;

    @Autowired
    private SettingRepository settingRepository;

    @Autowired
    private AdsRepository adsRepository;

    @Autowired
    private FavouriteRecipeRepository favouriteRecipeRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private FaqRepository faqRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private JwtTokenService jwtTokenService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 1. Check if user is already registered
    @PostMapping("/check-register-user")
    public ResponseEntity<?> checkRegisterUser(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            
            Optional<User> existingUser = userRepository.findByEmail(email);
            
            if (existingUser.isPresent()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "User already exists with this email"
                ));
            }
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "Email is available for registration"
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 2. User signup
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody Map<String, String> request) {
        try {
            String firstname = request.get("firstname");
            String lastname = request.get("lastname");
            String email = request.get("email");
            String countryCode = request.get("country_code");
            String phone = request.get("phone");
            String password = request.get("password");
            
            // Check if user already exists
            Optional<User> existingUser = userRepository.findByEmail(email);
            if (existingUser.isPresent()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "User already exists with this email"
                ));
            }
            
            // Hash password (using BCrypt instead of SHA256 for better security)
            String hashedPassword = passwordEncoder.encode(password);
            
            // Create new user
            User newUser = new User();
            newUser.setFirstname(firstname);
            newUser.setLastname(lastname);
            newUser.setEmail(email);
            newUser.setCountryCode(countryCode);
            newUser.setPhone(phone);
            newUser.setPassword(hashedPassword);
            
            User savedUser = userRepository.save(newUser);
            
            // Generate 4-digit OTP
            Integer otp = (int) (Math.floor(Math.random() * 9000) + 1000);
            
            // Save OTP
            Otp otpData = new Otp();
            otpData.setUserId(savedUser);
            otpData.setEmail(email);
            otpData.setOtp(otp);
            
            otpRepository.save(otpData);
            
            // Send OTP email
            try {
                emailService.sendOtpEmail(email, otp, firstname, lastname);
            } catch (Exception emailError) {
                // Log error but don't fail the registration
                System.err.println("Failed to send OTP email: " + emailError.getMessage());
            }
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "User registered successfully. OTP sent to email.",
                "userId", savedUser.getId()
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 3. Verify OTP
    @PostMapping("/verify-otp")
    public ResponseEntity<?> verifyOtp(@RequestBody Map<String, Object> request) {
        try {
            String userId = (String) request.get("userId");
            String email = (String) request.get("email");
            Integer otp = Integer.parseInt(request.get("otp").toString());
            
            Optional<Otp> otpData = otpRepository.findByEmailAndOtp(email, otp);
            
            if (otpData.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "Invalid OTP"
                ));
            }
            
            // Update user verification status
            Optional<User> userOptional = userRepository.findById(userId);
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                user.setIsOTPVerified(1);
                userRepository.save(user);
                
                // Delete OTP after successful verification
                otpRepository.delete(otpData.get());
                
                return ResponseEntity.ok(Map.of(
                    "status", true,
                    "message", "OTP verified successfully"
                ));
            }
            
            return ResponseEntity.badRequest().body(Map.of(
                "status", false,
                "message", "User not found"
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 4. User signin
    @PostMapping("/signin")
    public ResponseEntity<?> signIn(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            String password = request.get("password");
            
            Optional<User> userOptional = userRepository.findByEmail(email);
            
            if (userOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "Invalid email or password"
                ));
            }
            
            User user = userOptional.get();
            
            // Verify password
            if (!passwordEncoder.matches(password, user.getPassword())) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "Invalid email or password"
                ));
            }
            
            // Check if account is active
            if (user.getIsActive() == 0) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "Account is deactivated"
                ));
            }
            
            // Generate JWT token
            String token = jwtTokenService.generateToken(user.getId());
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "Login successful",
                "token", token,
                "user", user
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 5. Check if account is verified
    @PostMapping("/is-verify-account")
    public ResponseEntity<?> isVerifyAccount(@RequestBody Map<String, String> request) {
        try {
            String userId = request.get("userId");
            
            Optional<User> userOptional = userRepository.findById(userId);
            
            if (userOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "User not found"
                ));
            }
            
            User user = userOptional.get();
            boolean isVerified = user.getIsOTPVerified() == 1;
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "isVerified", isVerified,
                "message", isVerified ? "Account is verified" : "Account is not verified"
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // More methods will be added in the next part...

    // 6. Resend OTP
    @PostMapping("/resend-otp")
    public ResponseEntity<?> resendOtp(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            
            Optional<User> userOptional = userRepository.findByEmail(email);
            if (userOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", false,
                    "message", "User not found with this email"
                ));
            }
            
            User user = userOptional.get();
            
            // Generate new OTP
            Integer otp = (int) (Math.floor(Math.random() * 9000) + 1000);
            
            // Delete existing OTP
            otpRepository.deleteByEmail(email);
            
            // Save new OTP
            Otp otpData = new Otp();
            otpData.setUserId(user);
            otpData.setEmail(email);
            otpData.setOtp(otp);
            
            otpRepository.save(otpData);
            
            // Send OTP email
            try {
                emailService.sendOtpEmail(email, otp, user.getFirstname(), user.getLastname());
            } catch (Exception emailError) {
                System.err.println("Failed to send OTP email: " + emailError.getMessage());
            }
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "OTP resent successfully"
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 7. Get all categories
    @GetMapping("/get-all-category")
    public ResponseEntity<?> getAllCategory() {
        try {
            List<Category> categories = categoryRepository.findAll();
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "data", categories
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 8. Get all cuisines
    @GetMapping("/get-all-cuisines")
    public ResponseEntity<?> getAllCuisines() {
        try {
            List<Cuisines> cuisines = cuisineRepository.findAll();
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "data", cuisines
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 9. Get all recipes
    @GetMapping("/get-all-recipe")
    public ResponseEntity<?> getAllRecipe() {
        try {
            List<Recipe> recipes = recipeRepository.findAll();
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "data", recipes
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 10. Get ads/admob configuration
    @GetMapping("/get-admob")
    public ResponseEntity<?> getAdmob() {
        try {
            List<Ads> adsList = adsRepository.findAll();
            Ads ads = adsList.isEmpty() ? new Ads() : adsList.get(0);
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "data", ads
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 11. Get policy and terms
    @GetMapping("/get-policy-and-terms")
    public ResponseEntity<?> getPolicyAndTerms() {
        try {
            List<Setting> settingsList = settingRepository.findAll();
            Setting settings = settingsList.isEmpty() ? new Setting() : settingsList.get(0);
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "data", settings
            ));
            
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "status", false,
                "message", "Internal server error"
            ));
        }
    }

    // 12. Upload user avatar
    @PostMapping("/upload-image")
    public ResponseEntity<?> uploadImage(@RequestParam("avatar") MultipartFile file, HttpServletRequest request) {
        try {
            // Extract token from Authorization header
            String authHeader = request.getHeader("Authorization");
            String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
            
            if (token == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "status", false,
                    "message", "Authentication required"
                ));
            }
            
            String userId = jwtTokenService.getUserIdFromToken(token);
            Optional<User> userOptional = userRepository.findById(userId);
            
            if (userOptional.isEmpty()) {
                return ResponseEntity.status(401).body(Map.of(
                    "status", false,
                    "message", "User not found"
                ));
            }
            
            // Upload avatar
            String fileName = fileUploadService.uploadAvatar(file);
            
            // Update user avatar
            User user = userOptional.get();
            user.setAvatar(fileName);
            userRepository.save(user);
            
            return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "Avatar uploaded successfully",
                "filename", fileName
            ));
            
        } catch (Exception e) {
                         return ResponseEntity.badRequest().body(Map.of(
                 "status", false,
                 "message", e.getMessage()
             ));
         }
     }

     // 13. Forgot Password
     @PostMapping("/forgot-password")
     public ResponseEntity<?> forgotPassword(@RequestBody Map<String, String> request) {
         try {
             String email = request.get("email");
             
             Optional<User> userOptional = userRepository.findByEmail(email);
             if (userOptional.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "No account found with this email address"
                 ));
             }
             
             User user = userOptional.get();
             
             // Generate new OTP for password reset
             Integer otp = (int) (Math.floor(Math.random() * 9000) + 1000);
             
             // Delete existing OTP for this email
             otpRepository.deleteByEmail(email);
             
             // Save new OTP
             Otp otpData = new Otp();
             otpData.setUserId(user);
             otpData.setEmail(email);
             otpData.setOtp(otp);
             
             otpRepository.save(otpData);
             
             // Send password reset OTP email
             try {
                 emailService.sendOtpEmail(email, otp, user.getFirstname(), user.getLastname());
             } catch (Exception emailError) {
                 System.err.println("Failed to send password reset OTP: " + emailError.getMessage());
             }
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Password reset OTP sent to your email"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 14. Forgot Password Verification
     @PostMapping("/forgot-password-verification")
     public ResponseEntity<?> forgotPasswordVerification(@RequestBody Map<String, Object> request) {
         try {
             String email = (String) request.get("email");
             Integer otp = Integer.parseInt(request.get("otp").toString());
             
             Optional<Otp> otpData = otpRepository.findByEmailAndOtp(email, otp);
             
             if (otpData.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Invalid OTP"
                 ));
             }
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "OTP verified successfully. You can now reset your password."
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 15. Reset Password
     @PostMapping("/reset-password")
     public ResponseEntity<?> resetPassword(@RequestBody Map<String, Object> request) {
         try {
             String email = (String) request.get("email");
             Integer otp = Integer.parseInt(request.get("otp").toString());
             String newPassword = (String) request.get("newPassword");
             
             // Verify OTP first
             Optional<Otp> otpData = otpRepository.findByEmailAndOtp(email, otp);
             
             if (otpData.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Invalid OTP"
                 ));
             }
             
             // Find user and update password
             Optional<User> userOptional = userRepository.findByEmail(email);
             if (userOptional.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "User not found"
                 ));
             }
             
             User user = userOptional.get();
             user.setPassword(passwordEncoder.encode(newPassword));
             userRepository.save(user);
             
             // Delete the OTP after successful password reset
             otpRepository.delete(otpData.get());
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Password reset successfully"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 16. User Edit Profile
     @PostMapping("/user-edit")
     public ResponseEntity<?> userEdit(@RequestBody Map<String, String> request, HttpServletRequest httpRequest) {
         try {
             // Extract token from Authorization header
             String authHeader = httpRequest.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             Optional<User> userOptional = userRepository.findById(userId);
             
             if (userOptional.isEmpty()) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "User not found"
                 ));
             }
             
             User user = userOptional.get();
             
             // Update user fields
             if (request.containsKey("firstname")) {
                 user.setFirstname(request.get("firstname"));
             }
             if (request.containsKey("lastname")) {
                 user.setLastname(request.get("lastname"));
             }
             if (request.containsKey("phone")) {
                 user.setPhone(request.get("phone"));
             }
             if (request.containsKey("country_code")) {
                 user.setCountryCode(request.get("country_code"));
             }
             
             userRepository.save(user);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Profile updated successfully",
                 "user", user
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 17. Get User Profile
     @GetMapping("/get-user")
     public ResponseEntity<?> getUser(HttpServletRequest request) {
         try {
             // Extract token from Authorization header
             String authHeader = request.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             Optional<User> userOptional = userRepository.findById(userId);
             
             if (userOptional.isEmpty()) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "User not found"
                 ));
             }
             
             User user = userOptional.get();
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", user
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 18. Change Password
     @PostMapping("/change-password")
     public ResponseEntity<?> changePassword(@RequestBody Map<String, String> request, HttpServletRequest httpRequest) {
         try {
             // Extract token from Authorization header
             String authHeader = httpRequest.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             Optional<User> userOptional = userRepository.findById(userId);
             
             if (userOptional.isEmpty()) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "User not found"
                 ));
             }
             
             User user = userOptional.get();
             String currentPassword = request.get("currentPassword");
             String newPassword = request.get("newPassword");
             
             // Verify current password
             if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Current password is incorrect"
                 ));
             }
             
             // Update password
             user.setPassword(passwordEncoder.encode(newPassword));
             userRepository.save(user);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Password changed successfully"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 19. Delete User Account
     @DeleteMapping("/delete-account-user")
     public ResponseEntity<?> deleteAccountUser(HttpServletRequest request) {
         try {
             // Extract token from Authorization header
             String authHeader = request.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             Optional<User> userOptional = userRepository.findById(userId);
             
             if (userOptional.isEmpty()) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "User not found"
                 ));
             }
             
             // Delete user account
             userRepository.deleteById(userId);
             
             // TODO: Also delete related data (favorites, reviews, etc.)
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Account deleted successfully"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 20. Get Recipe by ID
     @GetMapping("/get-recipe-by-id")
     public ResponseEntity<?> getRecipeById(@RequestParam String recipeId) {
         try {
             Optional<Recipe> recipeOptional = recipeRepository.findById(recipeId);
             
             if (recipeOptional.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Recipe not found"
                 ));
             }
             
             Recipe recipe = recipeOptional.get();
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", recipe
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 21. Get Recipes by Category ID
     @GetMapping("/get-recipe-by-category-id")
     public ResponseEntity<?> getRecipeByCategoryId(@RequestParam String categoryId) {
         try {
             List<Recipe> recipes = recipeRepository.findByCategoryId(categoryId);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", recipes
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 22. Search Recipes
     @GetMapping("/search-recipes")
     public ResponseEntity<?> searchRecipes(@RequestParam String query) {
         try {
             // TODO: Implement full-text search using MongoDB text index
             List<Recipe> recipes = recipeRepository.findByNameContainingIgnoreCase(query);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", recipes
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 23. Add Favourite Recipe
     @PostMapping("/add-favourite-recipe")
     public ResponseEntity<?> addFavouriteRecipe(@RequestBody Map<String, String> request, HttpServletRequest httpRequest) {
         try {
             // Extract token from Authorization header
             String authHeader = httpRequest.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             String recipeId = request.get("recipeId");
             
             // Check if already in favorites
             Optional<FavouriteRecipe> existing = favouriteRecipeRepository.findByUserIdAndRecipeId(userId, recipeId);
             if (existing.isPresent()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Recipe is already in favorites"
                 ));
             }
             
             // Add to favorites
             FavouriteRecipe favourite = new FavouriteRecipe();
             favourite.setUserId(userRepository.findById(userId).get());
             favourite.setRecipeId(recipeRepository.findById(recipeId).get());
             
             favouriteRecipeRepository.save(favourite);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Recipe added to favorites"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 24. Get All Favourite Recipes
     @GetMapping("/get-all-favourite-recipes")
     public ResponseEntity<?> getAllFavouriteRecipes(HttpServletRequest request) {
         try {
             // Extract token from Authorization header
             String authHeader = request.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             List<FavouriteRecipe> favourites = favouriteRecipeRepository.findByUserId_Id(userId);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", favourites
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 25. Delete Favourite Recipe
     @DeleteMapping("/delete-favourite-recipe")
     public ResponseEntity<?> deleteFavouriteRecipe(@RequestParam String recipeId, HttpServletRequest request) {
         try {
             // Extract token from Authorization header
             String authHeader = request.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             
             // Find and delete favorite
             Optional<FavouriteRecipe> favourite = favouriteRecipeRepository.findByUserIdAndRecipeId(userId, recipeId);
             if (favourite.isEmpty()) {
                 return ResponseEntity.badRequest().body(Map.of(
                     "status", false,
                     "message", "Recipe not found in favorites"
                 ));
             }
             
             favouriteRecipeRepository.delete(favourite.get());
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Recipe removed from favorites"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 26. Add Review
     @PostMapping("/add-review")
     public ResponseEntity<?> addReview(@RequestBody Map<String, Object> request, HttpServletRequest httpRequest) {
         try {
             // Extract token from Authorization header
             String authHeader = httpRequest.getHeader("Authorization");
             String token = jwtTokenService.extractTokenFromAuthHeader(authHeader);
             
             if (token == null) {
                 return ResponseEntity.status(401).body(Map.of(
                     "status", false,
                     "message", "Authentication required"
                 ));
             }
             
             String userId = jwtTokenService.getUserIdFromToken(token);
             String recipeId = (String) request.get("recipeId");
             Integer rating = Integer.parseInt(request.get("rating").toString());
             String reviewText = (String) request.get("review");
             
             // Create review
             Review review = new Review();
             review.setUserId(userRepository.findById(userId).get());
             review.setRecipeId(recipeRepository.findById(recipeId).get());
             review.setRating(rating);
             review.setComment(reviewText);
             review.setIsEnable(1);
             
             reviewRepository.save(review);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "message", "Review added successfully"
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 27. Get Reviews by Recipe ID
     @GetMapping("/get-review-by-recipe-id")
     public ResponseEntity<?> getReviewByRecipeId(@RequestParam String recipeId) {
         try {
             List<Review> reviews = reviewRepository.findByRecipeIdAndIsEnable(recipeId, true);
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", reviews
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }

     // 28. Get All FAQ
     @GetMapping("/get-all-faq")
     public ResponseEntity<?> getAllFaq() {
         try {
             List<Faq> faqs = faqRepository.findAll();
             
             return ResponseEntity.ok(Map.of(
                 "status", true,
                 "data", faqs
             ));
             
         } catch (Exception e) {
             return ResponseEntity.internalServerError().body(Map.of(
                 "status", false,
                 "message", "Internal server error"
             ));
         }
     }
 } 