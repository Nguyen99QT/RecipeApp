const { GoogleGenerativeAI } = require('@google/generative-ai');

async function testGeminiKey() {
  try {
    // Initialize with your API key
    const apiKey = process.env.GEMINI_API_KEY || 'AIzaSyA0er_CFpuAvZZx0-iVhiqwKOqAcC_sq6U';
    console.log('🔑 Using API Key:', apiKey.substring(0, 8) + '...');
    const genAI = new GoogleGenerativeAI(apiKey);

    console.log('🔑 Testing Gemini API connection...');

    // Try to get a simple model with text-only capabilities
    const model = genAI.getGenerativeModel({ 
      model: "gemini-pro",
      apiVersion: "v1"  // Try stable API version
    });

    // Test with a simple prompt
    const prompt = "Respond with 'OK' if you can read this message.";
    
    console.log('📝 Sending test prompt...');
    const result = await model.generateContent(prompt);
    const response = result.response;
    const text = response.text();
    
    console.log('✨ Response:', text);
    console.log('✅ API key is working!');
    
    return true;
  } catch (error) {
    console.error('❌ API key test failed:', error.message);
    if (error.status) {
      console.error('Status:', error.status);
      console.error('Status Text:', error.statusText);
    }
    return false;
  }
}

// Run the test
testGeminiKey().then(isWorking => {
  if (!isWorking) {
    console.log('❌ Please check your API key and try again');
    process.exit(1);
  }
  process.exit(0);
});