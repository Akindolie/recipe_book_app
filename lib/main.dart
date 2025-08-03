import 'package:flutter/material.dart';
import 'package:recipe_book_app/utils/route_generator.dart';

void main() {
  runApp(MyApp());
}

// main.dart - Your app's address book
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book App',
      // Use the professional mail sorting facility
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
