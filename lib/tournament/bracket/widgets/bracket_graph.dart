import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class BracketGraph extends StatelessWidget {
  const BracketGraph({
    super.key,
    required this.players,
  });

  final List<String> players;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Center(
        child: BlocBuilder<BracketTournamentCubit, BracketTournamentState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._generateColumns(state),
                const Icon(
                  Icons.emoji_events,
                  size: 100,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _generateColumns(BracketTournamentState state) {
    final matches = state.matches;

    if (matches.isEmpty) return [];
    double logBase(num x, num base) => log(x) / log(base);
    double log2(num x) => logBase(x, 2);

    final columns = List.generate(
      log2(players.length).toInt(),
      (indexOut) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            matches.length ~/ (pow(2, indexOut)).toInt(),
            (indexIn) {
              final sum = indexOut * matches.length;
              final index = sum + indexIn;
              return MatchContainer(
                match: index < matches.length
                    ? matches[index]
                    : TournamentMatch.empty(),
                isCurrent: state.matchesPlayedCount == index,
              );
            },
          ),
        );
      },
    );

    return columns;
  }
}

class MatchContainer extends StatelessWidget {
  const MatchContainer({
    super.key,
    required this.match,
    required this.isCurrent,
  });

  final TournamentMatch match;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final player1 = match.player1.isEmpty ? '???' : match.player1;
    final player2 = match.player2.isEmpty ? '???' : match.player2;
    final score1 = match.player1.isEmpty ? '' : match.player1Score;
    final score2 = match.player2.isEmpty ? '' : match.player2Score;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          color: isCurrent ? Colors.blueGrey : Colors.blueGrey.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        height: 50,
        width: 150,
        child: Text('$player1 $score1 : $score2 $player2'),
      ),
    );
  }
}
