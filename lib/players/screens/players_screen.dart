import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_config_screen.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_config_screen.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/match_history/screens/match_history_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/players/screens/add_edit_player_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/match_type_dialog.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_players_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';
import 'package:wakelock/wakelock.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
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
      appBar: AppBar(title: const Text('Gracze')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                          (item) => ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${players.indexOf(item) + 1}.'),
                              ],
                            ),
                            title: Text(item),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: getIt.get<PlayersCubit>(),
                                        child:
                                            AddEditPlayerScreen(player: item),
                                      ),
                                    ));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () async {
                                    final cubit = context.read<PlayersCubit>();
                                    final doRemove = await showDecisionDialog(
                                          context,
                                          title:
                                              'Czy chcesz usunąć gracza $item?',
                                        ) ??
                                        false;

                                    if (doRemove) {
                                      cubit.removePlayer(item);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: context.select<PlayersCubit, int>(
                              (value) => value.state.players.length) <
                          2
                      ? null
                      : () async {
                          final navigator = Navigator.of(context);
                          final matchType = await showDialog<MatchType?>(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: getIt.get<PlayersCubit>(),
                              child: const MatchTypeDialog(),
                            ),
                          );
                          if (matchType != null) {
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: getIt.get<PlayersCubit>(),
                                  child: matchType == MatchType.single
                                      ? const StandardMatchConfigScreen()
                                      : const DoubleMatchConfigScreen(),
                                ),
                              ),
                            );
                          }
                        },
                  child: const Text('Rozpocznij mecz'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: getIt.get<PlayersCubit>(),
                        child: const AddEditPlayerScreen(),
                      ),
                    ));
                  },
                  child: const Text('Dodaj gracza'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: getIt.get<MatchHistoryCubit>(),
                        child: const MatchHistoryScreen(),
                      ),
                    ));
                  },
                  child: const Text('Historia meczy'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        final tournamentState =
                            getIt.get<BracketTournamentCubit>().state;
                        if (tournamentState ==
                            BracketTournamentState.notStarted()) {
                          return BlocProvider.value(
                            value: getIt.get<PlayersCubit>(),
                            child: const BracketPlayersScreen(),
                          );
                        }
                        return BlocProvider.value(
                          value: getIt.get<BracketTournamentCubit>(),
                          child: const BracketTournamentScreen(),
                        );
                      },
                    ));
                  },
                  icon: Icon(Icons.emoji_events),
                  label: Text('Turniej'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
