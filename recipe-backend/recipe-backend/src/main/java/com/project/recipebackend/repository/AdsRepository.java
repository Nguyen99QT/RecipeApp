package com.project.recipebackend.repository;

import com.project.recipebackend.entity.Ads;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdsRepository extends MongoRepository<Ads, String> {
    
} 