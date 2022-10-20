import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';
import 'package:pingpong_score_tracker/widgets/app_button.dart';
import 'package:pingpong_score_tracker/widgets/app_dialog.dart';
import 'package:pingpong_score_tracker/widgets/colored_score.dart';
import 'package:pingpong_score_tracker/widgets/row_button_panel.dart';

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
    return AppDialog(
      title: 'Koniec gry',
      child: Column(
        children: [
          ColoredScore(
            leftPlayer: leftPlayer,
            rightPlayer: rightPlayer,
            leftScore: leftScore,
            rightScore: rightScore,
          ),
          const SizedBox(height: 20),
          RowButtonPanel(
            alignment: MainAxisAlignment.spaceBetween,
            buttons: [
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
              AppButton(
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
        ],
      ),
    );
  }
}
