import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match/widgets/end_match_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_point_button.dart';
import 'package:pingpong_score_tracker/match/widgets/team_point_button.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';
import 'package:wakelock/wakelock.dart';

class DoubleMatchScreen extends StatefulWidget {
  const DoubleMatchScreen({super.key});

  @override
  State<DoubleMatchScreen> createState() => _DoubleMatchScreenState();
}

class _DoubleMatchScreenState extends State<DoubleMatchScreen> {
  @override
  void initState() {
    super.initState();

    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoubleMatchCubit, DoubleMatchState>(
      listener: (context, state) async {
        if (state.isFinished) {
          final navigator = Navigator.of(context);

          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => MatchFinishedDialog(
              leftPlayer: state.leftTeam.name,
              rightPlayer: state.rightTeam.name,
              leftPlayerScore: state.leftTeamMatchScore,
              rightPlayerScore: state.rightTeamMatchScore,
            ),
          );
          navigator.popUntil(
            ModalRoute.withName('/'),
          );
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
                teamLeft: state.leftTeam.name,
                teamRight: state.rightTeam.name,
                scoreLeft: state.leftTeamMatchScore,
                scoreRight: state.rightTeamMatchScore,
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
                                    child: TeamPointButton(
                                      team: state.leftTeam,
                                      currentPlayerServing:
                                          state.currentPlayerServing,
                                      setScore: state.leftTeamSetScore,
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 4.0,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    child: TeamPointButton(
                                      team: state.rightTeam,
                                      currentPlayerServing:
                                          state.currentPlayerServing,
                                      setScore: state.rightTeamSetScore,
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
                                    context.read<DoubleMatchCubit>().undo();
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
