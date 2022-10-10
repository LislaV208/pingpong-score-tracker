import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

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
      child: const Icon(Icons.restore, color: Colors.white),
    );
  }
}
