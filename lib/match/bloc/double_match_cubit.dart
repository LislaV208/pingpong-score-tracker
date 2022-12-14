import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';
import 'package:stack/stack.dart';

class DoubleMatchCubit extends Cubit<DoubleMatchState> {
  DoubleMatchCubit(
    super.initialState, {
    required this.historyCubit,
    required this.configurationCubit,
  }) {
    _startedAt = DateTime.now();
  }

  final MatchHistoryCubit historyCubit;
  final ConfigurationCubit configurationCubit;

  final _stateStack = Stack<DoubleMatchState>();
  late final DateTime _startedAt;

  String _computePlayerServing() {
    if (state.playerServingSet == state.leftTeam.topPlayer) {
      if (state.currentPlayerServing == state.leftTeam.topPlayer) {
        return state.rightTeam.bottomPlayer;
      }
      if (state.currentPlayerServing == state.leftTeam.bottomPlayer) {
        return state.rightTeam.topPlayer;
      }
      if (state.currentPlayerServing == state.rightTeam.topPlayer) {
        return state.leftTeam.topPlayer;
      }
      return state.leftTeam.bottomPlayer;
    }

    if (state.playerServingSet == state.leftTeam.bottomPlayer) {
      if (state.currentPlayerServing == state.leftTeam.bottomPlayer) {
        return state.rightTeam.topPlayer;
      }
      if (state.currentPlayerServing == state.leftTeam.topPlayer) {
        return state.rightTeam.bottomPlayer;
      }
      if (state.currentPlayerServing == state.rightTeam.topPlayer) {
        return state.leftTeam.topPlayer;
      }
      return state.leftTeam.bottomPlayer;
    }

    if (state.playerServingSet == state.rightTeam.topPlayer) {
      if (state.currentPlayerServing == state.rightTeam.topPlayer) {
        return state.leftTeam.bottomPlayer;
      }
      if (state.currentPlayerServing == state.rightTeam.bottomPlayer) {
        return state.leftTeam.topPlayer;
      }
      if (state.currentPlayerServing == state.leftTeam.topPlayer) {
        return state.rightTeam.topPlayer;
      }
      return state.rightTeam.bottomPlayer;
    }

    if (state.currentPlayerServing == state.rightTeam.bottomPlayer) {
      return state.leftTeam.topPlayer;
    }
    if (state.currentPlayerServing == state.rightTeam.topPlayer) {
      return state.leftTeam.bottomPlayer;
    }
    if (state.currentPlayerServing == state.leftTeam.topPlayer) {
      return state.rightTeam.topPlayer;
    }
    return state.rightTeam.bottomPlayer;
  }

  String _computePlayerServingAfterSet() {
    if (state.playerServingMatch == state.playerServingSet) {
      if (state.playerServingSet == state.leftTeam.topPlayer) {
        return state.rightTeam.bottomPlayer;
      }
      if (state.playerServingSet == state.leftTeam.bottomPlayer) {
        return state.rightTeam.topPlayer;
      }
      if (state.playerServingSet == state.rightTeam.topPlayer) {
        return state.leftTeam.bottomPlayer;
      }
      return state.leftTeam.topPlayer;
    }

    if (state.playerServingMatch == state.leftTeam.topPlayer) {
      return state.leftTeam.bottomPlayer;
    }

    if (state.playerServingMatch == state.leftTeam.bottomPlayer) {
      return state.leftTeam.topPlayer;
    }

    if (state.playerServingMatch == state.rightTeam.topPlayer) {
      return state.rightTeam.bottomPlayer;
    }

    return state.rightTeam.topPlayer;
  }

