package com.project.recipebackend.controller;

import com.project.recipebackend.entity.AdminLogin;
import com.project.recipebackend.repository.AdminLoginRepository;
import com.project.recipebackend.repository.CategoryRepository;
import com.project.recipebackend.repository.CuisineRepository;
import com.project.recipebackend.repository.RecipeRepository;
import com.project.recipebackend.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AdminLoginRepository adminLoginRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CuisineRepository cuisineRepository;

    @Autowired
    private RecipeRepository recipeRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginRequest, HttpSession session) {
        try {
            String email = loginRequest.get("email");
            String password = loginRequest.get("password");

            Optional<AdminLogin> adminOptional = adminLoginRepository.findByEmail(email);

            if (adminOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "We're sorry, something went wrong when attempting to sign in."
                ));
            }

            AdminLogin admin = adminOptional.get();
            
            // Note: Original uses sha256.x2, but BCrypt is more secure
            // For compatibility, we might need to handle both formats during migration
            if (!passwordEncoder.matches(password, admin.getPassword())) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "We're sorry, something went wrong when attempting to sign in."
                ));
            }

            // Set session
            session.setAttribute("userId", admin.getId());
            session.setAttribute("admin", admin);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Login successful",
                "redirectTo", "/dashboard"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred during login"
            ));
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        try {
            session.invalidate();
            
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Logout successful",
                "redirectTo", "/login"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred during logout"
            ));
        }
    }

    @GetMapping("/dashboard-stats")
    public ResponseEntity<?> getDashboardStats(HttpSession session) {
        try {
            // Check if user is authenticated
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            // Get dashboard statistics
            long totalUsers = userRepository.count();
            long totalCategories = categoryRepository.count();
            long totalCuisines = cuisineRepository.count();
            long totalRecipes = recipeRepository.count();

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalUsers", totalUsers);
            stats.put("totalCategories", totalCategories);
            stats.put("totalCuisines", totalCuisines);
            stats.put("totalRecipes", totalRecipes);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", stats
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching dashboard stats"
            ));
        }
    }

    @GetMapping("/check-session")
    public ResponseEntity<?> checkSession(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            AdminLogin admin = (AdminLogin) session.getAttribute("admin");
            return ResponseEntity.ok(Map.of(
                "authenticated", true,
                "admin", admin
            ));
        } else {
            return ResponseEntity.ok(Map.of(
                "authenticated", false
            ));
        }
    }
} 