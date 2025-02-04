// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_sugar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeSugarImpl _$$RecipeSugarImplFromJson(Map<String, dynamic> json) =>
    _$RecipeSugarImpl(
      sugar: Sugar.fromJson(json['sugar'] as Map<String, dynamic>),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$RecipeSugarImplToJson(_$RecipeSugarImpl instance) =>
    <String, dynamic>{
      'sugar': instance.sugar,
      'percentage': instance.percentage,
    };
