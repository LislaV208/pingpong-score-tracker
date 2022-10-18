import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/standard_serve_dialog.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';

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
                      DropdownButton<String>(
                        value: leftPlayer.value,
                        items: players
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList()
                          ..removeWhere(
                            (element) => element.value == rightPlayer.value,
                          ),
                        onChanged: (value) {
                          if (value != null) {
                            leftPlayer.value = value;
                          }
                        },
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
                      DropdownButton<String>(
                        value: rightPlayer.value,
                        items: players
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList()
                          ..removeWhere(
                            (element) => element.value == leftPlayer.value,
                          ),
                        onChanged: (value) {
                          if (value != null) {
                            rightPlayer.value = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: leftPlayer.value == null || rightPlayer.value == null
                  ? null
                  : () {
                      final temp = leftPlayer.value;
                      leftPlayer.value = rightPlayer.value;
                      rightPlayer.value = temp;
                    },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blue, // <-- Button color
                disabledBackgroundColor: Colors.grey,
              ),
              child: const Icon(
                Icons.compare_arrows,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canProceed(leftPlayer.value, rightPlayer.value)
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
                          matchType: MatchType.single,
                        ),
                        child: StandardMatchScreen(
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
        backgroundColor: canProceed(leftPlayer.value, rightPlayer.value)
            ? null
            : Colors.grey,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  bool canProceed(String? left, String? right) => left != null && right != null;
}
