import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';

typedef OnFinishedCallback = void Function(
  NavigatorState navigator,
  SingleMatchState state,
);

class SingleMatchScreen extends StatelessWidget {
  const SingleMatchScreen({
    super.key,
    required this.onFinished,
    required this.matchType,
  });

  final MatchType matchType;
  final OnFinishedCallback onFinished;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleMatchCubit, SingleMatchState>(
      listener: (context, state) async {
        if (state.isFinished) {
          final cubit = context.read<SingleMatchCubit>();
          final navigator = Navigator.of(context);

          final isFinished = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (_) => MatchFinishedDialog(
                  leftPlayer: state.leftPlayer,
                  rightPlayer: state.rightPlayer,
                  leftScore: state.leftPlayerMatchScore,
                  rightScore: state.rightPlayerMatchScore,
                  undo: () => context.read<SingleMatchCubit>().undo(),
                ),
              ) ??
              false;

          if (isFinished) {
            cubit.addMatchHistoryEntry(matchType);

            onFinished(navigator, state);
          }
        }
      },
      builder: (context, state) {
        return MatchScreen(
          matchScore: MatchScore(
            scoreLeft: state.leftPlayerMatchScore,
            scoreRight: state.rightPlayerMatchScore,
          ),
          leftTeamSetScore: state.leftPlayerSetScore,
          rightTeamSetScore: state.rightPlayerSetScore,
          leftTeamLabels: [
            PlayerName(
              name: state.leftPlayer,
              isServing: state.currentPlayerServing == state.leftPlayer,
            ),
          ],
          rightTeamLabels: [
            PlayerName(
              name: state.rightPlayer,
              isServing: state.currentPlayerServing == state.rightPlayer,
            ),
          ],
          onGivePointToLeftTeam: () => context
              .read<SingleMatchCubit>()
              .givePointToPlayer(state.leftPlayer),
          onGivePointToRightTeam: () => context
              .read<SingleMatchCubit>()
              .givePointToPlayer(state.rightPlayer),
          onUndoPressed: state.canUndo
              ? () => context.read<SingleMatchCubit>().undo()
              : null,
          onFlipTeamsPressed: () =>
              context.read<SingleMatchCubit>().flipPlayers(),
        );
      },
    );
  }
}
