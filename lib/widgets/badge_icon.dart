import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon(
    this.icon, {
    super.key,
    required this.badgeText,
  });

  final IconData icon;
  final String badgeText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            width: 9.0,
            height: 9.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            child: FittedBox(
              child: Text(badgeText),
            ),
          ),
        ),
      ],
    );
  }
}
