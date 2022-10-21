import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/players/screens/add_edit_player_screen.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
