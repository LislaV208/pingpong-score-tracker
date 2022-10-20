import 'package:flutter/material.dart';

class MatchScore extends StatelessWidget {
  const MatchScore({
    super.key,
    required this.scoreLeft,
    required this.scoreRight,
  });

  final int scoreLeft;
  final int scoreRight;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $scoreLeft : $scoreRight ',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
