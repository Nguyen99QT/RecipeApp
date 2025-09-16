package com.project.recipebackend.repository;

import com.project.recipebackend.entity.UserNotification;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserNotificationRepository extends MongoRepository<UserNotification, String> {
    
} 