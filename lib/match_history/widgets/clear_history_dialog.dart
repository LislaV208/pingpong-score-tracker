import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';

class ClearHistoryDialog extends StatelessWidget {
  const ClearHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecisionDialog(
      title: 'Czy na pewno chcesz wyczyścić historię meczy?',
    );
  }
}
