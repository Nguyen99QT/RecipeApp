const { GoogleGenerativeAI } = require('@google/generative-ai');
const fs = require('fs');
const path = require('path');
const multer = require('multer');

// Initialize Gemini AI
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

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
      const systemPrompt = `You are an expert chef and recipe developer. Analyze the provided food images and create a detailed recipe. 

Requirements:
- Generate recipe in JSON format
- Include title, description, ingredients (with quantities), step-by-step instructions
- Estimate preparation time, cooking time, servings, calories
- Consider any dietary restrictions or preferences mentioned
- Make the recipe practical and easy to follow

Additional preferences:
- Cuisine preference: ${cuisine || 'Any'}
- Difficulty level: ${difficulty || 'Medium'}
- Target servings: ${servings || '4'}
- Maximum prep time: ${maxPrepTime || '30'} minutes
- Dietary restrictions: ${dietaryRestrictions || 'None'}
- User notes: ${prompt || 'Create a delicious recipe'}

Respond with valid JSON in this exact format:
{
  "title": "Recipe Name",
  "description": "Brief description of the dish",
  "cuisine": "Cuisine type",
  "difficulty": "Easy/Medium/Hard",
  "prepTime": 15,
  "cookTime": 25,
  "totalTime": 40,
  "servings": 4,
  "calories": 350,
  "ingredients": [
    "1 cup ingredient 1",
    "2 tbsp ingredient 2"
  ],
  "instructions": [
    "Step 1 instructions",
    "Step 2 instructions"
  ],
  "tags": ["tag1", "tag2"],
  "notes": "Additional cooking tips"
}`;

      // Generate content using Gemini
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
      const result = await model.generateContent([systemPrompt, ...imageData]);
      const response = result.response;
      const text = response.text();

      console.log('🤖 AI Response received:', text.substring(0, 200) + '...');

      // Parse JSON response
      let recipeData;
      try {
        // Clean the response text to extract JSON
        const jsonMatch = text.match(/\{[\s\S]*\}/);
        if (jsonMatch) {
          recipeData = JSON.parse(jsonMatch[0]);
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