package com.project.recipebackend.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class DatabaseConnectionTest implements CommandLineRunner {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public void run(String... args) throws Exception {
        if (args.length > 0 && "test-connection".equals(args[0])) {
            testDatabaseConnection();
        }
    }

    public void testDatabaseConnection() {
        try {
            System.out.println("🔄 Testing database connection...");
            
            // Test connection by getting database name
            String databaseName = mongoTemplate.getDb().getName();
            System.out.println("✅ Database connected successfully!");
            System.out.println("📊 Connection details:");
            System.out.println("   - Database: " + databaseName);
            
            // Get collection names
            Set<String> collectionNames = mongoTemplate.getDb().listCollectionNames().into(new java.util.HashSet<>());
            
            System.out.println("📁 Available collections:");
            if (collectionNames.isEmpty()) {
                System.out.println("   - No collections found (new database)");
            } else {
                for (String collectionName : collectionNames) {
                    System.out.println("   - " + collectionName);
                }
            }
            
            System.out.println("🎉 Database test completed successfully!");
            
        } catch (Exception e) {
            System.err.println("❌ Database connection failed:");
            System.err.println("   Error: " + e.getMessage());
            
            if (e.getMessage().contains("Connection refused")) {
                System.out.println("💡 Solution: Make sure MongoDB is running on your system");
                System.out.println("   - Install MongoDB Community Server");
                System.out.println("   - Start MongoDB service");
                System.out.println("   - Or use MongoDB Atlas (cloud)");
            }
        }
    }
} 