import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

part 'team.freezed.dart';

@freezed
class Team with _$Team {
  const Team._();

  const factory Team({
    required Player topPlayer,
    required Player bottomPlayer,
  }) = _Team;

  String get name => '${topPlayer.name} - ${bottomPlayer.name}';
}
