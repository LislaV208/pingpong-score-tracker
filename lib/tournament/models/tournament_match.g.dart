// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TournamentMatch _$$_TournamentMatchFromJson(Map<String, dynamic> json) =>
    _$_TournamentMatch(
      player1: json['player1'] as String,
      player2: json['player2'] as String,
      player1Score: json['player1Score'] as int? ?? 0,
      player2Score: json['player2Score'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TournamentMatchToJson(_$_TournamentMatch instance) =>
    <String, dynamic>{
      'player1': instance.player1,
      'player2': instance.player2,
      'player1Score': instance.player1Score,
      'player2Score': instance.player2Score,
    };
