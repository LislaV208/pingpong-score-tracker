import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class DoubleServeDialog extends StatelessWidget {
  const DoubleServeDialog({
    super.key,
    required this.leftTopPlayer,
    required this.leftBottomPlayer,
    required this.rightTopPlayer,
    required this.rightBottomPlayer,
  });

  final Player leftTopPlayer;
  final Player leftBottomPlayer;
  final Player rightTopPlayer;
  final Player rightBottomPlayer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const ListTile(
            title: Text('Kto serwuje?'),
          ),
          Column(
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(leftTopPlayer);
                    },
                    child: Text(leftTopPlayer.name),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(rightTopPlayer);
                    },
                    child: Text(rightTopPlayer.name),
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(leftBottomPlayer);
                    },
                    child: Text(leftBottomPlayer.name),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(rightBottomPlayer);
                    },
                    child: Text(rightBottomPlayer.name),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
