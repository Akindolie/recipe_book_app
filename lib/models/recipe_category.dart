// models/recipe_category.dart
import 'package:flutter/cupertino.dart';

class RecipeCategory {
  final String id;
  final String name;
  final IconData icon; // Optional: to display category image
  final String? description; // Optional

  const RecipeCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.description,
  });
}
