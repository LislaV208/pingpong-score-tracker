import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
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
        _getLabel(context),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getLabel(BuildContext context) {
    final averageMatchDuration = _calculateAverageMatchDuration(context);

    final tournamentTimeCalculator = TournamentTimeCalculator(
      matchesToPlayCount: matchesToPlayCount,
      averageTimePerMatch: averageMatchDuration,
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

  Duration _calculateAverageMatchDuration(BuildContext context) {
    final matchHistory = context.read<MatchHistoryCubit>().state.history;

    final matchesDuration = matchHistory.map(
      (history) => history.finishedAt.difference(history.startedAt),
    );

    final averageMatchDuration = matchesDuration.isEmpty
        ? DefaultValues.approxTimePerMatch
        : matchesDuration.reduce((value, element) => value + element) ~/
            matchesDuration.length;

    return averageMatchDuration;
  }
}
