package com.project.recipebackend.repository;

import com.project.recipebackend.entity.Cuisines;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CuisineRepository extends MongoRepository<Cuisines, String> {
    
} 