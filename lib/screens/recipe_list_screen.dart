import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/recipe_detail_screen.dart';

import '../data/sample_recipes.dart';
import '../models/recipe.dart';

// How to navigate and send data
class RecipeListScreen extends StatelessWidget {
  // final List<Recipe> recipes = [
  //   Recipe(
  //     id: '1',
  //     title: 'Chocolate Chip Cookies',
  //     imageUrl: 'https://example.com/cookies.jpg',
  //     description: '',
  //     cookTimeMinutes: 25,
  //     servings: 2,
  //     difficulty: '',
  //     nutritionInfo: NutritionInfo(
  //       calories: 2,
  //       carbs: 3,
  //       sodium: 2,
  //       sugar: 5,
  //       fat: 5,
  //       fiber: 3,
  //       protein: 3,
  //     ),
  //     category: '',
  //     createdAt: DateTime(2025, 12, 25),
  //     prepTimeMinutes: 40,
  //     ingredients: [
  //       Ingredient(name: '2 cups flour', amount: 2000, unit: '1'),
  //       Ingredient(name: '1 cup sugar', amount: 100, unit: '2'),
  //       Ingredient(name: '1/2 cup butter', amount: 1200, unit: '3'),
  //       Ingredient(name: '1 cup chocolate chips', amount: 3000, unit: '1'),
  //     ],
  //     instructions: [
  //       'Mix dry ingredients',
  //       'Add wet ingredients',
  //       'Fold in chocolate chips',
  //       'Bake for 12 minutes',
  //     ],
  //   ),
  //   // More recipes...
  // ];
  final List<Recipe> recipes = SampleData.featuredRecipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  recipe.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(recipe.title),
              subtitle: Text('${recipe.cookTimeMinutes} minutes'),
              onTap: () {
                // Send data via constructor parameters
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(
                      recipe: recipe, // Required data
                      isFromFavorites: false, // Context information
                      previousScreenTitle: 'All Recipes', // Where we came from
                      onFavoriteChanged: () {
                        // Callback for updates
                        print('Favorite status changed!');
                        // Refresh the list or update UI
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
