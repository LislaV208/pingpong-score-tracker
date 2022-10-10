import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class MatchFinishedDialog extends StatelessWidget {
  const MatchFinishedDialog({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
    required this.leftPlayerScore,
    required this.rightPlayerScore,
  });

  final Player leftPlayer;
  final Player rightPlayer;
  final int leftPlayerScore;
  final int rightPlayerScore;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ListTile(
            title: Text('Koniec gry!'),
          ),
          Text(
              'Wynik: ${leftPlayer.name} $leftPlayerScore : $rightPlayerScore ${rightPlayer.name}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Koniec'),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
