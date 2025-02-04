// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sugar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SugarImpl _$$SugarImplFromJson(Map<String, dynamic> json) => _$SugarImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      specificGravity: (json['specificGravity'] as num).toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.01,
    );

Map<String, dynamic> _$$SugarImplToJson(_$SugarImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specificGravity': instance.specificGravity,
      'percentage': instance.percentage,
    };
