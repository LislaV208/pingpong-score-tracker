import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'standard_match_state.freezed.dart';

@freezed
@injectable
class StandardMatchState with _$StandardMatchState {
  const factory StandardMatchState({
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
  }) = _StandardMatchState;
}
