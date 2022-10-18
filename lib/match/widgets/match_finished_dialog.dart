import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';
import 'package:pingpong_score_tracker/widgets/colored_score.dart';

class MatchFinishedDialog extends StatelessWidget {
  const MatchFinishedDialog({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
    required this.leftScore,
    required this.rightScore,
    required this.undo,
  });

  final String leftPlayer;
  final String rightPlayer;
  final int leftScore;
  final int rightScore;
  final VoidCallback undo;

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
          ColoredScore(
            leftPlayer: leftPlayer,
            rightPlayer: rightPlayer,
            leftScore: leftScore,
            rightScore: rightScore,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: false,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Koniec'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Koniec'),
                ),
                UndoButton(
                  onPressed: () {
                    undo();
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
