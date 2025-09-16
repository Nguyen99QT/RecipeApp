package com.project.recipebackend.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.recipebackend.entity.Category;
import com.project.recipebackend.entity.Cuisines;
import com.project.recipebackend.repository.CategoryRepository;
import com.project.recipebackend.repository.CuisineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Component
public class DataImportUtil implements CommandLineRunner {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CuisineRepository cuisineRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void run(String... args) throws Exception {
        if (args.length > 0 && "import-data".equals(args[0])) {
            importData();
        }
    }

    public void importData() {
        try {
            System.out.println("🔄 Starting data import...");

            // Import categories
            importCategories();
            
            // Import cuisines
            importCuisines();
            
            System.out.println("🎉 Data import completed successfully!");

        } catch (Exception e) {
            System.err.println("❌ Error during data import: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void importCategories() {
        try {
            System.out.println("📁 Importing categories...");
            
            // Check if categories already exist
            if (categoryRepository.count() > 0) {
                System.out.println("⚠️  Categories already exist, skipping import");
                return;
            }

            // Read from resources (you'll need to add JSON files to src/main/resources/data/)
            ClassPathResource resource = new ClassPathResource("data/categories.json");
            if (!resource.exists()) {
                System.out.println("⚠️  Categories data file not found, creating sample data");
                createSampleCategories();
                return;
            }

            InputStream inputStream = resource.getInputStream();
            JsonNode jsonNode = objectMapper.readTree(inputStream);
            
            List<Category> categories = new ArrayList<>();
            
            for (JsonNode node : jsonNode) {
                Category category = new Category();
                category.setName(node.get("name").asText());
                categories.add(category);
            }
            
            categoryRepository.saveAll(categories);
            System.out.println("✅ Imported " + categories.size() + " categories");

        } catch (Exception e) {
            System.err.println("❌ Error importing categories: " + e.getMessage());
            createSampleCategories();
        }
    }

    private void importCuisines() {
        try {
            System.out.println("🍽️  Importing cuisines...");
            
            // Check if cuisines already exist
            if (cuisineRepository.count() > 0) {
                System.out.println("⚠️  Cuisines already exist, skipping import");
                return;
            }

            ClassPathResource resource = new ClassPathResource("data/cuisines.json");
            if (!resource.exists()) {
                System.out.println("⚠️  Cuisines data file not found, creating sample data");
                createSampleCuisines();
                return;
            }

            InputStream inputStream = resource.getInputStream();
            JsonNode jsonNode = objectMapper.readTree(inputStream);
            
            List<Cuisines> cuisines = new ArrayList<>();
            
            for (JsonNode node : jsonNode) {
                Cuisines cuisine = new Cuisines();
                cuisine.setName(node.get("name").asText());
                cuisines.add(cuisine);
            }
            
            cuisineRepository.saveAll(cuisines);
            System.out.println("✅ Imported " + cuisines.size() + " cuisines");

        } catch (Exception e) {
            System.err.println("❌ Error importing cuisines: " + e.getMessage());
            createSampleCuisines();
        }
    }

    private void createSampleCategories() {
        System.out.println("🔧 Creating sample categories...");
        
        List<Category> sampleCategories = new ArrayList<>();
        
        String[] categoryNames = {"Appetizers", "Main Course", "Desserts", "Beverages", "Salads", "Soups", "Snacks"};
        for (String name : categoryNames) {
            Category category = new Category();
            category.setName(name);
            sampleCategories.add(category);
        }
        
        categoryRepository.saveAll(sampleCategories);
        System.out.println("✅ Created " + sampleCategories.size() + " sample categories");
    }

    private void createSampleCuisines() {
        System.out.println("🔧 Creating sample cuisines...");
        
        List<Cuisines> sampleCuisines = new ArrayList<>();
        
        String[] cuisineNames = {"Italian", "Chinese", "Indian", "Mexican", "Thai", "Japanese", "French", "American"};
        for (String name : cuisineNames) {
            Cuisines cuisine = new Cuisines();
            cuisine.setName(name);
            sampleCuisines.add(cuisine);
        }
        
        cuisineRepository.saveAll(sampleCuisines);
        System.out.println("✅ Created " + sampleCuisines.size() + " sample cuisines");
    }
} 