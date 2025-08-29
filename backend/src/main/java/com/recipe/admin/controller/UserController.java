package com.recipe.admin.controller;

import com.recipe.admin.model.User;
import com.recipe.admin.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8190"})
public class UserController {
    
    @Autowired
    private UserRepository userRepository;
    
    // Get all users with pagination
    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {
        
        try {
            Sort sort = sortDir.equalsIgnoreCase("desc") ? 
                Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
            
            PageRequest pageRequest = PageRequest.of(page, size, sort);
            Page<User> userPage = userRepository.findAll(pageRequest);
            
            Map<String, Object> response = new HashMap<>();
            response.put("status", true);
            response.put("data", userPage.getContent());
            response.put("currentPage", userPage.getNumber());
            response.put("totalItems", userPage.getTotalElements());
            response.put("totalPages", userPage.getTotalPages());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error fetching users: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    // Get user by ID
    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getUserById(@PathVariable String id) {
        try {
            Optional<User> user = userRepository.findById(id);
            Map<String, Object> response = new HashMap<>();
            
            if (user.isPresent()) {
                response.put("status", true);
                response.put("data", user.get());
                return ResponseEntity.ok(response);
            } else {
                response.put("status", false);
                response.put("message", "User not found");
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error fetching user: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    // Search users
    @GetMapping("/search")
    public ResponseEntity<Map<String, Object>> searchUsers(@RequestParam String q) {
        try {
            List<User> users = userRepository.findBySearchTerm(q);
            
            Map<String, Object> response = new HashMap<>();
            response.put("status", true);
            response.put("data", users);
            response.put("total", users.size());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error searching users: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    // Update user verification status
    @PutMapping("/{id}/verify")
    public ResponseEntity<Map<String, Object>> verifyUser(@PathVariable String id) {
        try {
            Optional<User> userOptional = userRepository.findById(id);
            Map<String, Object> response = new HashMap<>();
            
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                user.setIsVerified(true);
                userRepository.save(user);
                
                response.put("status", true);
                response.put("message", "User verified successfully");
                response.put("data", user);
                return ResponseEntity.ok(response);
            } else {
                response.put("status", false);
                response.put("message", "User not found");
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error verifying user: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    // Delete user
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> deleteUser(@PathVariable String id) {
        try {
            Map<String, Object> response = new HashMap<>();
            
            if (userRepository.existsById(id)) {
                userRepository.deleteById(id);
                response.put("status", true);
                response.put("message", "User deleted successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("status", false);
                response.put("message", "User not found");
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error deleting user: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    // Get user statistics
    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getUserStats() {
        try {
            Long totalUsers = userRepository.getTotalUsers();
            Long verifiedUsers = userRepository.countByIsVerified(true);
            Long unverifiedUsers = userRepository.countByIsVerified(false);
            
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalUsers", totalUsers);
            stats.put("verifiedUsers", verifiedUsers);
            stats.put("unverifiedUsers", unverifiedUsers);
            stats.put("verificationRate", totalUsers > 0 ? (verifiedUsers * 100.0 / totalUsers) : 0);
            
            Map<String, Object> response = new HashMap<>();
            response.put("status", true);
            response.put("data", stats);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", false);
            response.put("message", "Error fetching user stats: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
