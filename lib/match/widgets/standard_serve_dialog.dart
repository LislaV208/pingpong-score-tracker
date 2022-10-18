import 'package:flutter/material.dart';

class StandardServeDialog extends StatelessWidget {
  const StandardServeDialog({
    super.key,
    required this.leftPlayer,
    required this.rightPlayer,
  });

  final String leftPlayer;
  final String rightPlayer;

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
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(leftPlayer);
                },
                child: Text(leftPlayer),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(rightPlayer);
                },
                child: Text(rightPlayer),
              ),
            ],
          )
        ],
      ),
    );
  }
}
