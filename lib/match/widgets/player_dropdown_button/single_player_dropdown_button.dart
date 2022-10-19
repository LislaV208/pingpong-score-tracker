import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/match/widgets/player_dropdown_button/player_dropdown_button.dart';

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
    return PlayerDropdownButton(
      players: players,
      playerNotifier: playerNotifier,
      removeOtherPlayersPredicate: (item) =>
          item.value == otherPlayerNotifier.value,
      setOtherPlayersOnChange: () {
        const minSinglePlayersNeeded = 2;

        if (players.length == minSinglePlayersNeeded) {
          if (otherPlayerNotifier.value == null) {
            final reducedPlayers = [...players]..remove(playerNotifier.value);
            otherPlayerNotifier.value = reducedPlayers.first;
          }
        }
      },
    );
  }
}
