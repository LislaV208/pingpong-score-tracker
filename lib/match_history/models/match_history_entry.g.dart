// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchHistoryEntry _$$_MatchHistoryEntryFromJson(Map<String, dynamic> json) =>
    _$_MatchHistoryEntry(
      leftPlayer: json['leftPlayer'] as String,
      leftPlayerScore: json['leftPlayerScore'] as int,
      rightPlayer: json['rightPlayer'] as String,
      rightPlayerScore: json['rightPlayerScore'] as int,
      startedAt: DateTime.parse(json['startedAt'] as String),
      finishedAt: DateTime.parse(json['finishedAt'] as String),
      matchType: $enumDecode(_$MatchTypeEnumMap, json['matchType']),
    );

Map<String, dynamic> _$$_MatchHistoryEntryToJson(
        _$_MatchHistoryEntry instance) =>
    <String, dynamic>{
      'leftPlayer': instance.leftPlayer,
      'leftPlayerScore': instance.leftPlayerScore,
      'rightPlayer': instance.rightPlayer,
      'rightPlayerScore': instance.rightPlayerScore,
      'startedAt': instance.startedAt.toIso8601String(),
      'finishedAt': instance.finishedAt.toIso8601String(),
      'matchType': _$MatchTypeEnumMap[instance.matchType]!,
    };

const _$MatchTypeEnumMap = {
  MatchType.single: 'single',
  MatchType.double: 'double',
};
