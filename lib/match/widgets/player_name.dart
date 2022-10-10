import 'package:flutter/material.dart';

class PlayerName extends StatelessWidget {
  const PlayerName({
    super.key,
    required this.name,
    required this.isServing,
  });

  final String name;
  final bool isServing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 26),
        ),
        if (isServing)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.sports_cricket),
          ),
      ],
    );
    ;
  }
}
