import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/standard_serve_dialog.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class StandardMatchConfigScreen extends HookWidget {
  const StandardMatchConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leftPlayer = useState<Player?>(null);
    final rightPlayer = useState<Player?>(null);

    final players = context
        .select<PlayersCubit, List<Player>>((cubit) => cubit.state.players);

    return Scaffold(
      appBar: AppBar(
        title: Text('Konfiguracja meczu'),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Zawodnik z lewej:'),
                    SizedBox(width: 20.0),
                    DropdownButton<Player>(
                      value: leftPlayer.value,
                      items: players
                          .map(
                            (item) => DropdownMenuItem<Player>(
                              value: item,
                              child: Text(item.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          leftPlayer.value = value;
                        }
                      },
                    ),
                  ],
                ),
              ),
              VerticalDivider(thickness: 5.0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Zawodnik z prawej:'),
                    SizedBox(width: 20.0),
                    DropdownButton<Player>(
                      value: rightPlayer.value,
                      items: players
                          .map(
                            (item) => DropdownMenuItem<Player>(
                              value: item,
                              child: Text(item.name),
                            ),
                          )
                          .toList(),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canProceed(leftPlayer.value, rightPlayer.value)
            ? () async {
                final navigator = Navigator.of(context);
                final playerServing = await showDialog<Player>(
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
                        ),
                        child: const StandardMatchScreen(),
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

  bool canProceed(Player? left, Player? right) => left != null && right != null;
}