  void givePointToTeam(Team team) {
    var leftTeam = state.leftTeam;
    var rightTeam = state.rightTeam;
    var leftTeamSetScore = state.leftTeamSetScore;
    var rightTeamSetScore = state.rightTeamSetScore;
    var currentServesCount = state.playerServesCount;
    var currentPlayerServing = state.currentPlayerServing;
    var leftTeamMatchScore = state.leftTeamMatchScore;
    var rightTeamMatchScore = state.rightTeamMatchScore;
    var playerServingSet = state.playerServingSet;
    var isFinished = state.isFinished;

    var setScore =
        team == state.leftTeam ? leftTeamSetScore : rightTeamSetScore;
    var matchScore =
        team == state.leftTeam ? leftTeamMatchScore : rightTeamMatchScore;

    setScore += 1;
    currentServesCount += 1;

    if (currentServesCount >= DefaultValues.servesPerPlayer) {
      currentPlayerServing = _computePlayerServing();

      currentServesCount = 0;
    }

    leftTeamSetScore = team == state.leftTeam ? setScore : leftTeamSetScore;
    rightTeamSetScore = team == state.rightTeam ? setScore : rightTeamSetScore;

    if (setScore >= configurationCubit.state.pointsInSet) {
      // setScore >= configurationCubit.state.pointsInSet extra check is for special case
      // when configurationCubit.state.pointsInSet == 1
      if ((leftTeamSetScore - rightTeamSetScore).abs() >= 2 ||
          setScore >= configurationCubit.state.pointsInSet) {
        matchScore += 1;

        leftTeamMatchScore =
            team == state.leftTeam ? matchScore : leftTeamMatchScore;
        rightTeamMatchScore =
            team == state.rightTeam ? matchScore : rightTeamMatchScore;

        leftTeamSetScore = 0;
        rightTeamSetScore = 0;
        currentServesCount = 0;

        currentPlayerServing = _computePlayerServingAfterSet();
        playerServingSet = currentPlayerServing;

        // FLIP TEAMS
        final tempLeftTeam = leftTeam;
        leftTeam = rightTeam;
        rightTeam = tempLeftTeam;

        var teamToSwap = team == leftTeam ? rightTeam : leftTeam;
        final tempTopPlayer = teamToSwap.topPlayer;
        final topPlayer = teamToSwap.bottomPlayer;
        final bottomPlayer = tempTopPlayer;
        teamToSwap = teamToSwap.copyWith(
          topPlayer: topPlayer,
          bottomPlayer: bottomPlayer,
        );

        if (team == leftTeam) {
          rightTeam = teamToSwap;
        } else {
          leftTeam = teamToSwap;
        }

        final tempLeftScore = leftTeamMatchScore;
        leftTeamMatchScore = rightTeamMatchScore;
        rightTeamMatchScore = tempLeftScore;

        // ----------

        if (matchScore >= configurationCubit.state.setsInMatch) {
          isFinished = true;
        }
      }
    }

    _stateStack.push(state);

    emit(state.copyWith(
      leftTeam: leftTeam,
      rightTeam: rightTeam,
      leftTeamSetScore: leftTeamSetScore,
      rightTeamSetScore: rightTeamSetScore,
      playerServesCount: currentServesCount,
      currentPlayerServing: currentPlayerServing,
      leftTeamMatchScore: leftTeamMatchScore,
      rightTeamMatchScore: rightTeamMatchScore,
      playerServingSet: playerServingSet,
      isFinished: isFinished,
      canUndo: _stateStack.isNotEmpty,
    ));
  }

  void flipTeams() {
    final tempTeam = state.leftTeam;
    final leftTeam = state.rightTeam;
    final rightTeam = tempTeam;

    final tempSetScore = state.leftTeamSetScore;
    final leftSetScore = state.rightTeamSetScore;
    final rightSetScore = tempSetScore;

    final tempMatchScore = state.leftTeamMatchScore;
    final leftTeamMatchScore = state.rightTeamMatchScore;
    final rightTeamMatchScore = tempMatchScore;

    _flipStateStack();

    emit(state.copyWith(
      leftTeam: leftTeam,
      rightTeam: rightTeam,
      leftTeamSetScore: leftSetScore,
      rightTeamSetScore: rightSetScore,
      leftTeamMatchScore: leftTeamMatchScore,
      rightTeamMatchScore: rightTeamMatchScore,
    ));
  }

  void undo() {
    if (_stateStack.isNotEmpty) {
      final previousState = _stateStack.pop();
      emit(previousState);
    }
  }

  void addMatchHistoryEntry() {
    historyCubit.addMatchHistoryEntry(
      MatchHistoryEntry(
        leftPlayer: state.leftTeam.name,
        leftPlayerScore: state.leftTeamMatchScore,
        rightPlayer: state.rightTeam.name,
        rightPlayerScore: state.rightTeamMatchScore,
        startedAt: _startedAt,
        finishedAt: DateTime.now(),
        matchType: MatchType.double,
      ),
    );
  }

  void _flipStateStack() {
    final oldStates = <DoubleMatchState>[];
    while (_stateStack.isNotEmpty) {
      oldStates.add(_stateStack.pop());
    }

    for (final oldState in oldStates.reversed) {
      final tempTeam = oldState.leftTeam;
      final leftTeam = oldState.rightTeam;
      final rightTeam = tempTeam;

      final tempSetScore = oldState.leftTeamSetScore;
      final leftSetScore = oldState.rightTeamSetScore;
      final rightSetScore = tempSetScore;

      final tempMatchScore = oldState.leftTeamMatchScore;
      final leftTeamMatchScore = oldState.rightTeamMatchScore;
      final rightTeamMatchScore = tempMatchScore;

      _stateStack.push(
        oldState.copyWith(
          leftTeam: leftTeam,
          rightTeam: rightTeam,
          leftTeamSetScore: leftSetScore,
          rightTeamSetScore: rightSetScore,
          leftTeamMatchScore: leftTeamMatchScore,
          rightTeamMatchScore: rightTeamMatchScore,
        ),
      );
    }
  }
}
