import 'package:flutter/material.dart';

class PlayerScore extends StatelessWidget {
  const PlayerScore({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$score',
      style: const TextStyle(
        fontSize: 26,
      ),
    );
  }
}
