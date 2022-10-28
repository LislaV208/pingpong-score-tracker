import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/players/screens/add_edit_player_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/player_list_item.dart';
import 'package:pingpong_score_tracker/utils/media_query_utils.dart';
import 'package:pingpong_score_tracker/widgets/app_dialog.dart';
import 'package:pingpong_score_tracker/widgets/app_snack_bar.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';
import 'package:pingpong_score_tracker/widgets/players_list.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  static const route = 'players';

  @override
  Widget build(BuildContext context) {
    final listBottomPadding =
        MediaQuery.of(context).padding.bottom > 0 ? 0.0 : 20.0;
    final listClip = isBottomPadding(context) ? Clip.hardEdge : null;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
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
                          child: Text(
                              'Dodaj co najmniej 2 graczy, aby móc korzystać z aplikacji'),
                        );
                      }

                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(66.0, 20.0, 66.0, 0.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: Column(
                            children: [
                              Expanded(
                                child: PlayersList(
                                  players: players,
                                  itemBuilder: (index, player) {
                                    return PlayerListItem(
                                      index: index,
                                      player: player,
                                      onEditPlayer: _onAddEditPlayer,
                                      onDeletePlayer: _onPlayerDelete,
                                    );
                                  },
                                  clipBehavior: listClip,
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }

  void _onAddEditPlayer(BuildContext context, {String? player}) {
    final playersCount = context.read<PlayersCubit>().state.players.length;

    if (playersCount >= DefaultValues.maxPlayersCount) {
      AppSnackBar.show(context, 'Utworzono maksymalną liczbę graczy');
    } else {
      Navigator.of(context).pushNamed(AddEditPlayerScreen.route);
    }
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

  Future<bool> _onWillPop(BuildContext context) async {
    final canLeaveScreen =
        context.read<PlayersCubit>().state.players.length >= 2;

    if (!canLeaveScreen) {
      showDialog(
        context: context,
        builder: (context) => AppDialog(
          title: 'Komunikat',
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Dodaj co najmniej 2 graczy, aby powrócić do poprzedniego ekranu.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return canLeaveScreen;
  }
}
