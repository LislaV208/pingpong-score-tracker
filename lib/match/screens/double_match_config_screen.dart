import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/circle_button.dart';
import 'package:pingpong_score_tracker/match/widgets/double_serve_dialog.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class DoubleMatchConfigScreen extends HookWidget {
  const DoubleMatchConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leftTopPlayer = useState<Player?>(null);
    final leftBottomPlayer = useState<Player?>(null);
    final rightTopPlayer = useState<Player?>(null);
    final rightBottomPlayer = useState<Player?>(null);

    final players = context
        .select<PlayersCubit, List<Player>>((cubit) => cubit.state.players);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfiguracja meczu'),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zawodnik w lewym górnym:'),
                        const SizedBox(width: 20.0),
                        DropdownButton<Player>(
                          value: leftTopPlayer.value,
                          items: players
                              .map(
                                (item) => DropdownMenuItem<Player>(
                                  value: item,
                                  child: Text(item.name),
                                ),
                              )
                              .toList()
                            ..removeWhere(
                              (element) =>
                                  element.value == leftBottomPlayer.value ||
                                  element.value == rightTopPlayer.value ||
                                  element.value == rightBottomPlayer.value,
                            ),
                          onChanged: (value) {
                            if (value != null) {
                              leftTopPlayer.value = value;
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: CircleButton(
                          onPressed: leftTopPlayer.value != null &&
                                  leftBottomPlayer.value != null
                              ? () {
                                  final temp = leftTopPlayer.value;
                                  leftTopPlayer.value = leftBottomPlayer.value;
                                  leftBottomPlayer.value = temp;
                                }
                              : null,
                          child: const Icon(Icons.compare_arrows),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zawodnik w lewym dolnym:'),
                        const SizedBox(width: 20.0),
                        DropdownButton<Player>(
                          value: leftBottomPlayer.value,
                          items: players
                              .map(
                                (item) => DropdownMenuItem<Player>(
                                  value: item,
                                  child: Text(item.name),
                                ),
                              )
                              .toList()
                            ..removeWhere(
                              (element) =>
                                  element.value == leftTopPlayer.value ||
                                  element.value == rightTopPlayer.value ||
                                  element.value == rightBottomPlayer.value,
                            ),
                          onChanged: (value) {
                            if (value != null) {
                              leftBottomPlayer.value = value;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const VerticalDivider(thickness: 5.0),
                  CircleButton(
                    onPressed: leftTopPlayer.value != null &&
                            leftBottomPlayer.value != null &&
                            rightTopPlayer.value != null &&
                            rightBottomPlayer.value != null
                        ? () {
                            final tempLeftTop = leftTopPlayer.value;
                            leftTopPlayer.value = rightTopPlayer.value;
                            rightTopPlayer.value = tempLeftTop;

                            final tempLeftBottom = leftBottomPlayer.value;
                            leftBottomPlayer.value = rightBottomPlayer.value;
                            rightBottomPlayer.value = tempLeftBottom;
                          }
                        : null,
                    child: const Icon(Icons.compare_arrows),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zawodnik w prawym górnym:'),
                        const SizedBox(width: 20.0),
                        DropdownButton<Player>(
                          value: rightTopPlayer.value,
                          items: players
                              .map(
                                (item) => DropdownMenuItem<Player>(
                                  value: item,
                                  child: Text(item.name),
                                ),
                              )
                              .toList()
                            ..removeWhere(
                              (element) =>
                                  element.value == leftBottomPlayer.value ||
                                  element.value == leftTopPlayer.value ||
                                  element.value == rightBottomPlayer.value,
                            ),
                          onChanged: (value) {
                            if (value != null) {
                              rightTopPlayer.value = value;
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: CircleButton(
                          onPressed: rightTopPlayer.value != null &&
                                  rightBottomPlayer.value != null
                              ? () {
                                  final temp = rightTopPlayer.value;
                                  rightTopPlayer.value =
                                      rightBottomPlayer.value;
                                  rightBottomPlayer.value = temp;
                                }
                              : null,
                          child: const Icon(Icons.compare_arrows),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zawodnik w prawym dolnym:'),
                        const SizedBox(width: 20.0),
                        DropdownButton<Player>(
                          value: rightBottomPlayer.value,
                          items: players
                              .map(
                                (item) => DropdownMenuItem<Player>(
                                  value: item,
                                  child: Text(item.name),
                                ),
                              )
                              .toList()
                            ..removeWhere(
                              (element) =>
                                  element.value == leftBottomPlayer.value ||
                                  element.value == leftTopPlayer.value ||
                                  element.value == rightTopPlayer.value,
                            ),
                          onChanged: (value) {
                            if (value != null) {
                              rightBottomPlayer.value = value;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canProceed(
          leftTopPlayer.value,
          leftBottomPlayer.value,
          rightTopPlayer.value,
          rightBottomPlayer.value,
        )
            ? () async {
                final navigator = Navigator.of(context);
                final playerServing = await showDialog<Player>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => DoubleServeDialog(
                    leftTopPlayer: leftTopPlayer.value!,
                    leftBottomPlayer: leftBottomPlayer.value!,
                    rightTopPlayer: rightTopPlayer.value!,
                    rightBottomPlayer: rightBottomPlayer.value!,
                  ),
                );

                if (playerServing != null) {
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => DoubleMatchCubit(
                          DoubleMatchState(
                            leftTeam: Team(
                              topPlayer: leftTopPlayer.value!,
                              bottomPlayer: leftBottomPlayer.value!,
                            ),
                            rightTeam: Team(
                              topPlayer: rightTopPlayer.value!,
                              bottomPlayer: rightBottomPlayer.value!,
                            ),
                            playerServingSet: playerServing,
                            playerServingMatch: playerServing,
                            currentPlayerServing: playerServing,
                          ),
                        ),
                        child: const DoubleMatchScreen(),
                      ),
                    ),
                  );
                }
              }
            : null,
        backgroundColor: canProceed(
          leftTopPlayer.value,
          leftBottomPlayer.value,
          rightTopPlayer.value,
          rightBottomPlayer.value,
        )
            ? null
            : Colors.grey,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  bool canProceed(Player? leftTop, Player? leftBottom, Player? rightTop,
          Player? rightBottom) =>
      leftTop != null &&
      leftBottom != null &&
      rightTop != null &&
      rightBottom != null;
}
