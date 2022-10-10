import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

part 'standard_match_state.freezed.dart';

@freezed
@injectable
class StandardMatchState with _$StandardMatchState {
  const factory StandardMatchState({
    required Player leftPlayer,
    required Player rightPlayer,
    required Player playerServing,
    required Player currentPlayerServing,
    @Default(false) bool isFinished,
    @Default(0) int leftPlayerSetScore,
    @Default(0) int rightPlayerSetScore,
    @Default(0) int leftPlayerMatchScore,
    @Default(0) int rightPlayerMatchScore,
    @Default(0) int playerServesCount,
  }) = _StandardMatchState;
}
