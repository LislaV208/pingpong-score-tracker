import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

part 'bracket_tournament_state.freezed.dart';

@freezed
class BracketTournamentState with _$BracketTournamentState {
  const BracketTournamentState._();

  const factory BracketTournamentState({
    required List<TournamentMatch> matches,
    @Default(0) int matchesPlayedCount,
  }) = _BracketTournamentState;

  factory BracketTournamentState.fromPlayersList(List<String> players) {
    players.shuffle();
    final matches = <TournamentMatch>[];

    for (var i = 0; i < players.length; i += 2) {
      final match =
          TournamentMatch(player1: players[i], player2: players[i + 1]);

      matches.add(match);
    }

    return BracketTournamentState(matches: matches);
  }

  bool get isFinished => matchesPlayedCount >= matches.length;
  TournamentMatch? get upcomingMatch =>
      matchesPlayedCount < matches.length ? matches[matchesPlayedCount] : null;
}
