// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bracket_tournament_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BracketTournamentState _$$_BracketTournamentStateFromJson(
        Map<String, dynamic> json) =>
    _$_BracketTournamentState(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => TournamentMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchesPlayedCount: json['matchesPlayedCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_BracketTournamentStateToJson(
        _$_BracketTournamentState instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'matchesPlayedCount': instance.matchesPlayedCount,
    };
