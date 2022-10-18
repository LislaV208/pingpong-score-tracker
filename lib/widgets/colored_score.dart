import 'package:flutter/material.dart';

class ColoredScore extends StatelessWidget {
  const ColoredScore({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
    required this.leftScore,
    required this.rightScore,
  });

  final String leftPlayer;
  final String rightPlayer;
  final int leftScore;
  final int rightScore;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: '$leftPlayer $leftScore',
            style: TextStyle(
              color: _isWinner(
                leftScore,
                rightScore,
              )
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          const TextSpan(text: ' : '),
          TextSpan(
            text: '$rightScore $rightPlayer',
            style: TextStyle(
              color:
                  _isWinner(rightScore, leftScore) ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  bool _isWinner(int scoreLeft, int scoreRight) {
    return scoreLeft > scoreRight;
  }
}
