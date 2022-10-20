import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';

class EndMatchDialog extends StatelessWidget {
  const EndMatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecisionDialog(
      title: 'Czy chcesz zakończyć mecz?',
    );
  }
}
