package com.project.recipebackend.repository;

import com.project.recipebackend.entity.Otp;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OtpRepository extends MongoRepository<Otp, String> {
    
    Optional<Otp> findByEmailAndOtp(String email, Integer otp);
    Optional<Otp> findByUserIdAndEmail(String userId, String email);
    void deleteByEmail(String email);
    
} 