// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Team {
  String get topPlayer => throw _privateConstructorUsedError;
  String get bottomPlayer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res>;
  $Res call({String topPlayer, String bottomPlayer});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res> implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  final Team _value;
  // ignore: unused_field
  final $Res Function(Team) _then;

  @override
  $Res call({
    Object? topPlayer = freezed,
    Object? bottomPlayer = freezed,
  }) {
    return _then(_value.copyWith(
      topPlayer: topPlayer == freezed
          ? _value.topPlayer
          : topPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      bottomPlayer: bottomPlayer == freezed
          ? _value.bottomPlayer
          : bottomPlayer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$_TeamCopyWith(_$_Team value, $Res Function(_$_Team) then) =
      __$$_TeamCopyWithImpl<$Res>;
  @override
  $Res call({String topPlayer, String bottomPlayer});
}

/// @nodoc
class __$$_TeamCopyWithImpl<$Res> extends _$TeamCopyWithImpl<$Res>
    implements _$$_TeamCopyWith<$Res> {
  __$$_TeamCopyWithImpl(_$_Team _value, $Res Function(_$_Team) _then)
      : super(_value, (v) => _then(v as _$_Team));

  @override
  _$_Team get _value => super._value as _$_Team;

  @override
  $Res call({
    Object? topPlayer = freezed,
    Object? bottomPlayer = freezed,
  }) {
    return _then(_$_Team(
      topPlayer: topPlayer == freezed
          ? _value.topPlayer
          : topPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      bottomPlayer: bottomPlayer == freezed
          ? _value.bottomPlayer
          : bottomPlayer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Team extends _Team {
  const _$_Team({required this.topPlayer, required this.bottomPlayer})
      : super._();

  @override
  final String topPlayer;
  @override
  final String bottomPlayer;

  @override
  String toString() {
    return 'Team(topPlayer: $topPlayer, bottomPlayer: $bottomPlayer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Team &&
            const DeepCollectionEquality().equals(other.topPlayer, topPlayer) &&
            const DeepCollectionEquality()
                .equals(other.bottomPlayer, bottomPlayer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(topPlayer),
      const DeepCollectionEquality().hash(bottomPlayer));

  @JsonKey(ignore: true)
  @override
  _$$_TeamCopyWith<_$_Team> get copyWith =>
      __$$_TeamCopyWithImpl<_$_Team>(this, _$identity);
}

abstract class _Team extends Team {
  const factory _Team(
      {required final String topPlayer,
      required final String bottomPlayer}) = _$_Team;
  const _Team._() : super._();

  @override
  String get topPlayer;
  @override
  String get bottomPlayer;
  @override
  @JsonKey(ignore: true)
  _$$_TeamCopyWith<_$_Team> get copyWith => throw _privateConstructorUsedError;
}
