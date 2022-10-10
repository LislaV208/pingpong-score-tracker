import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

part 'double_match_state.freezed.dart';

@freezed
@injectable
class DoubleMatchState with _$DoubleMatchState {
  const factory DoubleMatchState({
    required Team leftTeam,
    required Team rightTeam,
    required Player playerServing,
    required Player currentPlayerServing,
    @Default(false) bool isFinished,
    @Default(0) int leftTeamSetScore,
    @Default(0) int rightTeamSetScore,
    @Default(0) int leftTeamMatchScore,
    @Default(0) int rightTeamMatchScore,
    @Default(0) int playerServesCount,
    @Default(false) bool canUndo,
  }) = _DoubleMatchState;
}
