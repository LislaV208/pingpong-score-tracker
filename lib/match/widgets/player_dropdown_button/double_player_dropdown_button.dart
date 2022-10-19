import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/match/widgets/player_dropdown_button/player_dropdown_button.dart';

class DoublePlayerDropdownButton extends StatelessWidget {
  const DoublePlayerDropdownButton({
    super.key,
    required this.players,
    required this.playerNotifier,
    required this.otherPlayerNotifiers,
  });

  final List<String> players;
  final ValueNotifier<String?> playerNotifier;
  final List<ValueNotifier<String?>> otherPlayerNotifiers;

  @override
  Widget build(BuildContext context) {
    return PlayerDropdownButton(
      players: players,
      playerNotifier: playerNotifier,
      removeOtherPlayersPredicate: (item) => otherPlayerNotifiers
          .any((otherPlayer) => otherPlayer.value == item.value),
      setOtherPlayersOnChange: () {
        const minDoublePlayersNeeded = 4;

        if (players.length == minDoublePlayersNeeded) {
          final notSelectedPlayers = otherPlayerNotifiers
              .where((element) => element.value == null)
              .toList();
          if (notSelectedPlayers.length == 1) {
            final notSelectedPlayer = notSelectedPlayers.first;
            final reducedPlayers = [...players]..removeWhere(
                (player) =>
                    player == playerNotifier.value ||
                    otherPlayerNotifiers.any(
                      (element) => element.value == player,
                    ),
              );
            notSelectedPlayer.value = reducedPlayers.first;
          }
        }
      },
    );
  }
}
