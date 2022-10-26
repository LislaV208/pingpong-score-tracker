// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'configuration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConfigurationState _$ConfigurationStateFromJson(Map<String, dynamic> json) {
  return _ConfigurationState.fromJson(json);
}

/// @nodoc
mixin _$ConfigurationState {
  int get pointsInSet => throw _privateConstructorUsedError;
  int get setsInMatch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigurationStateCopyWith<ConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationStateCopyWith<$Res> {
  factory $ConfigurationStateCopyWith(
          ConfigurationState value, $Res Function(ConfigurationState) then) =
      _$ConfigurationStateCopyWithImpl<$Res>;
  $Res call({int pointsInSet, int setsInMatch});
}

/// @nodoc
class _$ConfigurationStateCopyWithImpl<$Res>
    implements $ConfigurationStateCopyWith<$Res> {
  _$ConfigurationStateCopyWithImpl(this._value, this._then);

  final ConfigurationState _value;
  // ignore: unused_field
  final $Res Function(ConfigurationState) _then;

  @override
  $Res call({
    Object? pointsInSet = freezed,
    Object? setsInMatch = freezed,
  }) {
    return _then(_value.copyWith(
      pointsInSet: pointsInSet == freezed
          ? _value.pointsInSet
          : pointsInSet // ignore: cast_nullable_to_non_nullable
              as int,
      setsInMatch: setsInMatch == freezed
          ? _value.setsInMatch
          : setsInMatch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ConfigurationStateCopyWith<$Res>
    implements $ConfigurationStateCopyWith<$Res> {
  factory _$$_ConfigurationStateCopyWith(_$_ConfigurationState value,
          $Res Function(_$_ConfigurationState) then) =
      __$$_ConfigurationStateCopyWithImpl<$Res>;
  @override
  $Res call({int pointsInSet, int setsInMatch});
}

/// @nodoc
class __$$_ConfigurationStateCopyWithImpl<$Res>
    extends _$ConfigurationStateCopyWithImpl<$Res>
    implements _$$_ConfigurationStateCopyWith<$Res> {
  __$$_ConfigurationStateCopyWithImpl(
      _$_ConfigurationState _value, $Res Function(_$_ConfigurationState) _then)
      : super(_value, (v) => _then(v as _$_ConfigurationState));

  @override
  _$_ConfigurationState get _value => super._value as _$_ConfigurationState;

  @override
  $Res call({
    Object? pointsInSet = freezed,
    Object? setsInMatch = freezed,
  }) {
    return _then(_$_ConfigurationState(
      pointsInSet: pointsInSet == freezed
          ? _value.pointsInSet
          : pointsInSet // ignore: cast_nullable_to_non_nullable
              as int,
      setsInMatch: setsInMatch == freezed
          ? _value.setsInMatch
          : setsInMatch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigurationState implements _ConfigurationState {
  const _$_ConfigurationState(
      {required this.pointsInSet, required this.setsInMatch});

  factory _$_ConfigurationState.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigurationStateFromJson(json);

  @override
  final int pointsInSet;
  @override
  final int setsInMatch;

  @override
  String toString() {
    return 'ConfigurationState(pointsInSet: $pointsInSet, setsInMatch: $setsInMatch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigurationState &&
            const DeepCollectionEquality()
                .equals(other.pointsInSet, pointsInSet) &&
            const DeepCollectionEquality()
                .equals(other.setsInMatch, setsInMatch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pointsInSet),
      const DeepCollectionEquality().hash(setsInMatch));

  @JsonKey(ignore: true)
  @override
  _$$_ConfigurationStateCopyWith<_$_ConfigurationState> get copyWith =>
      __$$_ConfigurationStateCopyWithImpl<_$_ConfigurationState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigurationStateToJson(
      this,
    );
  }
}

abstract class _ConfigurationState implements ConfigurationState {
  const factory _ConfigurationState(
      {required final int pointsInSet,
      required final int setsInMatch}) = _$_ConfigurationState;

  factory _ConfigurationState.fromJson(Map<String, dynamic> json) =
      _$_ConfigurationState.fromJson;

  @override
  int get pointsInSet;
  @override
  int get setsInMatch;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigurationStateCopyWith<_$_ConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}
