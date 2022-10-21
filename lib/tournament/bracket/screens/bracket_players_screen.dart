import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              final players = context.read<PlayersCubit>().state.players;

              selectedPlayers.value =
                  selectedPlayers.value.length == players.length
                      ? []
                      : [...players];
            },
            icon: const Icon(Icons.select_all),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: Padding(
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
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: const Color.fromARGB(255, 54, 54, 54),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Liczba wybranych graczy: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${selectedPlayers.value.length}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                    style: const TextStyle(
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 250),
                          offset: missingPlayersCount <= 0
                              ? Offset.zero
                              : const Offset(0, 2),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).viewPadding.right),
                            child: FloatingActionButton.small(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: getIt.get<BracketTournamentCubit>()
                                        ..start(selectedPlayers.value),
                                      child: const BracketTournamentScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
