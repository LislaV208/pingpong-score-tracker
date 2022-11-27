import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/matches_carousel.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/matches_table.dart';

class CircularTournamentView extends StatelessWidget {
  const CircularTournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MatchesTable(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: MatchesCarousel(),
        ),
        // SizedBox(height: 20),
      ],
    );
  }
}
