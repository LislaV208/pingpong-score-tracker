import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';
import 'package:pingpong_score_tracker/widgets/colored_score.dart';

class MatchHistoryListItem extends StatelessWidget {
  const MatchHistoryListItem({
    super.key,
    required this.entry,
  });

  final MatchHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final matchDuration = entry.finishedAt.difference(entry.startedAt);
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ColoredScore(
                  leftPlayer: entry.leftPlayer,
                  rightPlayer: entry.rightPlayer,
                  leftScore: entry.leftPlayerScore,
                  rightScore: entry.rightPlayerScore,
                ),
                const SizedBox(height: 10),
                DefaultTextStyle(
                  style: const TextStyle(),
                  textAlign: TextAlign.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Rozpoczęto:\n${dateFormat.format(entry.startedAt)}'),
                      Text(
                          'Czas trwania:\n${prettyDuration(matchDuration, locale: const PolishDurationLocale())}'),
                      Text(
                          'Zakończono:\n${dateFormat.format(entry.finishedAt)}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 5,
          top: -5,
          child: entry.matchType != MatchType.tournament
              ? Chip(
                  label: Text(entry.matchType == MatchType.single
                      ? 'Singiel'
                      : 'Debel'),
                  backgroundColor: Colors.blueGrey,
                )
              : const Chip(
                  avatar: Icon(Icons.emoji_events),
                  label: Text('Turniej'),
                  backgroundColor: Colors.orange,
                ),
        ),
      ],
    );
  }
}
