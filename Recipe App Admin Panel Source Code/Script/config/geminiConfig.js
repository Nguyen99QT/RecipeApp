const { GoogleGenerativeAI } = require('@google/generative-ai');

// Initialize Gemini AI
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || 'AIzaSyA0er_CFpuAvZZx0-iVhiqwKOqAcC_sq6U');

// Safety settings
const safetySettings = [
  {
    category: 'HARM_CATEGORY_HARASSMENT',
    threshold: 'BLOCK_NONE'
  },
  {
    category: 'HARM_CATEGORY_HATE_SPEECH',
    threshold: 'BLOCK_NONE'
  },
  {
    category: 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
    threshold: 'BLOCK_NONE'
  },
  {
    category: 'HARM_CATEGORY_DANGEROUS_CONTENT',
    threshold: 'BLOCK_NONE'
  }
];

// Generation config
const generationConfig = {
  temperature: 0.9,
  topK: 32,
  topP: 0.95,
  maxOutputTokens: 2048,
};

module.exports = {
  genAI,
  safetySettings,
  generationConfig
};