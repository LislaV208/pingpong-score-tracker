import 'package:flutter/material.dart';

class ScalingBox extends StatelessWidget {
  const ScalingBox({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 16 players
    double logicHeight = 600;
    double logicWidth = 1600;

    // 8 players
    // double logicHeight = 300;
    // double logicWidth = 800;

    // 4 players
    // double logicHeight = 300;
    // double logicWidth = 700;
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: child,
        ),
      ),
    );
  }
}
