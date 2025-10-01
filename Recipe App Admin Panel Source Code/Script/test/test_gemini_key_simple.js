require('dotenv').config();
const { GoogleGenerativeAI } = require('@google/generative-ai');

async function testGeminiKey() {
  try {
    // Get API key from .env
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      throw new Error('GEMINI_API_KEY is not set in .env file');
    }

    console.log('🔑 Testing with API Key:', apiKey.substring(0, 8) + '...');
    
    // Initialize the API
    const genAI = new GoogleGenerativeAI(apiKey);
    
    // Get available models
    console.log('📚 Testing with gemini-2.5-flash model...');
    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
    const result = await model.generateContent("Give me a one-word response: hello");

    console.log('✨ Response:', await result.response.text());
    console.log('✅ API key is working correctly!');
    return true;
  } catch (error) {
    console.error('❌ Error testing API key:', error.message);
    if (error.status) {
      console.error('Status:', error.status);
      console.error('Status Text:', error.statusText);
    }
    return false;
  }
}

// Run the test
testGeminiKey();