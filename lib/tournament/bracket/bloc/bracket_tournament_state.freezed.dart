// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bracket_tournament_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BracketTournamentState _$BracketTournamentStateFromJson(
    Map<String, dynamic> json) {
  return _BracketTournamentState.fromJson(json);
}

/// @nodoc
mixin _$BracketTournamentState {
  List<TournamentMatch> get matches => throw _privateConstructorUsedError;
  int get matchesPlayedCount => throw _privateConstructorUsedError;
  int get playersCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BracketTournamentStateCopyWith<BracketTournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BracketTournamentStateCopyWith<$Res> {
  factory $BracketTournamentStateCopyWith(BracketTournamentState value,
          $Res Function(BracketTournamentState) then) =
      _$BracketTournamentStateCopyWithImpl<$Res>;
  $Res call(
      {List<TournamentMatch> matches,
      int matchesPlayedCount,
      int playersCount});
}

/// @nodoc
class _$BracketTournamentStateCopyWithImpl<$Res>
    implements $BracketTournamentStateCopyWith<$Res> {
  _$BracketTournamentStateCopyWithImpl(this._value, this._then);

  final BracketTournamentState _value;
  // ignore: unused_field
  final $Res Function(BracketTournamentState) _then;

  @override
  $Res call({
    Object? matches = freezed,
    Object? matchesPlayedCount = freezed,
    Object? playersCount = freezed,
  }) {
    return _then(_value.copyWith(
      matches: matches == freezed
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<TournamentMatch>,
      matchesPlayedCount: matchesPlayedCount == freezed
          ? _value.matchesPlayedCount
          : matchesPlayedCount // ignore: cast_nullable_to_non_nullable
              as int,
      playersCount: playersCount == freezed
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_BracketTournamentStateCopyWith<$Res>
    implements $BracketTournamentStateCopyWith<$Res> {
  factory _$$_BracketTournamentStateCopyWith(_$_BracketTournamentState value,
          $Res Function(_$_BracketTournamentState) then) =
      __$$_BracketTournamentStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<TournamentMatch> matches,
      int matchesPlayedCount,
      int playersCount});
}

/// @nodoc
class __$$_BracketTournamentStateCopyWithImpl<$Res>
    extends _$BracketTournamentStateCopyWithImpl<$Res>
    implements _$$_BracketTournamentStateCopyWith<$Res> {
  __$$_BracketTournamentStateCopyWithImpl(_$_BracketTournamentState _value,
      $Res Function(_$_BracketTournamentState) _then)
      : super(_value, (v) => _then(v as _$_BracketTournamentState));

  @override
  _$_BracketTournamentState get _value =>
      super._value as _$_BracketTournamentState;

  @override
  $Res call({
    Object? matches = freezed,
    Object? matchesPlayedCount = freezed,
    Object? playersCount = freezed,
  }) {
    return _then(_$_BracketTournamentState(
      matches: matches == freezed
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<TournamentMatch>,
      matchesPlayedCount: matchesPlayedCount == freezed
          ? _value.matchesPlayedCount
          : matchesPlayedCount // ignore: cast_nullable_to_non_nullable
              as int,
      playersCount: playersCount == freezed
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BracketTournamentState extends _BracketTournamentState {
  const _$_BracketTournamentState(
      {required final List<TournamentMatch> matches,
      this.matchesPlayedCount = 0,
      this.playersCount = 0})
      : _matches = matches,
        super._();

  factory _$_BracketTournamentState.fromJson(Map<String, dynamic> json) =>
      _$$_BracketTournamentStateFromJson(json);

  final List<TournamentMatch> _matches;
  @override
  List<TournamentMatch> get matches {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  @override
  @JsonKey()
  final int matchesPlayedCount;
  @override
  @JsonKey()
  final int playersCount;

  @override
  String toString() {
    return 'BracketTournamentState(matches: $matches, matchesPlayedCount: $matchesPlayedCount, playersCount: $playersCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BracketTournamentState &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            const DeepCollectionEquality()
                .equals(other.matchesPlayedCount, matchesPlayedCount) &&
            const DeepCollectionEquality()
                .equals(other.playersCount, playersCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_matches),
      const DeepCollectionEquality().hash(matchesPlayedCount),
      const DeepCollectionEquality().hash(playersCount));

  @JsonKey(ignore: true)
  @override
  _$$_BracketTournamentStateCopyWith<_$_BracketTournamentState> get copyWith =>
      __$$_BracketTournamentStateCopyWithImpl<_$_BracketTournamentState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BracketTournamentStateToJson(
      this,
    );
  }
}

abstract class _BracketTournamentState extends BracketTournamentState {
  const factory _BracketTournamentState(
      {required final List<TournamentMatch> matches,
      final int matchesPlayedCount,
      final int playersCount}) = _$_BracketTournamentState;
  const _BracketTournamentState._() : super._();

  factory _BracketTournamentState.fromJson(Map<String, dynamic> json) =
      _$_BracketTournamentState.fromJson;

  @override
  List<TournamentMatch> get matches;
  @override
  int get matchesPlayedCount;
  @override
  int get playersCount;
  @override
  @JsonKey(ignore: true)
  _$$_BracketTournamentStateCopyWith<_$_BracketTournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}
