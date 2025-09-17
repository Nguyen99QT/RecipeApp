package com.recipe.admin.repository;

import com.recipe.admin.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface UserRepository extends MongoRepository<User, String> {
    
    Optional<User> findByEmail(String email);
    
    Optional<User> findByEmailAndPassword(String email, String password);
    
    Boolean existsByEmail(String email);
    
    List<User> findByIsVerified(Boolean isVerified);
    
    @Query("{'$or': [{'firstname': {$regex: ?0, $options: 'i'}}, {'lastname': {$regex: ?0, $options: 'i'}}, {'email': {$regex: ?0, $options: 'i'}}]}")
    List<User> findBySearchTerm(String searchTerm);
    
    Long countByIsVerified(Boolean isVerified);
    
    @Query(value = "{}", count = true)
    Long getTotalUsers();
}
