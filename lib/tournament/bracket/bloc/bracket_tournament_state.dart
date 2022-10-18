import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

part 'bracket_tournament_state.freezed.dart';
part 'bracket_tournament_state.g.dart';

@freezed
class BracketTournamentState with _$BracketTournamentState {
  const BracketTournamentState._();

  const factory BracketTournamentState({
    required List<TournamentMatch> matches,
    @Default(0) int matchesPlayedCount,
    @Default(0) int playersCount,
  }) = _BracketTournamentState;

  factory BracketTournamentState.notStarted() =>
      const BracketTournamentState(matches: []);

  factory BracketTournamentState.fromJson(Map<String, dynamic> json) =>
      _$BracketTournamentStateFromJson(json);

  factory BracketTournamentState.fromPlayersList(List<String> players) {
    players.shuffle();
    final matches = <TournamentMatch>[];

    for (var i = 0; i < players.length; i += 2) {
      final match =
          TournamentMatch(player1: players[i], player2: players[i + 1]);

      matches.add(match);
    }

    return BracketTournamentState(
      matches: matches,
      playersCount: players.length,
    );
  }

  bool get isFinished =>
      matches.isNotEmpty && matchesPlayedCount >= matches.length;
  TournamentMatch? get upcomingMatch =>
      matchesPlayedCount < matches.length ? matches[matchesPlayedCount] : null;
}
