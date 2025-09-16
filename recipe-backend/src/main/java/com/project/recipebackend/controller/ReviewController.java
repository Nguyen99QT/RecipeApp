package com.project.recipebackend.controller;

import com.project.recipebackend.entity.Review;
import com.project.recipebackend.repository.ReviewRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin/review")
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    // 1. Get all reviews for admin
    @GetMapping("/list")
    public ResponseEntity<?> getAllReviews(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Review> reviews = reviewRepository.findAll();

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", reviews
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching reviews"
            ));
        }
    }

    // 2. Toggle review enable/disable status
    @PutMapping("/toggle-status/{id}")
    public ResponseEntity<?> toggleReviewStatus(@PathVariable String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Review> reviewOptional = reviewRepository.findById(id);
            if (reviewOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Review review = reviewOptional.get();
            
            // Toggle status
            Integer currentStatus = review.getIsEnable();
            Integer newStatus = (currentStatus == 1) ? 0 : 1;
            review.setIsEnable(newStatus);
            
            reviewRepository.save(review);

            String statusMessage = (newStatus == 1) ? "enabled" : "disabled";

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Review " + statusMessage + " successfully",
                "data", review
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while updating review status"
            ));
        }
    }

    // 3. Delete review
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteReview(@PathVariable String id, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            Optional<Review> reviewOptional = reviewRepository.findById(id);
            if (reviewOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            reviewRepository.deleteById(id);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Review deleted successfully"
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while deleting review"
            ));
        }
    }

    // 4. Get reviews by recipe ID
    @GetMapping("/by-recipe/{recipeId}")
    public ResponseEntity<?> getReviewsByRecipeId(@PathVariable String recipeId, HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Review> reviews = reviewRepository.findByRecipeId(recipeId);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", reviews
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching reviews"
            ));
        }
    }

    // 5. Get enabled reviews only
    @GetMapping("/enabled")
    public ResponseEntity<?> getEnabledReviews(HttpSession session) {
        try {
            // Check authentication
            if (session.getAttribute("userId") == null) {
                return ResponseEntity.status(401).body(Map.of(
                    "success", false,
                    "message", "Authentication required"
                ));
            }

            List<Review> reviews = reviewRepository.findByIsEnable(1);

            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", reviews
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                "success", false,
                "message", "An error occurred while fetching enabled reviews"
            ));
        }
    }
} 