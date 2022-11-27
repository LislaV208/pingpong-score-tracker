import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

abstract class TournamentMatchGenerator<T> {
  // const TournamentMatchGenerator(List<T> players);

  List<TournamentMatch> generate();
}
