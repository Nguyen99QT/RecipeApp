// Script to import data from JSON files
const mongoose = require("mongoose");
const fs = require("fs");
const path = require("path");
require("dotenv").config();

// Import models
const categoryModel = require("../model/categoryModel");
const cuisineModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const settingModel = require("../model/settingModel");
const introModel = require("../model/introModel");
const faqModel = require("../model/faqModel");
const adsModel = require("../model/adsModel");

// Connect to database
const connectDB = async () => {
    try {
        await mongoose.connect(process.env.DB_CONNECTION);
        console.log("✅ Connected to MongoDB");
    } catch (error) {
        console.error("❌ Database connection error:", error);
        process.exit(1);
    }
};

// Read JSON file and process MongoDB format
const readJSONFile = (filename) => {
    try {
        const filePath = path.join(__dirname, "../../Database", filename);
        const data = fs.readFileSync(filePath, "utf8");
        let jsonData = JSON.parse(data);
        
        // Process MongoDB export format
        jsonData = jsonData.map(item => {
            const processedItem = {};
            
            for (const [key, value] of Object.entries(item)) {
                if (key === '_id' && value && value.$oid) {
                    // Skip _id field, let MongoDB generate new ones
                    continue;
                } else if (value && value.$date) {
                    // Convert MongoDB date format
                    processedItem[key] = new Date(value.$date);
                } else {
                    processedItem[key] = value;
                }
            }
            
            return processedItem;
        });
        
        return jsonData;
    } catch (error) {
        console.error(`❌ Error reading ${filename}:`, error.message);
        return null;
    }
};

// Import categories
const importCategories = async () => {
    try {
        const data = readJSONFile("food-recipe.categories.json");
        if (!data) return;

        await categoryModel.deleteMany({});
        await categoryModel.insertMany(data);
        console.log(`✅ Imported ${data.length} categories`);
    } catch (error) {
        console.error("❌ Error importing categories:", error.message);
    }
};

// Import cuisines
const importCuisines = async () => {
    try {
        const data = readJSONFile("food-recipe.cuisines.json");
        if (!data) return;

        await cuisineModel.deleteMany({});
        await cuisineModel.insertMany(data);
        console.log(`✅ Imported ${data.length} cuisines`);
    } catch (error) {
        console.error("❌ Error importing cuisines:", error.message);
    }
};

// Import recipes (with reference handling)
const importRecipes = async () => {
    try {
        const data = readJSONFile("food-recipe.recipes.json");
        if (!data) return;

        // Get existing categories and cuisines to map IDs
        const categories = await categoryModel.find({});
        const cuisines = await cuisineModel.find({});
        
        const categoryMap = {};
        const cuisineMap = {};
        
        categories.forEach(cat => {
            categoryMap[cat.name] = cat._id;
        });
        
        cuisines.forEach(cuisine => {
            cuisineMap[cuisine.name] = cuisine._id;
        });

        // Process recipes data
        const processedRecipes = data.map(recipe => {
            const processedRecipe = { ...recipe };
            
            // Remove MongoDB specific fields
            delete processedRecipe._id;
            delete processedRecipe.__v;
            
            // Handle timestamps
            if (recipe.createdAt && recipe.createdAt.$date) {
                processedRecipe.createdAt = new Date(recipe.createdAt.$date);
            }
            if (recipe.updatedAt && recipe.updatedAt.$date) {
                processedRecipe.updatedAt = new Date(recipe.updatedAt.$date);
            }
            
            // For now, skip categoryId and cuisinesId references
            // You can manually assign these later through the admin panel
            delete processedRecipe.categoryId;
            delete processedRecipe.cuisinesId;
            
            return processedRecipe;
        });

        await recipeModel.deleteMany({});
        await recipeModel.insertMany(processedRecipes);
        console.log(`✅ Imported ${processedRecipes.length} recipes (without category/cuisine references)`);
        console.log("ℹ️  You can assign categories and cuisines to recipes through the admin panel");
    } catch (error) {
        console.error("❌ Error importing recipes:", error.message);
    }
};

// Import settings
const importSettings = async () => {
    try {
        const data = readJSONFile("food-recipe.settings.json");
        if (!data) return;

        await settingModel.deleteMany({});
        await settingModel.insertMany(data);
        console.log(`✅ Imported ${data.length} settings`);
    } catch (error) {
        console.error("❌ Error importing settings:", error.message);
    }
};

// Import intros
const importIntros = async () => {
    try {
        const data = readJSONFile("food-recipe.intros.json");
        if (!data) return;

        await introModel.deleteMany({});
        await introModel.insertMany(data);
        console.log(`✅ Imported ${data.length} intros`);
    } catch (error) {
        console.error("❌ Error importing intros:", error.message);
    }
};

// Import FAQs
const importFAQs = async () => {
    try {
        const data = readJSONFile("food-recipe.faqs.json");
        if (!data) return;

        await faqModel.deleteMany({});
        await faqModel.insertMany(data);
        console.log(`✅ Imported ${data.length} FAQs`);
    } catch (error) {
        console.error("❌ Error importing FAQs:", error.message);
    }
};

// Import ads
const importAds = async () => {
    try {
        const data = readJSONFile("food-recipe.ads.json");
        if (!data) return;

        await adsModel.deleteMany({});
        await adsModel.insertMany(data);
        console.log(`✅ Imported ${data.length} ads`);
    } catch (error) {
        console.error("❌ Error importing ads:", error.message);
    }
};

// Main import function
const importAllData = async () => {
    console.log("🚀 Starting data import...");
    console.log("⚠️  This will delete existing data and replace with new data from JSON files");
    
    await importCategories();
    await importCuisines();
    await importRecipes();
    await importSettings();
    await importIntros();
    await importFAQs();
    await importAds();
    
    console.log("🎉 Data import completed!");
};

// Run the script
const run = async () => {
    await connectDB();
    await importAllData();
    mongoose.connection.close();
    console.log("🔌 Database connection closed");
};

// Check command line arguments
const args = process.argv.slice(2);
if (args.includes("--help") || args.includes("-h")) {
    console.log(`
📖 Usage: node importData.js [options]

Options:
  --categories    Import only categories
  --cuisines      Import only cuisines
  --recipes       Import only recipes
  --settings      Import only settings
  --intros        Import only intros
  --faqs          Import only FAQs
  --ads           Import only ads
  --help, -h      Show this help message

Examples:
  node importData.js                    # Import all data
  node importData.js --categories       # Import only categories
  node importData.js --recipes          # Import only recipes
    `);
    process.exit(0);
}

// Run specific imports based on arguments
const runSpecific = async () => {
    await connectDB();
    
    if (args.includes("--categories")) await importCategories();
    if (args.includes("--cuisines")) await importCuisines();
    if (args.includes("--recipes")) await importRecipes();
    if (args.includes("--settings")) await importSettings();
    if (args.includes("--intros")) await importIntros();
    if (args.includes("--faqs")) await importFAQs();
    if (args.includes("--ads")) await importAds();
    
    // If no specific arguments, import all
    if (args.length === 0) {
        await importAllData();
    }
    
    mongoose.connection.close();
    console.log("🔌 Database connection closed");
};

runSpecific();
