// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tournament_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TournamentMatch _$TournamentMatchFromJson(Map<String, dynamic> json) {
  return _TournamentMatch.fromJson(json);
}

/// @nodoc
mixin _$TournamentMatch {
  String get player1 => throw _privateConstructorUsedError;
  String get player2 => throw _privateConstructorUsedError;
  int get player1Score => throw _privateConstructorUsedError;
  int get player2Score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentMatchCopyWith<TournamentMatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentMatchCopyWith<$Res> {
  factory $TournamentMatchCopyWith(
          TournamentMatch value, $Res Function(TournamentMatch) then) =
      _$TournamentMatchCopyWithImpl<$Res>;
  $Res call(
      {String player1, String player2, int player1Score, int player2Score});
}

/// @nodoc
class _$TournamentMatchCopyWithImpl<$Res>
    implements $TournamentMatchCopyWith<$Res> {
  _$TournamentMatchCopyWithImpl(this._value, this._then);

  final TournamentMatch _value;
  // ignore: unused_field
  final $Res Function(TournamentMatch) _then;

  @override
  $Res call({
    Object? player1 = freezed,
    Object? player2 = freezed,
    Object? player1Score = freezed,
    Object? player2Score = freezed,
  }) {
    return _then(_value.copyWith(
      player1: player1 == freezed
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as String,
      player2: player2 == freezed
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as String,
      player1Score: player1Score == freezed
          ? _value.player1Score
          : player1Score // ignore: cast_nullable_to_non_nullable
              as int,
      player2Score: player2Score == freezed
          ? _value.player2Score
          : player2Score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_TournamentMatchCopyWith<$Res>
    implements $TournamentMatchCopyWith<$Res> {
  factory _$$_TournamentMatchCopyWith(
          _$_TournamentMatch value, $Res Function(_$_TournamentMatch) then) =
      __$$_TournamentMatchCopyWithImpl<$Res>;
  @override
  $Res call(
      {String player1, String player2, int player1Score, int player2Score});
}

/// @nodoc
class __$$_TournamentMatchCopyWithImpl<$Res>
    extends _$TournamentMatchCopyWithImpl<$Res>
    implements _$$_TournamentMatchCopyWith<$Res> {
  __$$_TournamentMatchCopyWithImpl(
      _$_TournamentMatch _value, $Res Function(_$_TournamentMatch) _then)
      : super(_value, (v) => _then(v as _$_TournamentMatch));

  @override
  _$_TournamentMatch get _value => super._value as _$_TournamentMatch;

  @override
  $Res call({
    Object? player1 = freezed,
    Object? player2 = freezed,
    Object? player1Score = freezed,
    Object? player2Score = freezed,
  }) {
    return _then(_$_TournamentMatch(
      player1: player1 == freezed
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as String,
      player2: player2 == freezed
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as String,
      player1Score: player1Score == freezed
          ? _value.player1Score
          : player1Score // ignore: cast_nullable_to_non_nullable
              as int,
      player2Score: player2Score == freezed
          ? _value.player2Score
          : player2Score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TournamentMatch extends _TournamentMatch {
  const _$_TournamentMatch(
      {required this.player1,
      required this.player2,
      this.player1Score = 0,
      this.player2Score = 0})
      : super._();

  factory _$_TournamentMatch.fromJson(Map<String, dynamic> json) =>
      _$$_TournamentMatchFromJson(json);

  @override
  final String player1;
  @override
  final String player2;
  @override
  @JsonKey()
  final int player1Score;
  @override
  @JsonKey()
  final int player2Score;

  @override
  String toString() {
    return 'TournamentMatch(player1: $player1, player2: $player2, player1Score: $player1Score, player2Score: $player2Score)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentMatch &&
            const DeepCollectionEquality().equals(other.player1, player1) &&
            const DeepCollectionEquality().equals(other.player2, player2) &&
            const DeepCollectionEquality()
                .equals(other.player1Score, player1Score) &&
            const DeepCollectionEquality()
                .equals(other.player2Score, player2Score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(player1),
      const DeepCollectionEquality().hash(player2),
      const DeepCollectionEquality().hash(player1Score),
      const DeepCollectionEquality().hash(player2Score));

  @JsonKey(ignore: true)
  @override
  _$$_TournamentMatchCopyWith<_$_TournamentMatch> get copyWith =>
      __$$_TournamentMatchCopyWithImpl<_$_TournamentMatch>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TournamentMatchToJson(
      this,
    );
  }
}

abstract class _TournamentMatch extends TournamentMatch {
  const factory _TournamentMatch(
      {required final String player1,
      required final String player2,
      final int player1Score,
      final int player2Score}) = _$_TournamentMatch;
  const _TournamentMatch._() : super._();

  factory _TournamentMatch.fromJson(Map<String, dynamic> json) =
      _$_TournamentMatch.fromJson;

  @override
  String get player1;
  @override
  String get player2;
  @override
  int get player1Score;
  @override
  int get player2Score;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentMatchCopyWith<_$_TournamentMatch> get copyWith =>
      throw _privateConstructorUsedError;
}
