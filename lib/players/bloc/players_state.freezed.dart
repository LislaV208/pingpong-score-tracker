// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'players_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayersState _$PlayersStateFromJson(Map<String, dynamic> json) {
  return _PlayersState.fromJson(json);
}

/// @nodoc
mixin _$PlayersState {
  List<Player> get players => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayersStateCopyWith<PlayersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayersStateCopyWith<$Res> {
  factory $PlayersStateCopyWith(
          PlayersState value, $Res Function(PlayersState) then) =
      _$PlayersStateCopyWithImpl<$Res>;
  $Res call({List<Player> players});
}

/// @nodoc
class _$PlayersStateCopyWithImpl<$Res> implements $PlayersStateCopyWith<$Res> {
  _$PlayersStateCopyWithImpl(this._value, this._then);

  final PlayersState _value;
  // ignore: unused_field
  final $Res Function(PlayersState) _then;

  @override
  $Res call({
    Object? players = freezed,
  }) {
    return _then(_value.copyWith(
      players: players == freezed
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
    ));
  }
}

/// @nodoc
abstract class _$$_PlayersStateCopyWith<$Res>
    implements $PlayersStateCopyWith<$Res> {
  factory _$$_PlayersStateCopyWith(
          _$_PlayersState value, $Res Function(_$_PlayersState) then) =
      __$$_PlayersStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Player> players});
}

/// @nodoc
class __$$_PlayersStateCopyWithImpl<$Res>
    extends _$PlayersStateCopyWithImpl<$Res>
    implements _$$_PlayersStateCopyWith<$Res> {
  __$$_PlayersStateCopyWithImpl(
      _$_PlayersState _value, $Res Function(_$_PlayersState) _then)
      : super(_value, (v) => _then(v as _$_PlayersState));

  @override
  _$_PlayersState get _value => super._value as _$_PlayersState;

  @override
  $Res call({
    Object? players = freezed,
  }) {
    return _then(_$_PlayersState(
      players: players == freezed
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayersState implements _PlayersState {
  const _$_PlayersState({final List<Player> players = const []})
      : _players = players;

  factory _$_PlayersState.fromJson(Map<String, dynamic> json) =>
      _$$_PlayersStateFromJson(json);

  final List<Player> _players;
  @override
  @JsonKey()
  List<Player> get players {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'PlayersState(players: $players)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayersState &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  _$$_PlayersStateCopyWith<_$_PlayersState> get copyWith =>
      __$$_PlayersStateCopyWithImpl<_$_PlayersState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayersStateToJson(
      this,
    );
  }
}

abstract class _PlayersState implements PlayersState {
  const factory _PlayersState({final List<Player> players}) = _$_PlayersState;

  factory _PlayersState.fromJson(Map<String, dynamic> json) =
      _$_PlayersState.fromJson;

  @override
  List<Player> get players;
  @override
  @JsonKey(ignore: true)
  _$$_PlayersStateCopyWith<_$_PlayersState> get copyWith =>
      throw _privateConstructorUsedError;
}
