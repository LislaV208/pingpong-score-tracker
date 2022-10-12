import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: Colors.blue, // <-- Button color
        disabledBackgroundColor: Colors.grey,
      ),
      child: const Icon(
        Icons.compare_arrows,
        color: Colors.white,
      ),
    );
  }
}
