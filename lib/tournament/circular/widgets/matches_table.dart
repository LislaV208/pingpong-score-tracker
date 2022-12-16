import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';

class _TableCell extends StatelessWidget {
  const _TableCell({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: FittedBox(
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _MatchesPlayersCell extends StatelessWidget {
  const _MatchesPlayersCell();

  @override
  Widget build(BuildContext context) {
    return const _TableCell(label: 'Mecze / Gracze');
  }
}

class MatchesTable extends HookWidget {
  const MatchesTable({
    super.key,
    required this.state,
  });

  final CircularTournamentState state;

  @override
  Widget build(BuildContext context) {
    final scrollControler = useScrollController();
    final players = state.matches
        .expand<String>((match) => [match.player1, match.player2])
        .toSet()
        .toList();

    final rowHeaders = ['Rozegrane', 'Wygrane', 'Przegrane'];

    const horizontalDivider = Divider(
      height: 0.0,
      thickness: 1.0,
    );

    const verticalDivider = VerticalDivider(
      width: 0.0,
      thickness: 1.0,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 184 + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: IntrinsicWidth(
              child: Column(
                children: [
                  const _MatchesPlayersCell(),
                  horizontalDivider,
                  ...rowHeaders
                      .mapIndexed(
                        (index, header) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _TableCell(label: header),
                            if (index < rowHeaders.length - 1)
                              horizontalDivider,
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: verticalDivider,
          ),
          Flexible(
            child: Scrollbar(
              controller: scrollControler,
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListView(
                  controller: scrollControler,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Row(
                      children: players.mapIndexed(
                        (index, player) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _TableCell(
                                      label: player,
                                    ),
                                    horizontalDivider,
                                    _TableCell(
                                      label:
                                          '${state.getPlayerPlayedMatchesCount(player)}',
                                    ),
                                    horizontalDivider,
                                    _TableCell(
                                      label:
                                          '${state.getPlayerWonMatchesCount(player)}',
                                    ),
                                    horizontalDivider,
                                    _TableCell(
                                      label:
                                          '${state.getPlayerLostMatchesCount(player)}',
                                    ),
                                  ],
                                ),
                              ),
                              if (index < players.length - 1) verticalDivider,
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
