// Script to create default admin user
const mongoose = require("mongoose");
const sha256 = require("sha256");
require("dotenv").config();

// Import admin model
const adminLoginModel = require("../model/adminLoginModel");

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

// Create default admin
const createDefaultAdmin = async () => {
    try {
        // Check if admin already exists
        const existingAdmin = await adminLoginModel.findOne({ email: "admin@recipeapp.com" });
        
        if (existingAdmin) {
            console.log("⚠️  Admin user already exists!");
            console.log("📧 Email: admin@recipeapp.com");
            console.log("🔑 Password: admin123");
            return;
        }

        // Create new admin
        const adminData = {
            name: "Admin",
            email: "admin@recipeapp.com",
            contact: "1234567890",
            password: sha256.x2("admin123"), // Hash password
            avatar: "default-avatar.png",
            is_admin: 1
        };

        const admin = new adminLoginModel(adminData);
        await admin.save();

        console.log("✅ Default admin created successfully!");
        console.log("📧 Email: admin@recipeapp.com");
        console.log("🔑 Password: admin123");
        console.log("⚠️  Please change the password after first login!");

    } catch (error) {
        console.error("❌ Error creating admin:", error);
    } finally {
        mongoose.connection.close();
        console.log("🔌 Database connection closed");
    }
};

// Run the script
const run = async () => {
    await connectDB();
    await createDefaultAdmin();
};

run();
