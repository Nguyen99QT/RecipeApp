package com.recipe.admin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@SpringBootApplication(exclude = {UserDetailsServiceAutoConfiguration.class})
@EnableMongoAuditing
public class RecipeAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(RecipeAdminApplication.class, args);
        System.out.println("Recipe Admin Backend is running!");
        System.out.println("API Base URL: http://localhost:8080/api");
    }
}
