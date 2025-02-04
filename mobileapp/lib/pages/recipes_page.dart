import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../components/recipe_form.dart';
import '../components/recipe_list.dart';
import '../models/recipe.dart';
import '../models/sugar.dart';
import '../repositories/recipe_repository.dart';

class RecipesPage extends ConsumerStatefulWidget {
  const RecipesPage({super.key});

  @override
  ConsumerState<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends ConsumerState<RecipesPage> {
  void _addRecipe(RecipeFormData data) async {
    final repository = await ref.read(recipeRepositoryProvider.future);
    final recipe = Recipe.create(
      name: data.name,
      targetABV: data.targetABV,
      sugars: data.selectedSugars,
    );

    await repository.saveRecipe(recipe);
    ref.invalidate(recipeRepositoryProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added')),
      );
    }
  }

  void _deleteRecipe(Recipe recipe) async {
    final repository = await ref.read(recipeRepositoryProvider.future);
    await repository.deleteRecipe(recipe.id);
    ref.invalidate(recipeRepositoryProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe deleted')),
      );
    }
  }

  void _toggleFavorite(Recipe recipe, bool isFavorite) async {
    final repository = await ref.read(recipeRepositoryProvider.future);
    final updatedRecipe = recipe.copyWith(isFavorite: isFavorite);
    await repository.saveRecipe(updatedRecipe);
    ref.invalidate(recipeRepositoryProvider);
  }

  void _openRecipe(Recipe recipe) {
    context.push('/calculator', extra: recipe);
  }

  @override
  Widget build(BuildContext context) {
    final repositoryAsync = ref.watch(recipeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: repositoryAsync.when(
        data: (repository) => FutureBuilder<List<Sugar>>(
          future: repository.getSugars(),
          builder: (context, sugarSnapshot) {
            if (sugarSnapshot.hasError) {
              return Center(child: Text('Error: ${sugarSnapshot.error}'));
            }

            if (!sugarSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RecipeForm(
                    availableSugars: sugarSnapshot.data!,
                    onSubmit: _addRecipe,
                  ),
                ),
                const Divider(),
                Expanded(
                  child: FutureBuilder<List<Recipe>>(
                    future: repository.getRecipes(),
                    builder: (context, recipeSnapshot) {
                      if (recipeSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${recipeSnapshot.error}'));
                      }

                      if (!recipeSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return RecipeList(
                        recipes: recipeSnapshot.data!,
                        onDelete: _deleteRecipe,
                        onTap: _openRecipe,
                        onFavoriteToggle: _toggleFavorite,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
