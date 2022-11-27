import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class CarouselMatchItem extends StatelessWidget {
  const CarouselMatchItem({
    super.key,
    required this.match,
    required this.isCurrent,
    required this.matchNumber,
  });

  final TournamentMatch match;
  final bool isCurrent;
  final int matchNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mecz $matchNumber'),
            const SizedBox(height: 4),
            Text(
              '${match.player1Score} ${match.player1} - ${match.player2} ${match.player2Score}',
              style: TextStyle(
                decoration:
                    isCurrent ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
