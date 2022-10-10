import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

class AddPlayerDialog extends StatelessWidget {
  const AddPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text('Dodaj gracza'),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nazwa',
              ),
              onSubmitted: (value) {
                Navigator.of(context).pop(
                  value.isEmpty ? null : Player(name: value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
