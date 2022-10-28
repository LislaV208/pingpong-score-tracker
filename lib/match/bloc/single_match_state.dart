import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_match_state.freezed.dart';

@freezed
class SingleMatchState with _$SingleMatchState {
  const factory SingleMatchState({
    required String leftPlayer,
    required String rightPlayer,
    required String playerServing,
    required String currentPlayerServing,
    @Default(false) bool isFinished,
    @Default(0) int leftPlayerSetScore,
    @Default(0) int rightPlayerSetScore,
    @Default(0) int leftPlayerMatchScore,
    @Default(0) int rightPlayerMatchScore,
    @Default(0) int playerServesCount,
    @Default(false) bool canUndo,
  }) = _SingleMatchState;
}
