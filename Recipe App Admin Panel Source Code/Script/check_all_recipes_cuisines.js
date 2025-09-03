const mongoose = require('mongoose');
const recipeModel = require('./model/recipeModel');
const cuisinesModel = require('./model/cuisinesModel');
const categoryModel = require('./model/categoryModel');

const connectDB = async () => {
    try {
        await mongoose.connect('mongodb://localhost:27017/food-recipe');
        console.log('✅ MongoDB connected successfully');
    } catch (error) {
        console.error('❌ MongoDB connection error:', error.message);
        process.exit(1);
    }
};

const checkAllRecipesCuisines = async () => {
    await connectDB();
    
    try {
        // Lấy tất cả recipes
        const recipes = await recipeModel.find({})
            .populate('cuisinesId', 'name')
            .populate('categoryId', 'name')
            .select('name cuisinesId categoryId')
            .limit(20); // Giới hạn 20 để test
        
        console.log('🍽️ Kiểm tra Cuisine Data cho các món ăn:');
        console.log('='.repeat(80));
        
        let hasData = 0;
        let noData = 0;
        
        recipes.forEach((recipe, index) => {
            const status = recipe.cuisinesId ? '✅ CÓ' : '❌ KHÔNG';
            const cuisineName = recipe.cuisinesId ? recipe.cuisinesId.name : 'N/A';
            const categoryName = recipe.categoryId ? recipe.categoryId.name : 'N/A';
            
            console.log(`${index + 1}. ${recipe.name}`);
            console.log(`   Recipe ID: ${recipe._id}`);
            console.log(`   Category: ${categoryName}`);
            console.log(`   Cuisine: ${status} ${cuisineName}`);
            console.log('');
            
            if (recipe.cuisinesId) {
                hasData++;
            } else {
                noData++;
            }
        });
        
        console.log('📊 Thống kê:');
        console.log(`✅ Có cuisine data: ${hasData} món`);
        console.log(`❌ Không có cuisine data: ${noData} món`);
        console.log(`📋 Tổng cộng: ${recipes.length} món (trong ${recipes.length} món được kiểm tra)`);
        
        // Lấy danh sách cuisines có sẵn
        console.log('\n🌍 Danh sách Cuisines có sẵn:');
        const cuisines = await cuisinesModel.find({}).select('name');
        cuisines.forEach((cuisine, index) => {
            console.log(`${index + 1}. ${cuisine.name} (ID: ${cuisine._id})`);
        });
        
    } catch (error) {
        console.error('❌ Error checking recipes:', error.message);
    } finally {
        mongoose.disconnect();
        console.log('\n🔌 Database connection closed');
    }
};

checkAllRecipesCuisines();
