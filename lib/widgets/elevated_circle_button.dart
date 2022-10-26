import 'package:flutter/material.dart';

class ElevatedCircleButton extends StatelessWidget {
  const ElevatedCircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.color = Colors.blue,
    this.padding = 10.0,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;
  final Color color;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(padding),
        backgroundColor: color,
        disabledBackgroundColor: Colors.grey,
      ),
      child: label == null
          ? icon
          : Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(
                    label!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
    );
  }
}
