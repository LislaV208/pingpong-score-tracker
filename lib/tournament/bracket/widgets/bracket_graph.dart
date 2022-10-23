import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';
import 'package:pingpong_score_tracker/widgets/scaling_box.dart';

class BracketGraph extends StatelessWidget {
  const BracketGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final size = _calculateSize(context);
    print(size);

    final content = BlocBuilder<BracketTournamentCubit, BracketTournamentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ..._generateColumns(state),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: state.isFinished ? Colors.amber : null,
                  ),
                  if (state.isFinished) Text(state.matches.last.winner!),
                ],
              ),
            ),
          ],
        );
      },
    );

    final playersCount =
        context.read<BracketTournamentCubit>().state.playersCount;
    final useScalingBox = playersCount > 4;
    final useInteractiveViewer = playersCount > 8;

    return useScalingBox
        ? ScalingBox(
            size: _calculateSize(context),
            child: useInteractiveViewer
                ? InteractiveViewer(child: content)
                : content,
          )
        : Center(child: content);
  }

  List<Widget> _generateColumns(BracketTournamentState state) {
    final matches = state.matches;
    final playersCount = state.playersCount;

    if (matches.isEmpty) return [];
    double logBase(num x, num base) => log(x) / log(base);
    double log2(num x) => logBase(x, 2);

    var matchesGeneratedCount = 0;

    final columns = List.generate(
      log2(playersCount).toInt(),
      (indexOut) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            (playersCount / 2) ~/ (pow(2, indexOut)).toInt(),
            (indexIn) {
              final index = matchesGeneratedCount;
              matchesGeneratedCount++;

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

  Size _calculateSize(BuildContext context) {
    final playersCount =
        context.read<BracketTournamentCubit>().state.playersCount;

    // probably it can be calculated dynamically
    if (playersCount == 4) {
      return const Size(600, 300);
    } else if (playersCount == 8) {
      return const Size(800, 300);
    }

    return const Size(600, 1600);
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
    final score1 = match.player1.isEmpty ? '' : match.player1Score.toString();
    final score2 = match.player2.isEmpty ? '' : match.player2Score.toString();

    TextStyle getScoreStyle(int scoreLeft, int scoreRight) {
      if (scoreLeft > scoreRight) {
        return const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        );
      }

      return const TextStyle();
    }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '$player1 $score1',
                    style:
                        getScoreStyle(match.player1Score, match.player2Score),
                  ),
                  const TextSpan(
                    text: ' : ',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: '$score2 $player2',
                    style:
                        getScoreStyle(match.player2Score, match.player1Score),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
