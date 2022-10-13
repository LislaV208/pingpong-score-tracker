import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';

class BracketPlayersScreen extends HookWidget {
  const BracketPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPlayers = useState<List<String>>([]);
    final missingPlayersCount =
        _calculateMissingPlayers(selectedPlayers.value.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz graczy do turnieju'),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: BlocBuilder<PlayersCubit, PlayersState>(
                builder: (context, state) {
                  final players = state.players;
                  if (players.isEmpty) {
                    return const Center(
                      child: Text('Brak graczy'),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: players
                        .map(
                          (item) => CheckboxListTile(
                            title: Text(item),
                            activeColor: Colors.blueGrey,
                            selectedTileColor: Colors.black.withOpacity(0.1),
                            selected: selectedPlayers.value.contains(item),
                            onChanged: (bool? isSelected) {
                              final players = [...selectedPlayers.value];
                              if (isSelected ?? false) {
                                players.add(item);
                              } else {
                                players.remove(item);
                              }

                              selectedPlayers.value = players;
                            },
                            value: selectedPlayers.value.contains(item),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            Positioned(
              bottom: -20,
              child: Container(
                height: 96,
                color: Color.fromARGB(255, 54, 54, 54),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 12.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Liczba wybranych graczy: ',
                          children: <TextSpan>[
                            TextSpan(
                              text: '${selectedPlayers.value.length}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      if (missingPlayersCount > 0)
                        RichText(
                          text: TextSpan(
                            text: 'Brakuje ',
                            children: <TextSpan>[
                              TextSpan(
                                text: _calculateMissingPlayers(
                                        selectedPlayers.value.length)
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              TextSpan(
                                text: missingPlayersCount == 1
                                    ? ' gracza'
                                    : ' graczy',
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: missingPlayersCount <= 0 ? Offset.zero : Offset(0, 2),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  int _calculateMissingPlayers(int selectedPlayersCount) {
    var power = 2;
    var playersNeeded = pow(2, power);
    while (playersNeeded < selectedPlayersCount) {
      power++;
      playersNeeded = pow(2, power);
    }

    return (playersNeeded - selectedPlayersCount).truncate();
  }
}
