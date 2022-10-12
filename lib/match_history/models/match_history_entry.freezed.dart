// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'match_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchHistoryEntry _$MatchHistoryEntryFromJson(Map<String, dynamic> json) {
  return _MatchHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$MatchHistoryEntry {
  String get leftPlayer => throw _privateConstructorUsedError;
  int get leftPlayerScore => throw _privateConstructorUsedError;
  String get rightPlayer => throw _privateConstructorUsedError;
  int get rightPlayerScore => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime get finishedAt => throw _privateConstructorUsedError;
  MatchType get matchType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchHistoryEntryCopyWith<MatchHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchHistoryEntryCopyWith<$Res> {
  factory $MatchHistoryEntryCopyWith(
          MatchHistoryEntry value, $Res Function(MatchHistoryEntry) then) =
      _$MatchHistoryEntryCopyWithImpl<$Res>;
  $Res call(
      {String leftPlayer,
      int leftPlayerScore,
      String rightPlayer,
      int rightPlayerScore,
      DateTime startedAt,
      DateTime finishedAt,
      MatchType matchType});
}

/// @nodoc
class _$MatchHistoryEntryCopyWithImpl<$Res>
    implements $MatchHistoryEntryCopyWith<$Res> {
  _$MatchHistoryEntryCopyWithImpl(this._value, this._then);

  final MatchHistoryEntry _value;
  // ignore: unused_field
  final $Res Function(MatchHistoryEntry) _then;

  @override
  $Res call({
    Object? leftPlayer = freezed,
    Object? leftPlayerScore = freezed,
    Object? rightPlayer = freezed,
    Object? rightPlayerScore = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? matchType = freezed,
  }) {
    return _then(_value.copyWith(
      leftPlayer: leftPlayer == freezed
          ? _value.leftPlayer
          : leftPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      leftPlayerScore: leftPlayerScore == freezed
          ? _value.leftPlayerScore
          : leftPlayerScore // ignore: cast_nullable_to_non_nullable
              as int,
      rightPlayer: rightPlayer == freezed
          ? _value.rightPlayer
          : rightPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      rightPlayerScore: rightPlayerScore == freezed
          ? _value.rightPlayerScore
          : rightPlayerScore // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: startedAt == freezed
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finishedAt: finishedAt == freezed
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchType: matchType == freezed
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as MatchType,
    ));
  }
}

/// @nodoc
abstract class _$$_MatchHistoryEntryCopyWith<$Res>
    implements $MatchHistoryEntryCopyWith<$Res> {
  factory _$$_MatchHistoryEntryCopyWith(_$_MatchHistoryEntry value,
          $Res Function(_$_MatchHistoryEntry) then) =
      __$$_MatchHistoryEntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String leftPlayer,
      int leftPlayerScore,
      String rightPlayer,
      int rightPlayerScore,
      DateTime startedAt,
      DateTime finishedAt,
      MatchType matchType});
}

/// @nodoc
class __$$_MatchHistoryEntryCopyWithImpl<$Res>
    extends _$MatchHistoryEntryCopyWithImpl<$Res>
    implements _$$_MatchHistoryEntryCopyWith<$Res> {
  __$$_MatchHistoryEntryCopyWithImpl(
      _$_MatchHistoryEntry _value, $Res Function(_$_MatchHistoryEntry) _then)
      : super(_value, (v) => _then(v as _$_MatchHistoryEntry));

  @override
  _$_MatchHistoryEntry get _value => super._value as _$_MatchHistoryEntry;

  @override
  $Res call({
    Object? leftPlayer = freezed,
    Object? leftPlayerScore = freezed,
    Object? rightPlayer = freezed,
    Object? rightPlayerScore = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? matchType = freezed,
  }) {
    return _then(_$_MatchHistoryEntry(
      leftPlayer: leftPlayer == freezed
          ? _value.leftPlayer
          : leftPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      leftPlayerScore: leftPlayerScore == freezed
          ? _value.leftPlayerScore
          : leftPlayerScore // ignore: cast_nullable_to_non_nullable
              as int,
      rightPlayer: rightPlayer == freezed
          ? _value.rightPlayer
          : rightPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      rightPlayerScore: rightPlayerScore == freezed
          ? _value.rightPlayerScore
          : rightPlayerScore // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: startedAt == freezed
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finishedAt: finishedAt == freezed
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchType: matchType == freezed
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as MatchType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchHistoryEntry implements _MatchHistoryEntry {
  const _$_MatchHistoryEntry(
      {required this.leftPlayer,
      required this.leftPlayerScore,
      required this.rightPlayer,
      required this.rightPlayerScore,
      required this.startedAt,
      required this.finishedAt,
      required this.matchType});

  factory _$_MatchHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$$_MatchHistoryEntryFromJson(json);

  @override
  final String leftPlayer;
  @override
  final int leftPlayerScore;
  @override
  final String rightPlayer;
  @override
  final int rightPlayerScore;
  @override
  final DateTime startedAt;
  @override
  final DateTime finishedAt;
  @override
  final MatchType matchType;

  @override
  String toString() {
    return 'MatchHistoryEntry(leftPlayer: $leftPlayer, leftPlayerScore: $leftPlayerScore, rightPlayer: $rightPlayer, rightPlayerScore: $rightPlayerScore, startedAt: $startedAt, finishedAt: $finishedAt, matchType: $matchType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchHistoryEntry &&
            const DeepCollectionEquality()
                .equals(other.leftPlayer, leftPlayer) &&
            const DeepCollectionEquality()
                .equals(other.leftPlayerScore, leftPlayerScore) &&
            const DeepCollectionEquality()
                .equals(other.rightPlayer, rightPlayer) &&
            const DeepCollectionEquality()
                .equals(other.rightPlayerScore, rightPlayerScore) &&
            const DeepCollectionEquality().equals(other.startedAt, startedAt) &&
            const DeepCollectionEquality()
                .equals(other.finishedAt, finishedAt) &&
            const DeepCollectionEquality().equals(other.matchType, matchType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(leftPlayer),
      const DeepCollectionEquality().hash(leftPlayerScore),
      const DeepCollectionEquality().hash(rightPlayer),
      const DeepCollectionEquality().hash(rightPlayerScore),
      const DeepCollectionEquality().hash(startedAt),
      const DeepCollectionEquality().hash(finishedAt),
      const DeepCollectionEquality().hash(matchType));

  @JsonKey(ignore: true)
  @override
  _$$_MatchHistoryEntryCopyWith<_$_MatchHistoryEntry> get copyWith =>
      __$$_MatchHistoryEntryCopyWithImpl<_$_MatchHistoryEntry>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchHistoryEntryToJson(
      this,
    );
  }
}

abstract class _MatchHistoryEntry implements MatchHistoryEntry {
  const factory _MatchHistoryEntry(
      {required final String leftPlayer,
      required final int leftPlayerScore,
      required final String rightPlayer,
      required final int rightPlayerScore,
      required final DateTime startedAt,
      required final DateTime finishedAt,
      required final MatchType matchType}) = _$_MatchHistoryEntry;

  factory _MatchHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$_MatchHistoryEntry.fromJson;

  @override
  String get leftPlayer;
  @override
  int get leftPlayerScore;
  @override
  String get rightPlayer;
  @override
  int get rightPlayerScore;
  @override
  DateTime get startedAt;
  @override
  DateTime get finishedAt;
  @override
  MatchType get matchType;
  @override
  @JsonKey(ignore: true)
  _$$_MatchHistoryEntryCopyWith<_$_MatchHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
