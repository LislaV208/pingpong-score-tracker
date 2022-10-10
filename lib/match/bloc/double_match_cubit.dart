import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/config.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

@injectable
class DoubleMatchCubit extends Cubit<DoubleMatchState> {
  DoubleMatchCubit(super.initialState);

  void givePointToTeam(Team team) {}

  void givePointToPlayer(String player) {
    // var leftPlayerSetScore = state.leftPlayerSetScore;
    // var rightPlayerSetScore = state.rightPlayerSetScore;
    // var currentServesCount = state.playerServesCount;
    // var currentPlayerServing = state.currentPlayerServing;
    // var leftPlayerMatchScore = state.leftPlayerMatchScore;
    // var rightPlayerMatchScore = state.rightPlayerMatchScore;
    // var playerServing = state.playerServing;
    // var isFinished = state.isFinished;

    // var setScore =
    //     player == state.leftPlayer ? leftPlayerSetScore : rightPlayerSetScore;
    // var matchScore = player == state.leftPlayer
    //     ? leftPlayerMatchScore
    //     : rightPlayerMatchScore;

    // setScore += 1;
    // currentServesCount += 1;

    // if (currentServesCount >= Config.servesPerPlayer) {
    //   currentPlayerServing = currentPlayerServing == state.leftPlayer
    //       ? state.rightPlayer
    //       : state.leftPlayer;

    //   currentServesCount = 0;
    // }

    // leftPlayerSetScore =
    //     player == state.leftPlayer ? setScore : leftPlayerSetScore;

    // rightPlayerSetScore =
    //     player == state.rightPlayer ? setScore : rightPlayerSetScore;

    // if (setScore >= Config.setWinningPoints) {
    //   if ((leftPlayerSetScore - rightPlayerSetScore).abs() >= 2) {
    //     matchScore += 1;

    //     leftPlayerMatchScore =
    //         player == state.leftPlayer ? matchScore : leftPlayerMatchScore;
    //     rightPlayerMatchScore =
    //         player == state.rightPlayer ? matchScore : rightPlayerMatchScore;

    //     leftPlayerSetScore = 0;
    //     rightPlayerSetScore = 0;
    //     currentServesCount = 0;

    //     currentPlayerServing = state.playerServing == state.leftPlayer
    //         ? state.rightPlayer
    //         : state.leftPlayer;
    //     playerServing = currentPlayerServing;

    //     if (matchScore >= Config.matchWinningPoints) {
    //       isFinished = true;
    //     }
    //   }
    // }

    // emit(state.copyWith(
    //   leftPlayerSetScore: leftPlayerSetScore,
    //   rightPlayerSetScore: rightPlayerSetScore,
    //   playerServesCount: currentServesCount,
    //   currentPlayerServing: currentPlayerServing,
    //   leftPlayerMatchScore: leftPlayerMatchScore,
    //   rightPlayerMatchScore: rightPlayerMatchScore,
    //   playerServing: playerServing,
    //   isFinished: isFinished,
    // ));
  }

  void undo() {
    // if (_stateStack.isNotEmpty) {
    //   final previousState = _stateStack.pop();
    //   emit(previousState);
    // }
  }
}
