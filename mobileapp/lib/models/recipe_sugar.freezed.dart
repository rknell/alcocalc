// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_sugar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeSugar _$RecipeSugarFromJson(Map<String, dynamic> json) {
  return _RecipeSugar.fromJson(json);
}

/// @nodoc
mixin _$RecipeSugar {
  Sugar get sugar => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this RecipeSugar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeSugarCopyWith<RecipeSugar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeSugarCopyWith<$Res> {
  factory $RecipeSugarCopyWith(
          RecipeSugar value, $Res Function(RecipeSugar) then) =
      _$RecipeSugarCopyWithImpl<$Res, RecipeSugar>;
  @useResult
  $Res call({Sugar sugar, double percentage});

  $SugarCopyWith<$Res> get sugar;
}

/// @nodoc
class _$RecipeSugarCopyWithImpl<$Res, $Val extends RecipeSugar>
    implements $RecipeSugarCopyWith<$Res> {
  _$RecipeSugarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sugar = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as Sugar,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SugarCopyWith<$Res> get sugar {
    return $SugarCopyWith<$Res>(_value.sugar, (value) {
      return _then(_value.copyWith(sugar: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeSugarImplCopyWith<$Res>
    implements $RecipeSugarCopyWith<$Res> {
  factory _$$RecipeSugarImplCopyWith(
          _$RecipeSugarImpl value, $Res Function(_$RecipeSugarImpl) then) =
      __$$RecipeSugarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Sugar sugar, double percentage});

  @override
  $SugarCopyWith<$Res> get sugar;
}

/// @nodoc
class __$$RecipeSugarImplCopyWithImpl<$Res>
    extends _$RecipeSugarCopyWithImpl<$Res, _$RecipeSugarImpl>
    implements _$$RecipeSugarImplCopyWith<$Res> {
  __$$RecipeSugarImplCopyWithImpl(
      _$RecipeSugarImpl _value, $Res Function(_$RecipeSugarImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sugar = null,
    Object? percentage = null,
  }) {
    return _then(_$RecipeSugarImpl(
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as Sugar,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeSugarImpl implements _RecipeSugar {
  const _$RecipeSugarImpl({required this.sugar, required this.percentage});

  factory _$RecipeSugarImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeSugarImplFromJson(json);

  @override
  final Sugar sugar;
  @override
  final double percentage;

  @override
  String toString() {
    return 'RecipeSugar(sugar: $sugar, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeSugarImpl &&
            (identical(other.sugar, sugar) || other.sugar == sugar) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sugar, percentage);

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeSugarImplCopyWith<_$RecipeSugarImpl> get copyWith =>
      __$$RecipeSugarImplCopyWithImpl<_$RecipeSugarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeSugarImplToJson(
      this,
    );
  }
}

abstract class _RecipeSugar implements RecipeSugar {
  const factory _RecipeSugar(
      {required final Sugar sugar,
      required final double percentage}) = _$RecipeSugarImpl;

  factory _RecipeSugar.fromJson(Map<String, dynamic> json) =
      _$RecipeSugarImpl.fromJson;

  @override
  Sugar get sugar;
  @override
  double get percentage;

  /// Create a copy of RecipeSugar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeSugarImplCopyWith<_$RecipeSugarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
