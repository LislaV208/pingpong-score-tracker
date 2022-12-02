import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';

class _TableCell extends StatelessWidget {
  const _TableCell({
    required this.label,
    this.border,
  });

  final String label;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        // height: 40,
        decoration: BoxDecoration(
          // color: DevTestColors.devBackgroundColor,
          // border: Border.all(),
          border: border,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _MatchesPlayersCellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    // ..strokeWidth = 2.0;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
  }

  // void paint(Canvas canvas, Size size) {
  //   var center = size / 2;
  //   var paint = Paint()
  //     ..color = Colors.white
  //     ..strokeWidth = 10.0;

  //   canvas.drawLine(
  //       Offset(0, center.height), Offset(size.width, center.height), paint);
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class _MatchesPlayersCell extends StatelessWidget {
  const _MatchesPlayersCell();

  @override
  Widget build(BuildContext context) {
    return _TableCell(label: 'Mecze / Gracze');
    // return CustomPaint(
    //   painter: _MatchesPlayersCellPainter(),
    //   // size: Size(100, 50),
    //   child: SizedBox(
    //     width: 100,
    //     height: 36,
    //     // child: Text('elo morelo joł'),
    //   ),
    // );
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

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MatchesPlayersCell(),
                horizontalDivider,
                ...rowHeaders
                    .mapIndexed(
                      (index, header) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TableCell(label: header),
                          if (index < rowHeaders.length - 1) horizontalDivider,
                        ],
                      ),
                    )
                    .toList(),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          verticalDivider,
          Expanded(
            child: Scrollbar(
              controller: scrollControler,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollControler,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: players.mapIndexed((index, player) {
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
                                        '${state.getPlayerPlayedMatchesCount(player)}'),
                                horizontalDivider,
                                _TableCell(
                                    label:
                                        '${state.getPlayerWonMatchesCount(player)}'),
                                horizontalDivider,
                                _TableCell(
                                    label:
                                        '${state.getPlayerLostMatchesCount(player)}'),
                              ],
                            ),
                          ),
                          if (index < players.length - 1) verticalDivider,
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
