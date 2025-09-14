import 'package:flutter/material.dart';
import 'ai_recipe_generator/ai_recipe_generator_main.dart';

/// Integration point for AI Recipe Generator into main RecipeApp
class AIRecipeIntegration {
  /// Add menu items for AI Recipe Generator
  static List<Widget> buildMenuItems(BuildContext context,
      {String? geminiApiKey}) {
    return [
      // Menu item to create AI recipe
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8C00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: Color(0xFFFF8C00),
            size: 20,
          ),
        ),
        title: const Text(
          'Generate AI Recipe',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          'Create recipes from images with AI',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () => AIRecipeGeneratorNavigation.openGenerator(
          context,
          geminiApiKey: geminiApiKey,
        ),
      ),

      // Menu item to view saved AI recipes
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8C00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.bookmark,
            color: Color(0xFFFF8C00),
            size: 20,
          ),
        ),
        title: const Text(
          'Saved AI Recipes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          'View list of created AI recipes',
          style: TextStyle(fontSize: 12),
        ),
        onTap: () => AIRecipeGeneratorNavigation.openSavedRecipes(
          context,
          geminiApiKey: geminiApiKey,
        ),
      ),
    ];
  }

  /// Build floating action button for AI Recipe Generator
  static Widget? buildFloatingActionButton(BuildContext context,
      {String? geminiApiKey}) {
    return FloatingActionButton.extended(
      onPressed: () => AIRecipeGeneratorNavigation.openGenerator(
        context,
        geminiApiKey: geminiApiKey,
      ),
      backgroundColor: const Color(0xFFFF8C00),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.auto_awesome),
      label: const Text('AI Recipe'),
    );
  }

  /// Build card for home page
  static Widget buildHomeCard(BuildContext context, {String? geminiApiKey}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8C00), Color(0xFFFFB74D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: 12),
                Text(
                  'AI Recipe Generator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Take photos of ingredients and let AI create unique recipes for you!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => AIRecipeGeneratorNavigation.openGenerator(
                      context,
                      geminiApiKey: geminiApiKey,
                    ),
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Create Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF8C00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => AIRecipeGeneratorNavigation.openSavedRecipes(
                    context,
                    geminiApiKey: geminiApiKey,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.bookmark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build bottom navigation item
  static BottomNavigationBarItem buildBottomNavItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.auto_awesome),
      label: 'AI Recipe',
    );
  }

  /// Build drawer item
  static Widget buildDrawerItem(BuildContext context, {String? geminiApiKey}) {
    return ExpansionTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF8C00).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.auto_awesome,
          color: Color(0xFFFF8C00),
          size: 20,
        ),
      ),
      title: Row(
        children: [
          const Text(
            'AI Recipe Generator',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera, size: 20),
                title: const Text('Generate Recipe'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  AIRecipeGeneratorNavigation.openGenerator(
                    context,
                    geminiApiKey: geminiApiKey,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark, size: 20),
                title: const Text('Đã Lưu'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  AIRecipeGeneratorNavigation.openSavedRecipes(
                    context,
                    geminiApiKey: geminiApiKey,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build app bar action cho AI Recipe
  static Widget buildAppBarAction(BuildContext context,
      {String? geminiApiKey}) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.auto_awesome),
      onSelected: (value) {
        switch (value) {
          case 'generate':
            AIRecipeGeneratorNavigation.openGenerator(
              context,
              geminiApiKey: geminiApiKey,
            );
            break;
          case 'saved':
            AIRecipeGeneratorNavigation.openSavedRecipes(
              context,
              geminiApiKey: geminiApiKey,
            );
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'generate',
          child: Row(
            children: [
              Icon(Icons.photo_camera, size: 18),
              SizedBox(width: 8),
              Text('Generate AI Recipe'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'saved',
          child: Row(
            children: [
              Icon(Icons.bookmark, size: 18),
              SizedBox(width: 8),
              Text('Saved Recipes'),
            ],
          ),
        ),
      ],
    );
  }
}
