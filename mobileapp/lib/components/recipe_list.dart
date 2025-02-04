import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(Recipe) onTap;
  final void Function(Recipe) onDelete;
  final void Function(Recipe, bool) onFavoriteToggle;

  const RecipeList({
    super.key,
    required this.recipes,
    required this.onTap,
    required this.onDelete,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Dismissible(
          key: Key(recipe.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (_) => onDelete(recipe),
          child: ListTile(
            title: Text(recipe.name),
            subtitle: Text(
              'Target ABV: ${recipe.targetABV.toStringAsFixed(1)}%\n'
              'Sugars: ${recipe.sugars.map((s) => '${s.name} (${(s.percentage * 100).toStringAsFixed(1)}%)').join(', ')}',
            ),
            trailing: IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite ? Colors.red : null,
              ),
              onPressed: () => onFavoriteToggle(recipe, !recipe.isFavorite),
            ),
            onTap: () => onTap(recipe),
          ),
        );
      },
    );
  }
}
