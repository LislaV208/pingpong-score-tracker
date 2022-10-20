import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/app_button.dart';

class ServeDialog extends StatelessWidget {
  ServeDialog.single({
    super.key,
    required String leftPlayer,
    required String rightPlayer,
  }) : players = [leftPlayer, rightPlayer];

  ServeDialog.double({
    super.key,
    required String leftTopPlayer,
    required String rightTopPlayer,
    required String leftBottomPlayer,
    required String rightBottomPlayer,
  }) : players = [
          leftTopPlayer,
          rightTopPlayer,
          leftBottomPlayer,
          rightBottomPlayer
        ];

  static const leftPlayerIndex = 0;
  static const rightPlayerIndex = 1;

  static const leftTopPlayerIndex = 0;
  static const rightTopPlayerIndex = 1;
  static const leftBottomPlayerIndex = 2;
  static const rightBottomPlayerIndex = 3;

  final List<String> players;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: const Center(child: Text('Kto serwuje?')),
              tileColor: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: players.length == 2
                  ? _buildSingleButtons(context)
                  : players.length == 4
                      ? _buildDoubleButtons(context)
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleButtons(BuildContext context) {
    final leftPlayer = players[leftPlayerIndex];
    final rightPlayer = players[rightPlayerIndex];

    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppButton(
          onPressed: () {
            Navigator.of(context).pop(leftPlayer);
          },
          child: Text(leftPlayer),
        ),
        AppButton(
          onPressed: () {
            Navigator.of(context).pop(rightPlayer);
          },
          child: Text(rightPlayer),
        ),
      ],
    );
  }

  Widget _buildDoubleButtons(BuildContext context) {
    final leftTopPlayer = players[leftTopPlayerIndex];
    final rightTopPlayer = players[rightTopPlayerIndex];
    final leftBottomPlayer = players[leftBottomPlayerIndex];
    final rightBottomPlayer = players[rightBottomPlayerIndex];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              onPressed: () {
                Navigator.of(context).pop(leftTopPlayer);
              },
              child: Text(leftTopPlayer),
            ),
            const SizedBox(width: 16.0),
            AppButton(
              onPressed: () {
                Navigator.of(context).pop(rightTopPlayer);
              },
              child: Text(rightTopPlayer),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              onPressed: () {
                Navigator.of(context).pop(leftBottomPlayer);
              },
              child: Text(leftBottomPlayer),
            ),
            const SizedBox(width: 16.0),
            AppButton(
              onPressed: () {
                Navigator.of(context).pop(rightBottomPlayer);
              },
              child: Text(rightBottomPlayer),
            ),
          ],
        ),
      ],
    );
  }
}
