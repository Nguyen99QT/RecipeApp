const fs = require('fs');
const path = require('path');
const multer = require('multer');
const axios = require('axios');
const { genAI, safetySettings, generationConfig } = require('../config/geminiConfig');
const { processRecipeResponse } = require('./processRecipeResponse');

// Configure multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadDir = path.join(__dirname, '../uploads/ai-recipe-images/');
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'ai-recipe-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ 
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image files are allowed!'), false);
    }
  }
});

class AIRecipeTryItController {
  
  // Display the AI Recipe Try-It page
  static async showTryItPage(req, res) {
    try {
      res.render('aiRecipeTryIt', {
        title: 'AI Recipe Generator - Try It',
        message: req.flash('message'),
        error: req.flash('error'),
        success: req.flash('success')
      });
    } catch (error) {
      console.error('Error loading AI Recipe Try-It page:', error);
      req.flash('error', 'Unable to load AI Recipe Generator page');
      res.redirect('/dashboard');
    }
  }

  // Generate AI recipe from uploaded images
  static async generateRecipe(req, res) {
    try {
      // Check if files were uploaded
      if (!req.files || req.files.length === 0) {
        return res.status(400).json({
          success: false,
          error: 'Please upload at least one image'
        });
      }

      const { prompt, cuisine, difficulty, servings, maxPrepTime, dietaryRestrictions } = req.body;

      // Convert uploaded images to base64
      const imageData = [];
      for (const file of req.files) {
        const imagePath = file.path;
        const imageBuffer = fs.readFileSync(imagePath);
        const base64Data = imageBuffer.toString('base64');
        const mimeType = file.mimetype;
        
        imageData.push({
          inlineData: {
            data: base64Data,
            mimeType: mimeType
          }
        });

        // Clean up uploaded file
        fs.unlinkSync(imagePath);
      }

      // Prepare the AI prompt
      const systemPrompt = `You are a concise recipe creator. Look at the food image and create a simple, easy-to-follow recipe.

Key requirements:
- Keep the recipe short and practical
- Use 5-8 main ingredients maximum
- Limit to 3-5 essential cooking steps
- Focus on basic cooking techniques
- Be specific but brief in instructions
- Generate in JSON format

Preferences:
- Cuisine: ${cuisine || 'Any'}
- Difficulty: ${difficulty || 'Easy'}
- Servings: ${servings || '2-4'}
- Prep time: ${maxPrepTime || '15'} minutes max
- Diet: ${dietaryRestrictions || 'None'}
- Notes: ${prompt || 'Create a simple recipe'}

Respond with valid JSON in this exact format:
{
  "title": "Brief Recipe Name",
  "description": "2-3 sentence description",
  "cuisine": "Type",
  "difficulty": "Easy/Medium/Hard",
  "prepTime": 10,
  "cookTime": 20,
  "totalTime": 30,
  "servings": 4,
  "calories": 300,
  "ingredients": [
    "5-8 ingredients only",
    "with measurements"
  ],
  "instructions": [
    "3-5 clear steps",
    "be concise"
  ],
  "tags": ["2-3 tags"],
  "notes": "Optional quick tips"
}`;

      // Generate content using Gemini
      console.log('🤖 Initializing Gemini model...');
      const model = genAI.getGenerativeModel({
        model: "gemini-2.5-flash",
        generationConfig,
        safetySettings,
      });
      
      try {
        console.log('🤖 Preparing request parts...');
        const parts = [
          { text: systemPrompt },
          ...imageData
        ];
        
        console.log('🤖 Sending request to Gemini...');
        console.log('📋 Number of images:', imageData.length);
        console.log('📋 Prompt length:', systemPrompt.length);
        
        const result = await model.generateContent(parts);
        
        if (!result || !result.response) {
          throw new Error('No response from Gemini API');
        }
        
        const text = result.response.text();
        console.log('✨ Raw response:', text);
        
        // Continue with text processing
        return processRecipeResponse(text, req.files.length, res);
      } catch (error) {
        console.error('🔴 Gemini API Error:', error);
        console.error('🔴 Error details:', JSON.stringify(error, null, 2));
        return res.status(500).json({
          success: false,
          error: 'AI generation failed. Please try again.'
        });
      }

      console.log('🤖 AI Response received:', text.substring(0, 200) + '...');

      // Parse JSON response
      let recipeData;
      try {
        // Clean the response text to extract JSON
        const jsonMatch = text.match(/```json\n([\s\S]*?)\n```/) || text.match(/\{[\s\S]*\}/);
        if (jsonMatch) {
          const jsonContent = jsonMatch[1] || jsonMatch[0];
          recipeData = JSON.parse(jsonContent);
        } else {
          throw new Error('No JSON found in response');
        }
      } catch (parseError) {
        console.error('JSON parsing error:', parseError);
        return res.status(500).json({
          success: false,
          error: 'Failed to parse AI response. Please try again.'
        });
      }

      // Validate required fields
      if (!recipeData.title || !recipeData.ingredients || !recipeData.instructions) {
        return res.status(500).json({
          success: false,
          error: 'Incomplete recipe generated. Please try again.'
        });
      }

      // Add generation metadata
      const aiRecipe = {
        ...recipeData,
        id: 'temp-' + Date.now(),
        generatedAt: new Date().toISOString(),
        imageCount: req.files.length,
        isTemporary: true // Flag to indicate this is not saved
      };

      console.log('✅ AI Recipe generated successfully:', aiRecipe.title);

      // Return the generated recipe
      res.json({
        success: true,
        recipe: aiRecipe,
        message: 'Recipe generated successfully!'
      });

    } catch (error) {
      console.error('Error generating AI recipe:', error);
      
      // Clean up uploaded files on error
      if (req.files) {
        req.files.forEach(file => {
          if (fs.existsSync(file.path)) {
            fs.unlinkSync(file.path);
          }
        });
      }

      res.status(500).json({
        success: false,
        error: 'Failed to generate recipe. Please check your images and try again.'
      });
    }
  }

  // Get upload middleware
  static getUploadMiddleware() {
    return upload.array('recipeImages', 5); // Allow up to 5 images
  }
}

module.exports = AIRecipeTryItController;