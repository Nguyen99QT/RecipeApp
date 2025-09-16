package com.project.recipebackend.repository;

import com.project.recipebackend.entity.AdminLogin;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AdminLoginRepository extends MongoRepository<AdminLogin, String> {
    
    Optional<AdminLogin> findByEmail(String email);
    
} 