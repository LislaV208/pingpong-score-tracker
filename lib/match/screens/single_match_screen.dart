import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/widgets/end_match_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_point_button.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';

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
        return WillPopScope(
          onWillPop: () async {
            return await showDialog(
                  context: context,
                  builder: (context) => const EndMatchDialog(),
                ) ??
                false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: MatchScore(
                teamLeft: state.leftPlayer,
                teamRight: state.rightPlayer,
                scoreLeft: state.leftPlayerMatchScore,
                scoreRight: state.rightPlayerMatchScore,
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PlayerPointButton(
                                      player: state.leftPlayer,
                                      currentPlayerServing:
                                          state.currentPlayerServing,
                                      setScore: state.leftPlayerSetScore,
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 4.0,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    child: PlayerPointButton(
                                      player: state.rightPlayer,
                                      currentPlayerServing:
                                          state.currentPlayerServing,
                                      setScore: state.rightPlayerSetScore,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: UndoButton(
                            onPressed: state.canUndo
                                ? () {
                                    context.read<SingleMatchCubit>().undo();
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
