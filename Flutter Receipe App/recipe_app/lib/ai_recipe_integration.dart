import 'package:flutter/material.dart';
import 'ai_recipe_generator/ai_recipe_generator_main.dart';

/// Integration point cho AI Recipe Generator vào main RecipeApp
class AIRecipeIntegration {
  /// Thêm menu items cho AI Recipe Generator
  static List<Widget> buildMenuItems(BuildContext context,
      {String? geminiApiKey}) {
    return [
      // Menu item để tạo công thức AI
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: Color(0xFF4CAF50),
            size: 20,
          ),
        ),
        title: const Text(
          'Tạo Công Thức AI',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          'Tạo công thức từ hình ảnh với AI',
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

      // Menu item để xem công thức AI đã lưu
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.bookmark,
            color: Color(0xFF4CAF50),
            size: 20,
          ),
        ),
        title: const Text(
          'Công Thức AI Đã Lưu',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          'Xem danh sách công thức AI đã tạo',
          style: TextStyle(fontSize: 12),
        ),
        onTap: () => AIRecipeGeneratorNavigation.openSavedRecipes(
          context,
          geminiApiKey: geminiApiKey,
        ),
      ),
    ];
  }

  /// Build floating action button cho AI Recipe Generator
  static Widget? buildFloatingActionButton(BuildContext context,
      {String? geminiApiKey}) {
    return FloatingActionButton.extended(
      onPressed: () => AIRecipeGeneratorNavigation.openGenerator(
        context,
        geminiApiKey: geminiApiKey,
      ),
      backgroundColor: const Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.auto_awesome),
      label: const Text('AI Recipe'),
    );
  }

  /// Build card cho home page
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
            colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
              'Chụp ảnh nguyên liệu và để AI tạo công thức nấu ăn độc đáo cho bạn!',
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
                    label: const Text('Tạo Ngay'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4CAF50),
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
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.auto_awesome,
          color: Color(0xFF4CAF50),
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
                title: const Text('Tạo Công Thức'),
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
              Text('Tạo Công Thức AI'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'saved',
          child: Row(
            children: [
              Icon(Icons.bookmark, size: 18),
              SizedBox(width: 8),
              Text('Công Thức Đã Lưu'),
            ],
          ),
        ),
      ],
    );
  }
}
