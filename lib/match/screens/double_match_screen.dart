import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/screens/match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';

class DoubleMatchScreen extends StatelessWidget {
  const DoubleMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoubleMatchCubit, DoubleMatchState>(
      listener: (context, state) async {
        if (state.isFinished) {
          final cubit = context.read<DoubleMatchCubit>();
          final navigator = Navigator.of(context);

          final isFinished = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (_) => MatchFinishedDialog(
                  leftPlayer: state.leftTeam.name,
                  rightPlayer: state.rightTeam.name,
                  leftScore: state.leftTeamMatchScore,
                  rightScore: state.rightTeamMatchScore,
                  undo: () => context.read<DoubleMatchCubit>().undo(),
                ),
              ) ??
              false;

          if (isFinished) {
            cubit.addMatchHistoryEntry();
            navigator.popUntil(
              ModalRoute.withName('/'),
            );
          }
        }
      },
      builder: (context, state) {
        return MatchScreen(
          matchScore: MatchScore(
            teamLeft: state.leftTeam.name,
            teamRight: state.rightTeam.name,
            scoreLeft: state.leftTeamMatchScore,
            scoreRight: state.rightTeamMatchScore,
          ),
          leftTeamSetScore: state.leftTeamSetScore,
          rightTeamSetScore: state.rightTeamSetScore,
          leftTeamLabels: [
            PlayerName(
              name: state.leftTeam.topPlayer,
              isServing: state.currentPlayerServing == state.leftTeam.topPlayer,
            ),
            PlayerName(
              name: state.leftTeam.bottomPlayer,
              isServing:
                  state.currentPlayerServing == state.leftTeam.bottomPlayer,
            ),
          ],
          rightTeamLabels: [
            PlayerName(
              name: state.rightTeam.topPlayer,
              isServing:
                  state.currentPlayerServing == state.rightTeam.topPlayer,
            ),
            PlayerName(
              name: state.rightTeam.bottomPlayer,
              isServing:
                  state.currentPlayerServing == state.rightTeam.bottomPlayer,
            ),
          ],
          onGivePointToLeftTeam: () =>
              context.read<DoubleMatchCubit>().givePointToTeam(state.leftTeam),
          onGivePointToRightTeam: () =>
              context.read<DoubleMatchCubit>().givePointToTeam(state.rightTeam),
          onUndoPressed: state.canUndo
              ? () => context.read<DoubleMatchCubit>().undo()
              : null,
        );
      },
    );
  }
}
