// Helper function to process recipe response
async function processRecipeResponse(text, imageCount, res) {
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
    imageCount: imageCount,
    isTemporary: true // Flag to indicate this is not saved
  };

  console.log('✅ AI Recipe generated successfully:', aiRecipe.title);

  // Return the generated recipe
  return res.json({
    success: true,
    recipe: aiRecipe,
    message: 'Recipe generated successfully!'
  });
}

module.exports = {
  processRecipeResponse
};