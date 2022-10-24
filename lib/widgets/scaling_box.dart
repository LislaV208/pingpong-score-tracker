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
