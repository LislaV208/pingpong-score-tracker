import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/decision_dialog.dart';

class ExitTournamentDialog extends StatelessWidget {
  const ExitTournamentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecisionDialog(
      title: 'Czy chcesz anulować turniej?',
    );
  }
}
