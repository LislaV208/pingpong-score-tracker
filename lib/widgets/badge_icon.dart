import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon(
    this.icon, {
    super.key,
    this.badgeText,
  });

  final IconData icon;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          size: 50.0,
        ),
        Positioned(
          top: 1,
          right: 3,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            width: 10.0,
            height: 10.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            child: badgeText != null
                ? FittedBox(
                    child: Text(badgeText!),
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
