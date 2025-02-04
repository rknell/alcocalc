import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../components/recipe_form.dart';
import '../models/recipe.dart';
import '../models/sugar.dart';
import '../repositories/recipe_repository.dart';

class AddRecipePage extends ConsumerWidget {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryAsync = ref.watch(recipeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: repositoryAsync.when(
        data: (repository) => FutureBuilder<List<Sugar>>(
          future: repository.getSugars(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: RecipeForm(
                availableSugars: snapshot.data!,
                onSubmit: (data) async {
                  await repository.saveRecipe(
                    Recipe.create(
                      name: data.name,
                      targetABV: data.targetABV,
                      sugars: data.selectedSugars,
                    ),
                  );
                  ref.invalidate(recipeRepositoryProvider);
                  if (context.mounted) {
                    context.pop();
                  }
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
