import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';
import 'package:stack/stack.dart';

class SingleMatchCubit extends Cubit<SingleMatchState> {
  SingleMatchCubit(
    super.initialState, {
    required this.historyCubit,
    required this.configurationCubit,
  }) {
    _startedAt = DateTime.now();
  }

  final MatchHistoryCubit historyCubit;
  final ConfigurationCubit configurationCubit;

  final _stateStack = Stack<SingleMatchState>();
  late final DateTime _startedAt;

  void givePointToPlayer(String player) {
    var leftPlayer = state.leftPlayer;
    var rightPlayer = state.rightPlayer;
    var leftPlayerSetScore = state.leftPlayerSetScore;
    var rightPlayerSetScore = state.rightPlayerSetScore;
    var currentServesCount = state.playerServesCount;
    var currentPlayerServing = state.currentPlayerServing;
    var leftPlayerMatchScore = state.leftPlayerMatchScore;
    var rightPlayerMatchScore = state.rightPlayerMatchScore;
    var playerServing = state.playerServing;
    var isFinished = state.isFinished;

    var setScore =
        player == state.leftPlayer ? leftPlayerSetScore : rightPlayerSetScore;
    var matchScore = player == state.leftPlayer
        ? leftPlayerMatchScore
        : rightPlayerMatchScore;

    setScore += 1;
    currentServesCount += 1;

    if (currentServesCount >= DefaultValues.servesPerPlayer) {
      currentPlayerServing = currentPlayerServing == state.leftPlayer
          ? state.rightPlayer
          : state.leftPlayer;

      currentServesCount = 0;
    }

    leftPlayerSetScore =
        player == state.leftPlayer ? setScore : leftPlayerSetScore;

    rightPlayerSetScore =
        player == state.rightPlayer ? setScore : rightPlayerSetScore;

    if (setScore >= configurationCubit.state.pointsInSet) {
      // setScore >= configurationCubit.state.pointsInSet extra check is for special case
      // when configurationCubit.state.pointsInSet == 1
      if ((leftPlayerSetScore - rightPlayerSetScore).abs() >= 2 ||
          setScore >= configurationCubit.state.pointsInSet) {
        matchScore += 1;

        leftPlayerMatchScore =
            player == state.leftPlayer ? matchScore : leftPlayerMatchScore;
        rightPlayerMatchScore =
            player == state.rightPlayer ? matchScore : rightPlayerMatchScore;

        leftPlayerSetScore = 0;
        rightPlayerSetScore = 0;
        currentServesCount = 0;

        currentPlayerServing = state.playerServing == state.leftPlayer
            ? state.rightPlayer
            : state.leftPlayer;
        playerServing = currentPlayerServing;

        if (matchScore >= configurationCubit.state.setsInMatch) {
          isFinished = true;
        } else {
          // flip players
          final tempPlayer = leftPlayer;
          leftPlayer = rightPlayer;
          rightPlayer = tempPlayer;
          final tempScore = leftPlayerMatchScore;
          leftPlayerMatchScore = rightPlayerMatchScore;
          rightPlayerMatchScore = tempScore;
        }
      }
    }

    _stateStack.push(state);

    emit(state.copyWith(
      leftPlayer: leftPlayer,
      rightPlayer: rightPlayer,
      leftPlayerSetScore: leftPlayerSetScore,
      rightPlayerSetScore: rightPlayerSetScore,
      playerServesCount: currentServesCount,
      currentPlayerServing: currentPlayerServing,
      leftPlayerMatchScore: leftPlayerMatchScore,
      rightPlayerMatchScore: rightPlayerMatchScore,
      playerServing: playerServing,
      isFinished: isFinished,
      canUndo: _stateStack.isNotEmpty,
    ));
  }

  void undo() {
    if (_stateStack.isNotEmpty) {
      final previousState = _stateStack.pop();
      emit(previousState);
    }
  }

  void addMatchHistoryEntry(MatchType matchType) {
    assert(matchType != MatchType.double,
        "Match type can be only 'single' or 'tournament'");
    historyCubit.addMatchHistoryEntry(
      MatchHistoryEntry(
        leftPlayer: state.leftPlayer,
        leftPlayerScore: state.leftPlayerMatchScore,
        rightPlayer: state.rightPlayer,
        rightPlayerScore: state.rightPlayerMatchScore,
        startedAt: _startedAt,
        finishedAt: DateTime.now(),
        matchType: matchType,
      ),
    );
  }
}
