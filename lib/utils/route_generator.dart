import 'package:flutter/material.dart';

import '../data/recipe_detail_args.dart';
import '../models/user_preference.dart';
import '../screens/favorites_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipe_list_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/shopping_list_screen.dart';
import '../widgets/common/responsive_navigation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // The mail sorting facility - decides where each "letter" should go
    switch (settings.name) {
      case '/':
        return _buildRoute(ResponsiveNavigation(), settings);

      case '/recipes':
        return _buildRoute(RecipeListScreen(), settings);

      case '/recipe-detail':
        final args = settings.arguments;
        if (args is RecipeDetailArgs) {
          return _buildRoute(
            RecipeDetailScreen(
              recipe: args.recipe,
              isFromFavorites: args.isFromFavorites,
              previousScreenTitle: args.previousScreenTitle,
              onFavoriteChanged: args.onFavoriteChanged,
            ),
            settings,
          );
        }
        return _buildErrorRoute('Invalid or missing recipe detail arguments');

      case '/favorites':
        return _buildRoute(FavoritesScreen(), settings);

      case '/recipe-list':
        return _buildRoute(RecipeListScreen(), settings);

      case '/profile':
        return _buildRoute(ProfileScreen(), settings);

      case '/settings':
        final args = settings.arguments;
        if (args is UserPreferences) {
          return _buildRoute(
            SettingsScreen(currentPreferences: args),
            settings,
          );
        }
        return _buildErrorRoute('Missing or invalid user preferences');

      case '/shopping-list':
        if (settings.arguments is Map<String, dynamic>) {
          return _buildRoute(ShoppingListScreen(), settings);
        }
        return _buildErrorRoute('Shopping list data is required');

      default:
        return _buildErrorRoute('Page not found: ${settings.name}');
    }
  }

  static Route<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }

  static Route<dynamic> _buildErrorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                ),
                child: Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
