import 'package:pingpong_score_tracker/tournament/circular/services/berger_table_generator.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';
import 'package:pingpong_score_tracker/tournament/tournament_match_generator.dart';

class CircularTournamentMatchGenerator implements TournamentMatchGenerator {
  const CircularTournamentMatchGenerator(this.bergerTableGenerator);

  final BergerTableGenerator<String> bergerTableGenerator;

  @override
  List<TournamentMatch> generate() {
    final matches = bergerTableGenerator.generate();

    return matches
        .map(
          (e) => TournamentMatch(player1: e.leftPlayer, player2: e.rightPlayer),
        )
        .toList();
  }
}
