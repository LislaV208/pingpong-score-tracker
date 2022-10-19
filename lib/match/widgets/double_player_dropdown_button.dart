import 'package:flutter/material.dart';

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
    return DropdownButton<String>(
      value: playerNotifier.value,
      items: players
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList()
        ..removeWhere(
          (buttonItem) => otherPlayerNotifiers
              .any((otherPlayer) => otherPlayer.value == buttonItem.value),
        ),
      onChanged: (value) {
        if (value != null) {
          playerNotifier.value = value;
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
        }
      },
    );
  }
}
