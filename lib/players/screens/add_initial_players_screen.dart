import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/ads/banner_ad_view.dart';
import 'package:pingpong_score_tracker/home/screens/home_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/qr_code_share/screens/scan_qr_code_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/add_player_field.dart';
import 'package:pingpong_score_tracker/players/widgets/player_list_item.dart';
import 'package:pingpong_score_tracker/widgets/players_list.dart';

class AddInitialPlayersScreen extends StatefulWidget {
  const AddInitialPlayersScreen({super.key});

  static const route = 'add-initial-players';

  @override
  State<AddInitialPlayersScreen> createState() =>
      _AddInitialPlayersScreenState();
}

class _AddInitialPlayersScreenState extends State<AddInitialPlayersScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gracze'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              Navigator.of(context).pushNamed(
                ScanQrCodeScreen.route,
                arguments: ScanQrCodeScreenArguments(
                  onQrCodeScanned:
                      context.read<PlayersCubit>().importPlayersFromQrCode,
                ),
              );
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            label: const Text(
              'Importuj',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: BannerAdView(
        child: SafeArea(
          child: BlocBuilder<PlayersCubit, PlayersState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    AddPlayerField(
                      onSaveSuccess: (_) => _animatePlayersListToTop(),
                    ),
                    Expanded(
                      child: BlocBuilder<PlayersCubit, PlayersState>(
                        builder: (context, state) {
                          final players = state.players;
                          if (players.isEmpty) {
                            return const Center(
                              child: Text(
                                  'Dodaj co najmniej 2 graczy, aby kontynuować.'),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: PlayersList(
                              controller: controller,
                              players: players.reversed.toList(),
                              itemBuilder: (index, player) {
                                return PlayerListItem(
                                  index: index,
                                  player: player,
                                  dense: true,
                                  onDeletePlayer: _onPlayerDelete,
                                );
                              },
                              portrait: true,
                              clipBehavior: Clip.hardEdge,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<PlayersCubit, PlayersState>(
        builder: (context, state) {
          final canProceed = state.players.length >= 2;
          return FloatingActionButton(
            onPressed: canProceed ? () => _navigateToNextScreen() : null,
            backgroundColor: canProceed ? null : Colors.grey,
            child: Icon(
              Icons.arrow_forward,
              color: canProceed ? null : Colors.white,
            ),
          );
        },
      ),
    );
  }

  void _animatePlayersListToTop() {
    final playersCount = context.read<PlayersCubit>().state.players.length;
    if (playersCount > 1) {
      controller.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPlayerDelete(BuildContext context, String player) {
    context.read<PlayersCubit>().removePlayer(player);
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacementNamed(HomeScreen.route);
  }
}
