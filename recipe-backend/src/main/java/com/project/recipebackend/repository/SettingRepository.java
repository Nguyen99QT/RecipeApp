package com.project.recipebackend.repository;

import com.project.recipebackend.entity.Setting;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SettingRepository extends MongoRepository<Setting, String> {
    
} 