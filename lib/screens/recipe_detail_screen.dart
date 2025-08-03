import 'package:flutter/material.dart';

import '../models/recipe.dart';

// The destination screen that receives data
class RecipeDetailScreen extends StatelessWidget {
  // These are like labeled mailboxes for different types of information
  final Recipe recipe;
  final bool isFromFavorites;
  final String? previousScreenTitle;
  final VoidCallback? onFavoriteChanged;

  const RecipeDetailScreen({
    Key? key,
    required this.recipe, // Required: Can't show details without a recipe
    this.isFromFavorites = false, // Optional: Defaults to false
    this.previousScreenTitle, // Optional: Might be null
    this.onFavoriteChanged, // Optional: Might not need callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        // Show different action based on where we came from
        actions: [
          if (isFromFavorites)
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Notify the previous screen about changes
                if (onFavoriteChanged != null) {
                  onFavoriteChanged!();
                }
              },
            )
          else
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => _addToFavorites(),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(recipe.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Recipe title and cook time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${recipe.cookTimeMinutes} min',
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Ingredients section
            Text(
              'Ingredients',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8),
                    Text(ingredient.name),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Instructions section
            Text(
              'Instructions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...recipe.instructions.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final instruction = entry.value;

              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(child: Text(instruction)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _addToFavorites() {
    // Add to favorites logic
    print('Added ${recipe.title} to favorites');
  }
}
