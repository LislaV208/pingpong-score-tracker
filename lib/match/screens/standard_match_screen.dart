import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';
import 'package:pingpong_score_tracker/match/widgets/player_score.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:wakelock/wakelock.dart';

class StandardMatchScreen extends StatefulWidget {
  const StandardMatchScreen({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
  });

  final Player leftPlayer;
  final Player rightPlayer;

  @override
  State<StandardMatchScreen> createState() => _StandardMatchScreenState();
}

class _StandardMatchScreenState extends State<StandardMatchScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: ClipOval(
            //         child: Material(
            //           color: Colors.blue, // Button color
            //           child: InkWell(
            //             splashColor: Colors.red, // Splash color
            //             onTap: () {},
            //             child: SizedBox(
            //               width: 56,
            //               height: 56,
            //               child: Icon(Icons.restore),
            //             ),
            //           ),
            //         ),
            //       )),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 00),
              child: BlocConsumer<StandardMatchCubit, StandardMatchState>(
                  listener: (context, state) async {
                if (state.isFinished) {
                  final navigator = Navigator.of(context);

                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => MatchFinishedDialog(
                      leftPlayer: widget.leftPlayer,
                      rightPlayer: widget.rightPlayer,
                      leftPlayerScore: state.leftPlayerMatchScore,
                      rightPlayerScore: state.rightPlayerMatchScore,
                    ),
                  );
                  navigator.popUntil(
                    ModalRoute.withName('/'),
                  );
                }
              }, builder: (context, state) {
                return Column(
                  children: [
                    MatchScore(
                      teamLeft: widget.leftPlayer.name,
                      teamRight: widget.rightPlayer.name,
                      scoreLeft: state.leftPlayerMatchScore,
                      scoreRight: state.rightPlayerMatchScore,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.green.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 15),
                                child: ClipOval(
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<StandardMatchCubit>()
                                            .givePointToPlayer(
                                              widget.leftPlayer,
                                            );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          PlayerName(
                                            name: widget.leftPlayer.name,
                                            isServing:
                                                state.currentPlayerServing ==
                                                    widget.leftPlayer,
                                          ),
                                          PlayerScore(
                                              score: state.leftPlayerSetScore),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 4.0,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.green.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 15),
                                child: ClipOval(
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<StandardMatchCubit>()
                                            .givePointToPlayer(
                                              widget.rightPlayer,
                                            );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          PlayerName(
                                            name: widget.rightPlayer.name,
                                            isServing:
                                                state.currentPlayerServing ==
                                                    widget.rightPlayer,
                                          ),
                                          PlayerScore(
                                              score: state.rightPlayerSetScore),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
