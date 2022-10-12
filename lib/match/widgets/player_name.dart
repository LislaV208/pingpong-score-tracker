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
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 26),
        ),
        if (isServing)
          const Positioned(
            top: -30,
            child: Icon(Icons.sports_cricket),
          ),
      ],
    );
    ;
  }
}
