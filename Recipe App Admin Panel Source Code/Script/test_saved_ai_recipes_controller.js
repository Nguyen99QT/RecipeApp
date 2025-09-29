// Test saved AI recipes controller directly
require('dotenv').config();
require('./config/conn');
const savedAiRecipeAdminController = require('./controllers/savedAiRecipeAdminController');

// Mock request and response objects
const mockReq = {
    query: {},
    session: {
        isAuth: true,
        adminData: { _id: '6572bfe6568745bbc835a157', name: 'Admin A' }
    }
};

const mockRes = {
    render: (template, data) => {
        console.log('✅ Controller executed successfully');
        console.log(`📄 Template: ${template}`);
        console.log(`📊 Data summary:`);
        console.log(`   • Recipes: ${data.savedAiRecipes?.length || 0}`);
        console.log(`   • Total: ${data.totalCount || 0}`);
        console.log(`   • Page: ${data.currentPage}/${data.totalPages}`);
        console.log(`   • Stats: ${JSON.stringify(data.stats, null, 2)}`);
        process.exit(0);
    },
    status: (code) => ({
        json: (data) => {
            console.error(`❌ Error response: ${code}`, data);
            process.exit(1);
        }
    })
};

console.log('🧪 Testing saved AI recipes controller...');

setTimeout(() => {
    savedAiRecipeAdminController.loadSavedAiRecipes(mockReq, mockRes);
}, 2000);
