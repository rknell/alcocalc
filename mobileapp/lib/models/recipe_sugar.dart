import 'package:freezed_annotation/freezed_annotation.dart';
import 'sugar.dart';

part 'recipe_sugar.freezed.dart';
part 'recipe_sugar.g.dart';

@freezed
class RecipeSugar with _$RecipeSugar {
  const factory RecipeSugar({
    required Sugar sugar,
    required double percentage,
  }) = _RecipeSugar;

  factory RecipeSugar.fromJson(Map<String, dynamic> json) =>
      _$RecipeSugarFromJson(json);
}
