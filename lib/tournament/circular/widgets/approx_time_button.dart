import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/tournament_time_calculator.dart';

class ApproxTimeButton extends StatelessWidget {
  const ApproxTimeButton({
    super.key,
    required this.matchesToPlayCount,
  });

  final int matchesToPlayCount;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.timer),
      label: Text(
        _getLabel(),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getLabel() {
    final tournamentTimeCalculator = TournamentTimeCalculator(
      matchesToPlayCount: matchesToPlayCount,
    );
    final approxTime = tournamentTimeCalculator.calculate();

    final formattedApproxTime = prettyDuration(
      approxTime,
      abbreviated: true,
      delimiter: ' ',
      spacer: '',
    );

    return 'Szacowany czas: $formattedApproxTime';
  }
}
