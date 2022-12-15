import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/matches_carousel.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/matches_table.dart';
import 'package:pingpong_score_tracker/utils/dev/colors.dart';

class CircularTournamentView extends StatelessWidget {
  const CircularTournamentView({
    super.key,
    required this.state,
    required this.matchesCarouselController,
  });

  final CircularTournamentState state;
  final CarouselController matchesCarouselController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MatchesTable(state: state),
        MatchesCarousel(
          controller: matchesCarouselController,
          state: state,
        ),
      ],
    );
  }
}
