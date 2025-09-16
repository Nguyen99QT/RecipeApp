package com.project.recipebackend.repository;

import com.project.recipebackend.entity.Faq;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FaqRepository extends MongoRepository<Faq, String> {
    
} 