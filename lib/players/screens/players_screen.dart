import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/players/screens/add_edit_player_screen.dart';
import 'package:pingpong_score_tracker/utils/media_query_utils.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';
import 'package:pingpong_score_tracker/widgets/players_list.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listBottomPadding =
        MediaQuery.of(context).padding.bottom > 0 ? 0.0 : 20.0;
    final listClip = isBottomPadding(context) ? Clip.hardEdge : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gracze'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: listBottomPadding,
              ),
              child: SafeArea(
                child: BlocBuilder<PlayersCubit, PlayersState>(
                  builder: (context, state) {
                    final players = state.players;
                    if (players.isEmpty) {
                      return const Center(
                        child: Text('Brak graczy'),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 66.0),
                      child: PlayersList(
                        players: players,
                        itemBuilder: (index, player) {
                          return _ListItem(
                            index: index,
                            player: player,
                            onEditPlayer: _onAddEditPlayer,
                            onDeletePlayer: _onPlayerDelete,
                          );
                        },
                        clipBehavior: listClip,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).padding.right / 4 + 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () => _onAddEditPlayer(context),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
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

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.index,
    required this.player,
    required this.onEditPlayer,
    required this.onDeletePlayer,
  });

  final int index;
  final String player;
  final void Function(BuildContext context, {String? player}) onEditPlayer;
  final void Function(BuildContext context, String player) onDeletePlayer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            onPressed: () => onEditPlayer(context, player: player),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => onDeletePlayer(context, player),
          ),
        ],
      ),
    );
  }
}
