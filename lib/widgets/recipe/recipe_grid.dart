import 'package:flutter/material.dart';
import 'package:recipe_book_app/widgets/recipe/recipe_card.dart';

import '../../models/recipe.dart';

class ResponsiveRecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final int? maxItems;
  final void Function(Recipe recipe)? onRecipeTap;
  final void Function(Recipe recipe)? onToggleFavorite;
  final Set<String> favoriteIds;

  const ResponsiveRecipeGrid({
    super.key,
    required this.recipes,
    this.maxItems,
    this.onRecipeTap,
    this.onToggleFavorite,
    this.favoriteIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    print('maxItem => $maxItems');
    final displayedRecipes = (maxItems != null && maxItems! < recipes.length)
        ? recipes.take(maxItems!).toList()
        : recipes;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate how many columns based on available width
        final crossAxisCount = _calculateColumns(constraints.maxWidth);
        final spacing = _calculateSpacing(constraints.maxWidth);
        //print(displayedRecipes.length);
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(spacing),
          itemCount: displayedRecipes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            //childAspectRatio: 1, //_getChildAspectRatio(constraints.maxWidth),
          ),

          itemBuilder: (context, index) {
            final recipe = displayedRecipes[index];
            final isFavorite = favoriteIds.contains(recipe.id);

            return ResponsiveRecipeCard(
              recipe: recipe,
              isFavorite: isFavorite,
              onTap: () => onRecipeTap?.call(recipe),
              onFavorite: () => onToggleFavorite?.call(recipe),
            );
          },
        );
      },
    );
  }

  int _calculateColumns(double width) {
    print('width => $width');
    // Smart column calculation based on screen width
    if (width > 1200) {
      return 5; // Desktop: 5 photos per row
    } else if (width > 800) {
      return 4; // Large tablet: 4 photos per row
    } else if (width > 600) {
      return 3; // Small tablet: 3 photos per row
    } else if (width > 400) {
      return 2; // Large phone: 2 photos per row
    } else {
      return 1; // Small phone: 1 photo per row
    }
  }

  double _calculateSpacing(double width) {
    // More spacing on larger screens
    if (width > 800) {
      return 16.0; // Desktop/tablet: generous spacing
    } else {
      return 8.0; // Mobile: compact spacing
    }
  }

  // double _getChildAspectRatio(double width) {
  //   int columns = _calculateColumns(width);
  //
  //   switch (columns) {
  //     case 1:
  //       return 4 / 3; // Wider than tall — image can stretch horizontally
  //     case 2:
  //       return 5 / 3;
  //     case 3:
  //       return 6 / 3; // Even wider
  //     case 4:
  //     default:
  //       return 7 / 3; // Wide card, flatter layout
  //   }
  // }
}
