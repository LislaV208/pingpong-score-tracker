import 'package:flutter/material.dart';

class DevTestColors {
  static final devBackgroundColor = Colors.red.withOpacity(0.3);
}

class DevContainer extends StatelessWidget {
  const DevContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DevTestColors.devBackgroundColor,
      child: child,
    );
  }
}
