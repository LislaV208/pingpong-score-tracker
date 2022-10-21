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
      appBar: AppBar(
        title: const Text('Gracze'),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BlocBuilder<PlayersCubit, PlayersState>(
              builder: (context, state) {
                final players = state.players;
                if (players.isEmpty) {
                  return const Center(
                    child: Text('Brak graczy'),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 76.0),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ListView(
                        children: _generateListChildren(
                          context,
                          players: players,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () => _onAddEditPlayer(context),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateListChildren(
    BuildContext context, {
    required List<String> players,
  }) {
    Widget listItemBuilder(int index, String player) {
      return Expanded(
        child: Card(
          child: ListTile(
            minLeadingWidth: 20.0,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('${index + 1}.')],
            ),
            title: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(player),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _onAddEditPlayer(context, player: player),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _onPlayerDelete(context, player),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < players.length; i += 2) {
      final player1 = players[i];
      final player2 = i + 1 >= players.length ? null : players[i + 1];

      final row = Row(
        children: [
          listItemBuilder(i, player1),
          if (player2 != null) listItemBuilder(i + 1, player2),
        ],
      );

      children.add(row);
    }

    return children;
  }

  void _onAddEditPlayer(BuildContext context, {String? player}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt.get<PlayersCubit>(),
          child: AddEditPlayerScreen(player: player),
        ),
      ),
    );
  }

  void _onPlayerDelete(BuildContext context, String player) async {
    final cubit = context.read<PlayersCubit>();
    final doRemove = await showDecisionDialog(
          context,
          title: 'Czy chcesz usunąć gracza $player?',
        ) ??
        false;

    if (doRemove) {
      cubit.removePlayer(player);
    }
  }
}
