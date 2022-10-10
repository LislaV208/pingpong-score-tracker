import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class StandardServeDialog extends StatelessWidget {
  const StandardServeDialog({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
  });

  final Player leftPlayer;
  final Player rightPlayer;

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
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(leftPlayer);
                },
                child: Text(leftPlayer.name),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(rightPlayer);
                },
                child: Text(rightPlayer.name),
              ),
            ],
          )
        ],
      ),
    );
  }
}
