import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../components/recipe_list.dart';
import '../repositories/recipe_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryAsync = ref.watch(recipeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AlcoCalc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.science),
            onPressed: () => context.push('/sugars'),
            tooltip: 'Manage Sugars',
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () => context.push('/calculator'),
            tooltip: 'Calculator',
          ),
        ],
      ),
      body: repositoryAsync.when(
        data: (repository) => FutureBuilder(
          future: repository.getRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final recipes = snapshot.data!;
            if (recipes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No recipes yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/recipes/add'),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Recipe'),
                    ),
                  ],
                ),
              );
            }

            return RecipeList(
              recipes: recipes,
              onTap: (recipe) {
                context.push('/calculator', extra: recipe);
              },
              onDelete: (recipe) async {
                await repository.deleteRecipe(recipe.id);
                ref.invalidate(recipeRepositoryProvider);
              },
              onFavoriteToggle: (recipe, isFavorite) async {
                final updatedRecipe = recipe.copyWith(isFavorite: isFavorite);
                await repository.saveRecipe(updatedRecipe);
                ref.invalidate(recipeRepositoryProvider);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/recipes/add'),
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}
