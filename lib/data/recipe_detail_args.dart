import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeDetailArgs {
  final Recipe recipe;
  final bool isFromFavorites;
  final String? previousScreenTitle;
  final VoidCallback? onFavoriteChanged;

  RecipeDetailArgs({
    required this.recipe,
    this.isFromFavorites = false,
    this.previousScreenTitle,
    this.onFavoriteChanged,
  });
}
