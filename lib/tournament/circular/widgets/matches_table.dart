import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/utils/dev/colors.dart';
import 'package:pingpong_score_tracker/utils/dev/random_players.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

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
    return CustomPaint(
      painter: _MatchesPlayersCellPainter(),
      // size: Size(100, 50),
      child: SizedBox(
        width: 100,
        height: 36,
        // child: Text('elo morelo joł'),
      ),
    );
  }
}

class MatchesTable extends HookWidget {
  const MatchesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollControler = useScrollController();
    final mockPlayers = generateRandomPlayers(12, maxCharacters: 8);
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
      height: 180,
      // margin: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
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
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: mockPlayers.mapIndexed((index, player) {
                      return Row(
                        children: [
                          // if (index == 0) verticalDivider,
                          SizedBox(
                            width: 100.0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  // border: Border(bottom: BorderSide()),
                                  ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _TableCell(
                                    label: player,
                                    // border: Border(bottom: BorderSide()),
                                  ),
                                  horizontalDivider,
                                  _TableCell(label: '0'),
                                  horizontalDivider,
                                  _TableCell(label: '0'),
                                  horizontalDivider,
                                  _TableCell(label: '0'),
                                ],
                              ),
                            ),
                          ),
                          if (index < mockPlayers.length - 1) verticalDivider,
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

    // return Table(
    //   border: TableBorder(
    //     horizontalInside: BorderSide(),
    //     verticalInside: BorderSide(),
    //   ),
    //   children: [
    //     TableRow(
    //       children: [
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             // first locked column items
    //           ],
    //         ),
    //         SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Row(
    //                 children: <Widget>[
    //                   // table header items
    //                 ],
    //               ),
    //               Row(
    //                 children: <Widget>[
    //                   // data cells
    //                 ],
    //               ),
    //               Row(
    //                 children: <Widget>[
    //                   // data cells
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         //   const TableCell(
    //         //     child: Text(''),
    //         //   ),
    //         //   ...mockPlayers
    //         //       .map(
    //         //         (player) => TableCell(
    //         //           child: Text(
    //         //             player,
    //         //             textAlign: TextAlign.center,
    //         //           ),
    //         //         ),
    //         //       )
    //         //       .toList(),
    //       ],
    //     ),
    //     TableRow(
    //       children: [
    //         TableCell(
    //           child: Text(
    //             'Rozegrane mecze',
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //         ...mockPlayers
    //             .map(
    //               (_) => TableCell(
    //                 child: Text(
    //                   '0',
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //             )
    //             .toList(),
    //       ],
    //     ),
    //   ],
    // );
  }
}
