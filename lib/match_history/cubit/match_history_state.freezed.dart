// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'match_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchHistoryState _$MatchHistoryStateFromJson(Map<String, dynamic> json) {
  return _MatchHistoryState.fromJson(json);
}

/// @nodoc
mixin _$MatchHistoryState {
  List<MatchHistoryEntry> get history => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchHistoryStateCopyWith<MatchHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchHistoryStateCopyWith<$Res> {
  factory $MatchHistoryStateCopyWith(
          MatchHistoryState value, $Res Function(MatchHistoryState) then) =
      _$MatchHistoryStateCopyWithImpl<$Res>;
  $Res call({List<MatchHistoryEntry> history});
}

/// @nodoc
class _$MatchHistoryStateCopyWithImpl<$Res>
    implements $MatchHistoryStateCopyWith<$Res> {
  _$MatchHistoryStateCopyWithImpl(this._value, this._then);

  final MatchHistoryState _value;
  // ignore: unused_field
  final $Res Function(MatchHistoryState) _then;

  @override
  $Res call({
    Object? history = freezed,
  }) {
    return _then(_value.copyWith(
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<MatchHistoryEntry>,
    ));
  }
}

/// @nodoc
abstract class _$$_MatchHistoryStateCopyWith<$Res>
    implements $MatchHistoryStateCopyWith<$Res> {
  factory _$$_MatchHistoryStateCopyWith(_$_MatchHistoryState value,
          $Res Function(_$_MatchHistoryState) then) =
      __$$_MatchHistoryStateCopyWithImpl<$Res>;
  @override
  $Res call({List<MatchHistoryEntry> history});
}

/// @nodoc
class __$$_MatchHistoryStateCopyWithImpl<$Res>
    extends _$MatchHistoryStateCopyWithImpl<$Res>
    implements _$$_MatchHistoryStateCopyWith<$Res> {
  __$$_MatchHistoryStateCopyWithImpl(
      _$_MatchHistoryState _value, $Res Function(_$_MatchHistoryState) _then)
      : super(_value, (v) => _then(v as _$_MatchHistoryState));

  @override
  _$_MatchHistoryState get _value => super._value as _$_MatchHistoryState;

  @override
  $Res call({
    Object? history = freezed,
  }) {
    return _then(_$_MatchHistoryState(
      history: history == freezed
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<MatchHistoryEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchHistoryState implements _MatchHistoryState {
  const _$_MatchHistoryState({final List<MatchHistoryEntry> history = const []})
      : _history = history;

  factory _$_MatchHistoryState.fromJson(Map<String, dynamic> json) =>
      _$$_MatchHistoryStateFromJson(json);

  final List<MatchHistoryEntry> _history;
  @override
  @JsonKey()
  List<MatchHistoryEntry> get history {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString() {
    return 'MatchHistoryState(history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchHistoryState &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_history));

  @JsonKey(ignore: true)
  @override
  _$$_MatchHistoryStateCopyWith<_$_MatchHistoryState> get copyWith =>
      __$$_MatchHistoryStateCopyWithImpl<_$_MatchHistoryState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchHistoryStateToJson(
      this,
    );
  }
}

abstract class _MatchHistoryState implements MatchHistoryState {
  const factory _MatchHistoryState({final List<MatchHistoryEntry> history}) =
      _$_MatchHistoryState;

  factory _MatchHistoryState.fromJson(Map<String, dynamic> json) =
      _$_MatchHistoryState.fromJson;

  @override
  List<MatchHistoryEntry> get history;
  @override
  @JsonKey(ignore: true)
  _$$_MatchHistoryStateCopyWith<_$_MatchHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}
