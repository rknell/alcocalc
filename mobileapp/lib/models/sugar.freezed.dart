// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sugar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sugar _$SugarFromJson(Map<String, dynamic> json) {
  return _Sugar.fromJson(json);
}

/// @nodoc
mixin _$Sugar {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get specificGravity => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this Sugar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sugar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SugarCopyWith<Sugar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SugarCopyWith<$Res> {
  factory $SugarCopyWith(Sugar value, $Res Function(Sugar) then) =
      _$SugarCopyWithImpl<$Res, Sugar>;
  @useResult
  $Res call(
      {String id, String name, double specificGravity, double percentage});
}

/// @nodoc
class _$SugarCopyWithImpl<$Res, $Val extends Sugar>
    implements $SugarCopyWith<$Res> {
  _$SugarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sugar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specificGravity = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specificGravity: null == specificGravity
          ? _value.specificGravity
          : specificGravity // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SugarImplCopyWith<$Res> implements $SugarCopyWith<$Res> {
  factory _$$SugarImplCopyWith(
          _$SugarImpl value, $Res Function(_$SugarImpl) then) =
      __$$SugarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, double specificGravity, double percentage});
}

/// @nodoc
class __$$SugarImplCopyWithImpl<$Res>
    extends _$SugarCopyWithImpl<$Res, _$SugarImpl>
    implements _$$SugarImplCopyWith<$Res> {
  __$$SugarImplCopyWithImpl(
      _$SugarImpl _value, $Res Function(_$SugarImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sugar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specificGravity = null,
    Object? percentage = null,
  }) {
    return _then(_$SugarImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specificGravity: null == specificGravity
          ? _value.specificGravity
          : specificGravity // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SugarImpl implements _Sugar {
  const _$SugarImpl(
      {required this.id,
      required this.name,
      required this.specificGravity,
      this.percentage = 0.01});

  factory _$SugarImpl.fromJson(Map<String, dynamic> json) =>
      _$$SugarImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double specificGravity;
  @override
  @JsonKey()
  final double percentage;

  @override
  String toString() {
    return 'Sugar(id: $id, name: $name, specificGravity: $specificGravity, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SugarImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.specificGravity, specificGravity) ||
                other.specificGravity == specificGravity) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, specificGravity, percentage);

  /// Create a copy of Sugar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SugarImplCopyWith<_$SugarImpl> get copyWith =>
      __$$SugarImplCopyWithImpl<_$SugarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SugarImplToJson(
      this,
    );
  }
}

abstract class _Sugar implements Sugar {
  const factory _Sugar(
      {required final String id,
      required final String name,
      required final double specificGravity,
      final double percentage}) = _$SugarImpl;

  factory _Sugar.fromJson(Map<String, dynamic> json) = _$SugarImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get specificGravity;
  @override
  double get percentage;

  /// Create a copy of Sugar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SugarImplCopyWith<_$SugarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
