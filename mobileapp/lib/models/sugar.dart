import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'sugar.freezed.dart';
part 'sugar.g.dart';

@freezed
class Sugar with _$Sugar {
  const factory Sugar({
    required String id,
    required String name,
    required double specificGravity,
    @Default(0.01) double percentage,
  }) = _Sugar;

  factory Sugar.fromJson(Map<String, dynamic> json) => _$SugarFromJson(json);

  factory Sugar.create({
    required String name,
    required double specificGravity,
    double percentage = 0.01,
  }) =>
      Sugar(
        id: const Uuid().v4(),
        name: name,
        specificGravity: specificGravity,
        percentage: percentage,
      );
}
