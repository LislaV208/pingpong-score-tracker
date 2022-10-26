import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class IncrementDecrementValue extends StatelessWidget {
  const IncrementDecrementValue({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          ElevatedCircleButton(
            onPressed: onDecrement,
            icon: const Text(
              '-',
              style: TextStyle(fontSize: fontSize),
            ),
            padding: 0.0,
          ),
          Expanded(
            child: Text(
              '$value',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedCircleButton(
            onPressed: onIncrement,
            icon: const Text(
              '+',
              style: TextStyle(fontSize: fontSize),
            ),
            padding: 0.0,
          ),
        ],
      ),
    );
  }
}
