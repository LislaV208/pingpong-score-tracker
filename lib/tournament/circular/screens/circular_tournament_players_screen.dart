import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/approx_time_button.dart';
import 'package:pingpong_score_tracker/widgets/players_list.dart';

class CircularTournamentPlayersScreen extends HookWidget {
  const CircularTournamentPlayersScreen({super.key});

  static const route = 'circular-tournament-players';

  @override
  Widget build(BuildContext context) {
    final selectedPlayers = useState<List<String>>([]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz graczy do turnieju'),
        actions: [
          IconButton(
            onPressed: () => _onSelectedAll(context, selectedPlayers),
            icon: const Icon(Icons.select_all),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: BlocBuilder<PlayersCubit, PlayersState>(
                    builder: (context, state) {
                      final players = state.players;
                      if (players.isEmpty) {
                        return const Center(
                          child: Text('Brak graczy'),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: PlayersList(
                            players: players,
                            itemBuilder: (index, player) {
                              return CheckboxListTile(
                                title: Text(player),
                                activeColor: Colors.blueGrey,
                                selectedTileColor:
                                    Colors.black.withOpacity(0.1),
                                selected:
                                    selectedPlayers.value.contains(player),
                                onChanged: (bool? isSelected) =>
                                    _onPlayerSelected(
                                        selectedPlayers, isSelected, player),
                                value: selectedPlayers.value.contains(player),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _BottomPanel(
                selectedPlayersCount: selectedPlayers.value.length,
                onFabPressed: () =>
                    _goToTournamentScreen(context, selectedPlayers.value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSelectedAll(
      BuildContext context, ValueNotifier<List<String>> selectedPlayers) {
    final players = context.read<PlayersCubit>().state.players;

    selectedPlayers.value =
        selectedPlayers.value.length == players.length ? [] : [...players];
  }

  void _onPlayerSelected(ValueNotifier<List<String>> selectedPlayers,
      bool? isSelected, String player) {
    final players = [...selectedPlayers.value];
    if (isSelected ?? false) {
      players.add(player);
    } else {
      players.remove(player);
    }

    selectedPlayers.value = players;
  }

  void _goToTournamentScreen(
    BuildContext context,
    List<String> selectedPlayers,
  ) {
    context.read<BracketTournamentCubit>().start(selectedPlayers);
    Navigator.of(context).pushNamed(BracketTournamentScreen.route);
  }
}

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.selectedPlayersCount,
    required this.onFabPressed,
  });

  final int selectedPlayersCount;
  final VoidCallback onFabPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 54, 54, 54),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).padding.bottom / 4,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 14.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).padding.left,
                  ),
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 250),
                    offset: selectedPlayersCount >=
                            DefaultValues.minCircularTournamentPlayersCount
                        ? Offset.zero
                        : const Offset(0, 2),
                    child: ApproxTimeButton(
                      matchesToPlayCount: matchesToPlayCount,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Liczba wybranych graczy: ',
                    style: const TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$selectedPlayersCount',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _getHelperTextValue(),
                    style: const TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (selectedPlayersCount >= DefaultValues.maxPlayersCount)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Wybrano maksymalną ilość graczy',
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 14.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).padding.right,
                  ),
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 250),
                    offset: selectedPlayersCount >=
                            DefaultValues.minCircularTournamentPlayersCount
                        ? Offset.zero
                        : const Offset(0, 2),
                    child: FloatingActionButton.small(
                      onPressed: onFabPressed,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int get matchesToPlayCount =>
      selectedPlayersCount * (selectedPlayersCount - 1) ~/ 2;

  String _getHelperTextValue() {
    if (selectedPlayersCount <
        DefaultValues.minCircularTournamentPlayersCount) {
      return 'Wybierz co najmniej 3 graczy';
    }

    return _getGamesToPlayText();
  }

  String _getGamesToPlayText() {
    return 'Liczba meczy do rozegrania: $matchesToPlayCount';
  }
}
