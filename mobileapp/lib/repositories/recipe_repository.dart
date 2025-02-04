import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';
import '../models/sugar.dart';

part 'recipe_repository.g.dart';

@riverpod
class RecipeRepository extends _$RecipeRepository {
  static const _recipesKey = 'recipes';
  static const _sugarsKey = 'sugars';
  SharedPreferences? _prefs;

  @override
  Future<RecipeRepository> build() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<List<Recipe>> getRecipes() async {
    final json = _prefs?.getString(_recipesKey);
    if (json == null) return [];

    final List<dynamic> list = jsonDecode(json);
    return list.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<void> saveRecipe(Recipe recipe) async {
    final recipes = await getRecipes();
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    if (index >= 0) {
      recipes[index] = recipe;
    } else {
      recipes.add(recipe);
    }

    final json = jsonEncode(recipes.map((r) => r.toJson()).toList());
    await _prefs?.setString(_recipesKey, json);
  }

  Future<void> deleteRecipe(String id) async {
    final recipes = await getRecipes();
    recipes.removeWhere((r) => r.id == id);

    final json = jsonEncode(recipes.map((r) => r.toJson()).toList());
    await _prefs?.setString(_recipesKey, json);
  }

  Future<List<Sugar>> getSugars() async {
    final json = _prefs?.getString(_sugarsKey);
    if (json == null) return [];

    final List<dynamic> list = jsonDecode(json);
    return list.map((e) => Sugar.fromJson(e)).toList();
  }

  Future<void> saveSugar(Sugar sugar) async {
    final sugars = await getSugars();
    final index = sugars.indexWhere((s) => s.id == sugar.id);
    if (index >= 0) {
      sugars[index] = sugar;
    } else {
      sugars.add(sugar);
    }

    final json = jsonEncode(sugars.map((s) => s.toJson()).toList());
    await _prefs?.setString(_sugarsKey, json);
  }

  Future<void> deleteSugar(String id) async {
    final sugars = await getSugars();
    sugars.removeWhere((s) => s.id == id);

    final json = jsonEncode(sugars.map((s) => s.toJson()).toList());
    await _prefs?.setString(_sugarsKey, json);
  }
}
