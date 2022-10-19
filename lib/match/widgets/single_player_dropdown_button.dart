import 'package:flutter/material.dart';

class SinglePlayerDropdownButton extends StatelessWidget {
  const SinglePlayerDropdownButton({
    super.key,
    required this.players,
    required this.playerNotifier,
    required this.otherPlayerNotifier,
  });

  final List<String> players;
  final ValueNotifier<String?> playerNotifier;
  final ValueNotifier<String?> otherPlayerNotifier;

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
          (element) => element.value == otherPlayerNotifier.value,
        ),
      onChanged: (value) {
        if (value != null) {
          playerNotifier.value = value;
          const minSinglePlayersNeeded = 2;

          if (players.length == minSinglePlayersNeeded) {
            if (otherPlayerNotifier.value == null) {
              final reducedPlayers = [...players]..remove(playerNotifier.value);
              otherPlayerNotifier.value = reducedPlayers.first;
            }
          }
        }
      },
    );
  }
}
