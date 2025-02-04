import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pages/add_recipe_page.dart';
import 'pages/calculator_page.dart';
import 'pages/home_page.dart';
import 'pages/recipes_page.dart';
import 'pages/sugars_page.dart';

void main() {
  runApp(const ProviderScope(child: AlcoCalcApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorPage(),
    ),
    GoRoute(
      path: '/recipes',
      builder: (context, state) => const RecipesPage(),
    ),
    GoRoute(
      path: '/recipes/add',
      builder: (context, state) => const AddRecipePage(),
    ),
    GoRoute(
      path: '/sugars',
      builder: (context, state) => const SugarsPage(),
    ),
  ],
);

class AlcoCalcApp extends StatelessWidget {
  const AlcoCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AlcoCalc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
