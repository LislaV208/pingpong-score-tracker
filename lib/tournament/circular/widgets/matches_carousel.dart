import 'package:collection/collection.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/carousel_match_item.dart';

class MatchesCarousel extends StatelessWidget {
  const MatchesCarousel({
    super.key,
    required this.state,
    required this.controller,
  });

  final CarouselController controller;
  final CircularTournamentState state;

  @override
  Widget build(BuildContext context) {
    final matches = state.matches;
    final currentMatchIndex = state.currentMatchIndex;
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller,
          items: matches
              .mapIndexed(
                (index, match) => CarouselMatchItem(
                  match: match,
                  isCurrent: index == currentMatchIndex,
                  matchNumber: index + 1,
                ),
              )
              .toList(),
          options: CarouselOptions(
            aspectRatio: 15,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction: 0.35,
          ),
        ),
        ButtonBar(
          buttonPadding: const EdgeInsets.all(1),
          alignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage();
              },
              icon: const Icon(Icons.navigate_before),
              splashRadius: 14.0,
            ),
            IconButton(
              onPressed: () {
                controller.animateToPage(currentMatchIndex);
              },
              icon: const Icon(Icons.restart_alt),
              splashRadius: 14.0,
            ),
            IconButton(
              onPressed: () {
                controller.nextPage();
              },
              icon: const Icon(Icons.navigate_next),
              splashRadius: 14.0,
            ),
          ],
        ),
      ],
    );
  }
}
