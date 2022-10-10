import 'package:flutter/material.dart';

class MatchScore extends StatelessWidget {
  const MatchScore({
    super.key,
    required this.teamLeft,
    required this.teamRight,
    required this.scoreLeft,
    required this.scoreRight,
  });

  final String teamLeft;
  final String teamRight;
  final int scoreLeft;
  final int scoreRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 4),
      child: Text(
        '$teamLeft $scoreLeft : $scoreRight $teamRight',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
