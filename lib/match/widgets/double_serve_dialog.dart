import 'package:flutter/material.dart';

class DoubleServeDialog extends StatelessWidget {
  const DoubleServeDialog({
    super.key,
    required this.leftTopPlayer,
    required this.leftBottomPlayer,
    required this.rightTopPlayer,
    required this.rightBottomPlayer,
  });

  final String leftTopPlayer;
  final String leftBottomPlayer;
  final String rightTopPlayer;
  final String rightBottomPlayer;

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
                    child: Text(leftTopPlayer),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(rightTopPlayer);
                    },
                    child: Text(rightTopPlayer),
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
                    child: Text(leftBottomPlayer),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(rightBottomPlayer);
                    },
                    child: Text(rightBottomPlayer),
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
