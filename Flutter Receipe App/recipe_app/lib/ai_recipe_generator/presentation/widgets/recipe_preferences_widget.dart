import 'package:flutter/material.dart';
import '../../../utils/vietnamese_input_helper.dart';

class RecipePreferencesWidget extends StatelessWidget {
  final TextEditingController promptController;
  final TextEditingController dietaryController;
  final TextEditingController cuisineController;
  final TextEditingController allergiesController;
  final int targetServings;
  final String difficulty;
  final int maxPrepTime;
  final Function(int) onServingsChanged;
  final Function(String) onDifficultyChanged;
  final Function(int) onPrepTimeChanged;

  const RecipePreferencesWidget({
    super.key,
    required this.promptController,
    required this.dietaryController,
    required this.cuisineController,
    required this.allergiesController,
    required this.targetServings,
    required this.difficulty,
    required this.maxPrepTime,
    required this.onServingsChanged,
    required this.onDifficultyChanged,
    required this.onPrepTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Special requirements
        TextField(
          controller: promptController,
          decoration: VietnameseInputHelper.vietnameseInputDecoration(
            labelText: 'Special Requirements',
            hintText:
                'e.g., I want spicy food, high protein... / VD: Tôi muốn món ăn cay, giàu protein...',
            prefixIcon: const Icon(Icons.edit, color: Color(0xFFFF8C00)),
          ),
          inputFormatters: VietnameseInputHelper.vietnameseFormatters,
          maxLines: 2,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 16),

        // Dietary restrictions
        TextField(
          controller: dietaryController,
          decoration: VietnameseInputHelper.vietnameseInputDecoration(
            labelText: 'Dietary Restrictions',
            hintText:
                'e.g., Vegetarian, low sugar, gluten-free... / VD: Chay, ít đường, không gluten...',
            prefixIcon:
                const Icon(Icons.health_and_safety, color: Color(0xFFFF8C00)),
          ),
          inputFormatters: VietnameseInputHelper.vietnameseFormatters,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 16),

        // Preferred cuisine / Ẩm thực ưa thích
        TextField(
          controller: cuisineController,
          decoration: VietnameseInputHelper.vietnameseInputDecoration(
            labelText: 'Preferred Cuisine',
            hintText:
                'e.g., Vietnamese, Korean, Italian... / VD: Việt Nam, Hàn Quốc, Ý...',
            prefixIcon: const Icon(Icons.restaurant, color: Color(0xFFFF8C00)),
          ),
          inputFormatters: VietnameseInputHelper.vietnameseFormatters,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),

        // Allergies
        TextField(
          controller: allergiesController,
          decoration: VietnameseInputHelper.vietnameseInputDecoration(
            labelText: 'Allergies (comma-separated)',
            hintText:
                'e.g., Shrimp, crab, peanuts... / VD: Tôm, cua, đậu phộng...',
            prefixIcon: const Icon(Icons.warning, color: Colors.orange),
          ),
          inputFormatters: VietnameseInputHelper.vietnameseFormatters,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 20),

        // Servings / Khẩu phần
        Row(
          children: [
            const Icon(Icons.people, color: Color(0xFFFF8C00)),
            const SizedBox(width: 8),
            const Text(
              'Servings:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: targetServings > 1
                        ? () => onServingsChanged(targetServings - 1)
                        : null,
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                  ),
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(
                      targetServings.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: targetServings < 20
                        ? () => onServingsChanged(targetServings + 1)
                        : null,
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Difficulty
        Row(
          children: [
            const Icon(Icons.trending_up, color: Color(0xFFFF8C00)),
            const SizedBox(width: 8),
            const Text(
              'Difficulty:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            DropdownButton<String>(
              value: difficulty,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onDifficultyChanged(newValue);
                }
              },
              items: ['Easy', 'Medium', 'Hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: Container(
                height: 1,
                color: const Color(0xFFFF8C00),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Maximum cooking time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timer, color: Color(0xFFFF8C00)),
                const SizedBox(width: 8),
                Text(
                  'Max cooking time: $maxPrepTime min',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Slider(
              value: maxPrepTime.toDouble(),
              min: 15,
              max: 180,
              divisions: 11,
              activeColor: const Color(0xFFFF8C00),
              inactiveColor: Colors.grey[300],
              onChanged: (double value) {
                onPrepTimeChanged(value.round());
              },
              label: '$maxPrepTime min',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '15 min',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '3 hours',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
