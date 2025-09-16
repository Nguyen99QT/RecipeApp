package com.project.recipebackend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import com.project.recipebackend.entity.Mail;

@Repository
public interface MailRepository extends MongoRepository<Mail, String> {
    // Find the first mail configuration (usually there's only one)
    Mail findFirstBy();
} 