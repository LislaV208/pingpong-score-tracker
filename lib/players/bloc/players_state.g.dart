// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayersState _$$_PlayersStateFromJson(Map<String, dynamic> json) =>
    _$_PlayersState(
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_PlayersStateToJson(_$_PlayersState instance) =>
    <String, dynamic>{
      'players': instance.players,
    };
