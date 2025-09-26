import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ai_meal.dart';
import '../blocs/ai_recipe_bloc.dart';
import 'ai_recipe_result_page.dart';
import '../../ai_recipe_generator_main.dart';

class SavedAIRecipesPage extends StatefulWidget {
  const SavedAIRecipesPage({super.key});

  @override
  State<SavedAIRecipesPage> createState() => _SavedAIRecipesPageState();
}

class _SavedAIRecipesPageState extends State<SavedAIRecipesPage> {
  @override
  Widget build(BuildContext context) {
    // Check if we already have AIRecipeBloc in context
    try {
      context.read<AIRecipeBloc>();
      // If we have it, use the original page
      return const _SavedAIRecipesPageContent();
    } catch (e) {
      // If we don't have it, wrap with provider
      print('🔄 No AIRecipeBloc found, creating provider wrapper');
      return const SavedAIRecipesEntry();
    }
  }
}

class _SavedAIRecipesPageContent extends StatefulWidget {
  const _SavedAIRecipesPageContent();

  @override
  State<_SavedAIRecipesPageContent> createState() =>
      _SavedAIRecipesPageContentState();
}

class _SavedAIRecipesPageContentState
    extends State<_SavedAIRecipesPageContent> {
  final TextEditingController _searchController = TextEditingController();
  List<AIMeal> _allRecipes = [];
  List<AIMeal> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadRecipes() {
    if (mounted) {
      context.read<AIRecipeBloc>().add(const LoadSavedRecipesEvent());
    }
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRecipes = List.from(_allRecipes);
      } else {
        _filteredRecipes = _allRecipes.where((recipe) {
          return recipe.title.toLowerCase().contains(query) ||
              recipe.description.toLowerCase().contains(query) ||
              recipe.cuisine.toLowerCase().contains(query) ||
              recipe.ingredients.any(
                  (ingredient) => ingredient.toLowerCase().contains(query)) ||
              recipe.tags.any((tag) => tag.toLowerCase().contains(query));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved AI Recipes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRecipes,
          ),
        ],
      ),
      body: BlocListener<AIRecipeBloc, AIRecipeState>(
        listener: (context, state) {
          if (state is SavedRecipesLoaded) {
            setState(() {
              _allRecipes = state.recipes;
              _filterRecipes();
            });
          } else if (state is AIRecipeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AIRecipeBloc, AIRecipeState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: _buildContent(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[50],
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Search recipes...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFFFF8C00)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildContent(AIRecipeState state) {
    if (state is AIRecipeLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C00)),
        ),
      );
    }

    if (_filteredRecipes.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        _loadRecipes();
      },
      color: const Color(0xFFFF8C00),
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _filteredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = _filteredRecipes[index];
          return _buildRecipeCard(recipe);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final hasSearchQuery = _searchController.text.isNotEmpty;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasSearchQuery ? Icons.search_off : Icons.auto_awesome_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            hasSearchQuery
                ? 'No recipes found'
                : 'No recipes have been saved yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasSearchQuery
                ? 'Try searching with a different keyword'
                : 'Create your first AI recipe!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          if (!hasSearchQuery) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.add),
              label: const Text('Create new recipe'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C00),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecipeCard(AIMeal recipe) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _openRecipeDetail(recipe),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE65100),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe.cuisine,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE65100),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.people,
                    '${recipe.servings} people',
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.schedule,
                    '${recipe.preparationTime + recipe.cookingTime} mins',
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.trending_up,
                    recipe.difficulty,
                  ),
                ],
              ),
              if (recipe.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: recipe.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created ${_formatDate(recipe.createdAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFFF8C00),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _openRecipeDetail(AIMeal recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIRecipeResultPage(meal: recipe),
      ),
    );
  }
}
