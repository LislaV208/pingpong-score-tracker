import 'package:flutter/material.dart';

class RowButtonPanel extends StatelessWidget {
  const RowButtonPanel({
    super.key,
    required this.buttons,
    this.spacing = 20.0,
    this.alignment = MainAxisAlignment.center,
  });

  final List<Widget> buttons;
  final double spacing;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: buttons.isEmpty
          ? []
          : List.generate(
              buttons.length * 2 - 1,
              (index) =>
                  index.isEven ? buttons[index ~/ 2] : SizedBox(width: spacing),
            ),
    );
  }
}
