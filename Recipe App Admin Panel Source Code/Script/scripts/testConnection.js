// Script to test database connection
require("dotenv").config();
const mongoose = require("mongoose");

console.log("🔄 Testing database connection...");
console.log("📍 Database URL:", process.env.DB_CONNECTION);

// Test connection
mongoose.connect(process.env.DB_CONNECTION)
    .then(() => {
        console.log("✅ Database connected successfully!");
        console.log("📊 Connection details:");
        console.log("   - Host:", mongoose.connection.host);
        console.log("   - Port:", mongoose.connection.port);
        console.log("   - Database:", mongoose.connection.name);
        console.log("   - Ready State:", mongoose.connection.readyState); // 1 = connected
        
        // Test if we can list collections
        return mongoose.connection.db.listCollections().toArray();
    })
    .then((collections) => {
        console.log("📁 Available collections:");
        if (collections.length === 0) {
            console.log("   - No collections found (new database)");
        } else {
            collections.forEach(collection => {
                console.log(`   - ${collection.name}`);
            });
        }
        
        console.log("🎉 Database test completed successfully!");
    })
    .catch((error) => {
        console.error("❌ Database connection failed:");
        console.error("   Error:", error.message);
        
        if (error.message.includes("ECONNREFUSED")) {
            console.log("💡 Solution: Make sure MongoDB is running on your system");
            console.log("   - Install MongoDB Community Server");
            console.log("   - Start MongoDB service");
            console.log("   - Or use MongoDB Atlas (cloud)");
        }
    })
    .finally(() => {
        mongoose.connection.close();
        console.log("🔌 Connection closed");
        process.exit(0);
    });
