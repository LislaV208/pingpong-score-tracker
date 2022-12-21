import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/qr_code_share/screens/scan_qr_code_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/share_players_qr_view.dart';

class PlayersOptionsButton extends StatelessWidget {
  const PlayersOptionsButton({super.key});

  static const sharePlayers = 'Udostępnij';
  static const importPlayers = 'Importuj';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) {
        Widget buildChild(IconData icon, String label) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(width: 10.0),
              Text(label),
            ],
          );
        }

        return [
          PopupMenuItem<String>(
            value: sharePlayers,
            child: buildChild(Icons.offline_share, sharePlayers),
          ),
          PopupMenuItem<String>(
            value: importPlayers,
            child: buildChild(
              Icons.qr_code_scanner,
              importPlayers,
            ),
          ),
        ];
      },
      onSelected: (value) async {
        final playersCubit = context.read<PlayersCubit>();
        final playersState = playersCubit.state;

        if (value == sharePlayers) {
          showModalBottomSheet(
            context: context,
            builder: (context) => SharePlayersQrView(
              playersJsonData: jsonEncode(playersState.toJson()),
            ),
          );
        }

        if (value == importPlayers) {
          Navigator.of(context).pushNamed(
            ScanQrCodeScreen.route,
            arguments: ScanQrCodeScreenArguments(
              onQrCodeScanned: playersCubit.importPlayersFromQrCode,
            ),
          );
        }
      },
    );
  }
}
