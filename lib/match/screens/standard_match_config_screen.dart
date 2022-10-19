import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/single_player_dropdown_button.dart';
import 'package:pingpong_score_tracker/match/widgets/standard_serve_dialog.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class StandardMatchConfigScreen extends HookWidget {
  const StandardMatchConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leftPlayer = useState<String?>(null);
    final rightPlayer = useState<String?>(null);

    final players = context
        .select<PlayersCubit, List<String>>((cubit) => cubit.state.players);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfiguracja meczu'),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Zawodnik z lewej:'),
                      const SizedBox(width: 20.0),
                      SinglePlayerDropdownButton(
                        players: players,
                        playerNotifier: leftPlayer,
                        otherPlayerNotifier: rightPlayer,
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(thickness: 5.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Zawodnik z prawej:'),
                      const SizedBox(width: 20.0),
                      SinglePlayerDropdownButton(
                        players: players,
                        playerNotifier: rightPlayer,
                        otherPlayerNotifier: leftPlayer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedCircleButton(
                    onPressed: () =>
                        _selectRandomPlayers(leftPlayer, rightPlayer, players),
                    child: const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedCircleButton(
                    onPressed:
                        leftPlayer.value == null || rightPlayer.value == null
                            ? null
                            : () => _swapPlayers(leftPlayer, rightPlayer),
                    child: const Icon(
                      Icons.compare_arrows,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedCircleButton(
                    onPressed:
                        leftPlayer.value != null && rightPlayer.value != null
                            ? () {
                                leftPlayer.value = null;
                                rightPlayer.value = null;
                              }
                            : null,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _canProceed(leftPlayer.value, rightPlayer.value)
            ? () async {
                final navigator = Navigator.of(context);
                final playerServing = await showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => StandardServeDialog(
                    leftPlayer: leftPlayer.value!,
                    rightPlayer: rightPlayer.value!,
                  ),
                );

                if (playerServing != null) {
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => StandardMatchCubit(
                          StandardMatchState(
                            leftPlayer: leftPlayer.value!,
                            rightPlayer: rightPlayer.value!,
                            playerServing: playerServing,
                            currentPlayerServing: playerServing,
                          ),
                          historyCubit: getIt.get<MatchHistoryCubit>(),
                        ),
                        child: StandardMatchScreen(
                          matchType: MatchType.single,
                          onFinished: (navigator, _) {
                            navigator.popUntil(
                              ModalRoute.withName('/'),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              }
            : null,
        backgroundColor: _canProceed(leftPlayer.value, rightPlayer.value)
            ? null
            : Colors.grey,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  void _selectRandomPlayers(
    ValueNotifier<String?> leftPlayer,
    ValueNotifier<String?> rightPlayer,
    List<String> players,
  ) {
    if (leftPlayer.value != null &&
        rightPlayer.value != null &&
        players.length == 2) {
      _swapPlayers(leftPlayer, rightPlayer);
    } else {
      var randomIndex = Random().nextInt(players.length);
      leftPlayer.value = players[randomIndex];

      final reducedPlayers = [...players]..removeWhere((element) =>
          element == leftPlayer.value || element == rightPlayer.value);

      randomIndex = Random().nextInt(reducedPlayers.length);
      rightPlayer.value = reducedPlayers[randomIndex];
    }
  }

  void _swapPlayers(
    ValueNotifier<String?> leftPlayer,
    ValueNotifier<String?> rightPlayer,
  ) {
    final temp = leftPlayer.value;
    leftPlayer.value = rightPlayer.value;
    rightPlayer.value = temp;
  }

  bool _canProceed(String? left, String? right) =>
      left != null && right != null;
}
