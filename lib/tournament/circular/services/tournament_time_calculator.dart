import 'package:pingpong_score_tracker/default_values.dart';

class TournamentTimeCalculator {
  const TournamentTimeCalculator({
    required this.matchesToPlayCount,
  });

  final int matchesToPlayCount;

  Duration calculate() {
    const timePerMatch = DefaultValues.approxTimePerMatch;
    final tournamentDuration = timePerMatch * matchesToPlayCount;
    return tournamentDuration;
  }
}
