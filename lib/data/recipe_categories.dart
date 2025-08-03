import 'package:flutter/material.dart';

import '../models/recipe_category.dart';

final List<RecipeCategory> categories = [
  RecipeCategory(
    id: 'breakfast',
    name: 'Breakfast',
    icon: Icons.free_breakfast,
    description: 'Start your day right!',
  ),
  RecipeCategory(
    id: 'desserts',
    name: 'Desserts',
    icon: Icons.cake,
    description: 'Sweet treats and more.',
  ),
  RecipeCategory(
    id: 'lunch',
    name: 'Lunch',
    icon: Icons.lunch_dining,
    description: 'Midday meals to keep you going.',
  ),
  RecipeCategory(
    id: 'dinner',
    name: 'Dinner',
    icon: Icons.dinner_dining,
    description: 'Hearty evening meals.',
  ),
  RecipeCategory(
    id: 'snacks',
    name: 'Snacks',
    icon: Icons.fastfood,
    description: 'Quick bites and munchies.',
  ),
  RecipeCategory(
    id: 'vegan',
    name: 'Vegan',
    icon: Icons.eco,
    description: 'Plant-based and delicious.',
  ),
  RecipeCategory(
    id: 'beverages',
    name: 'Beverages',
    icon: Icons.local_cafe,
    description: 'Refreshing drinks and smoothies.',
  ),
  RecipeCategory(
    id: 'soups',
    name: 'Soups',
    icon: Icons.ramen_dining,
    description: 'Warm and comforting bowls.',
  ),
  RecipeCategory(
    id: 'seafood',
    name: 'Seafood',
    icon: Icons.set_meal,
    description: 'Fresh from the ocean.',
  ),
  RecipeCategory(
    id: 'salads',
    name: 'Salads',
    icon: Icons.grass,
    description: 'Light and healthy options.',
  ),
  RecipeCategory(
    id: 'nigerian',
    name: 'Nigerian',
    icon: Icons.map,
    description: 'Light and healthy options.',
  ),
];
