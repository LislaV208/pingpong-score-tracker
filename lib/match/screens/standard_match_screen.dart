import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/widgets/end_match_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_point_button.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';

typedef OnFinishedCallback = void Function(
  NavigatorState navigator,
  StandardMatchState state,
);

class StandardMatchScreen extends StatelessWidget {
  const StandardMatchScreen({
    super.key,
    required this.onFinished,
  });

  final OnFinishedCallback onFinished;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StandardMatchCubit, StandardMatchState>(
      listener: (context, state) async {
        if (state.isFinished) {
          final navigator = Navigator.of(context);

          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => MatchFinishedDialog(
              leftPlayer: state.leftPlayer,
              rightPlayer: state.rightPlayer,
              leftPlayerScore: state.leftPlayerMatchScore,
              rightPlayerScore: state.rightPlayerMatchScore,
            ),
          );

          onFinished(navigator, state);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return await showDialog(
              context: context,
              builder: (context) => const EndMatchDialog(),
            );
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
                                    context.read<StandardMatchCubit>().undo();
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
