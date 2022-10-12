import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class MatchHistoryListItem extends StatelessWidget {
  const MatchHistoryListItem({
    super.key,
    required this.entry,
  });

  final MatchHistoryEntry entry;

  bool _isWinner(int scoreLeft, int scoreRight) {
    return scoreLeft > scoreRight;
  }

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
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${entry.leftPlayer} ${entry.leftPlayerScore}',
                        style: TextStyle(
                          color: _isWinner(
                            entry.leftPlayerScore,
                            entry.rightPlayerScore,
                          )
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      TextSpan(text: ' : '),
                      TextSpan(
                        text: '${entry.rightPlayerScore} ${entry.rightPlayer}',
                        style: TextStyle(
                          color: _isWinner(
                                  entry.rightPlayerScore, entry.leftPlayerScore)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                DefaultTextStyle(
                  style: TextStyle(),
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
          child: Chip(
            label:
                Text(entry.matchType == MatchType.single ? 'Singiel' : 'Debel'),
            backgroundColor: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
