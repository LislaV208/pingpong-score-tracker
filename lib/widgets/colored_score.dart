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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                leftPlayer,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isWinner(
                        leftScore,
                        rightScore,
                      )
                          ? Colors.green
                          : Colors.red,
                    ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: ' $leftScore',
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
                  text: '$rightScore ',
                  style: TextStyle(
                    color: _isWinner(rightScore, leftScore)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                rightPlayer,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isWinner(
                        rightScore,
                        leftScore,
                      )
                          ? Colors.green
                          : Colors.red,
                    ),
                textAlign: TextAlign.start,
              ),
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
