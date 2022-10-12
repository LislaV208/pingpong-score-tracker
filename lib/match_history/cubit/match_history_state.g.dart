// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_history_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchHistoryState _$$_MatchHistoryStateFromJson(Map<String, dynamic> json) =>
    _$_MatchHistoryState(
      history: (json['history'] as List<dynamic>?)
              ?.map(
                  (e) => MatchHistoryEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_MatchHistoryStateToJson(
        _$_MatchHistoryState instance) =>
    <String, dynamic>{
      'history': instance.history,
    };
