import 'package:flutter/material.dart';

import '../data/recipe_categories.dart' as SampleCategories;
import '../data/sample_recipes.dart';
import '../models/recipe.dart';
import '../utils/responsive_breakpoints.dart';
import '../widgets/recipe/recipe_grid.dart';

// screens/home_screen.dart
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategoryId = SampleCategories.categories.first.id;
  Set<String> favoriteRecipeIds = {};

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (favoriteRecipeIds.contains(recipe.id)) {
        favoriteRecipeIds.remove(recipe.id);
      } else {
        favoriteRecipeIds.add(recipe.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> filteredRecipes = SampleData.featuredRecipes
        .where((recipe) => recipe.category == selectedCategoryId)
        .toList();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            SizedBox(height: 32),
            _buildFeaturedRecipes(context),
            SizedBox(height: 32),
            _buildQuickCategories(context),
            SizedBox(height: 32),
            ResponsiveRecipeGrid(
              recipes: filteredRecipes,
              maxItems: filteredRecipes.length,
              onToggleFavorite: _toggleFavorite,
              favoriteIds: favoriteRecipeIds,
            ),
            // _buildRecentlyViewed(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Recipe Book'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => _showSearch(context),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () => _navigateToShoppingList(context),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 250 : 330,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Recipe Book',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Discover amazing recipes for every occasion',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _exploreRecipes(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[600],
              ),
              child: Text('Explore Recipes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Recipes',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context),
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 16),
        ResponsiveRecipeGrid(
          recipes: SampleData.featuredRecipes,
          maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 5,
          onToggleFavorite: _toggleFavorite,
          favoriteIds: favoriteRecipeIds,
        ),
      ],
    );
  }

  Widget _buildRecentlyViewed(BuildContext context) {
    return Placeholder(); //TODO: IMPLEMENT
  }

  Widget _buildQuickCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Categories',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: SampleCategories.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = SampleCategories.categories[index];
              final isSelected = selectedCategoryId == category.id;

              return ChoiceChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedCategoryId = category.id;
                  });
                },
                avatar: Icon(category.icon, size: 16),
                selectedColor: Colors.orange.shade200,
                labelStyle: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper methods
  void _showSearch(BuildContext context) {
    // Implement search functionality
  }

  void _navigateToShoppingList(BuildContext context) {
    // Navigate to shopping list
  }

  void _exploreRecipes(BuildContext context) {
    // Navigate to recipe list
    Navigator.pushNamed(context, '/recipe-list');
  }

  void _viewAllRecipes(BuildContext context) {
    // Navigate to all recipes
    Navigator.pushNamed(context, '/recipe-list');
  }
}
