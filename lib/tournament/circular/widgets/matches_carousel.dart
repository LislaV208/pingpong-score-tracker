import 'package:collection/collection.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/widgets/carousel_match_item.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';
import 'package:pingpong_score_tracker/utils/dev/colors.dart';
import 'package:pingpong_score_tracker/utils/dev/random_players.dart';

class MatchesCarousel extends StatefulWidget {
  const MatchesCarousel({super.key});

  @override
  State<MatchesCarousel> createState() => _MatchesCarouselState();
}

class _MatchesCarouselState extends State<MatchesCarousel> {
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mockMatches = List.generate(5, (index) {
      return TournamentMatch(player1: randomString(), player2: randomString());
    });
    const currentMatchIndex = 1;
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: mockMatches
              .mapIndexed(
                (index, match) => CarouselMatchItem(
                  match: match,
                  isCurrent: index == currentMatchIndex,
                  matchNumber: index + 1,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 60,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction: 0.35,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  carouselController.previousPage();
                },
                icon: Icon(Icons.navigate_before),
                splashRadius: 14.0,
              ),
              IconButton(
                onPressed: () {
                  carouselController.animateToPage(currentMatchIndex);
                },
                icon: Icon(Icons.restart_alt),
                splashRadius: 14.0,
              ),
              IconButton(
                onPressed: () {
                  carouselController.nextPage();
                },
                icon: Icon(Icons.navigate_next),
                splashRadius: 14.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
