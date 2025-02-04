import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'sugar.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String name,
    required double targetABV,
    required List<Sugar> sugars,
    @Default(false) bool isFavorite,
    DateTime? lastUsed,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  factory Recipe.create({
    required String name,
    required double targetABV,
    required List<Sugar> sugars,
  }) =>
      Recipe(
        id: const Uuid().v4(),
        name: name,
        targetABV: targetABV,
        sugars: sugars,
        lastUsed: DateTime.now(),
      );
}
