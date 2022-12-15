import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_match.freezed.dart';
part 'tournament_match.g.dart';

@freezed
class TournamentMatch with _$TournamentMatch {
  const TournamentMatch._();
  const factory TournamentMatch({
    required String player1,
    required String player2,
    @Default(0) int player1Score,
    @Default(0) int player2Score,
  }) = _TournamentMatch;

  factory TournamentMatch.empty() =>
      const TournamentMatch(player1: '', player2: '');

  bool get hasWinner => player1Score > 0 || player2Score > 0;

  String? get winner => player1Score > player2Score
      ? player1
      : player2Score > player1Score
          ? player2
          : null;

  String? get looser => player1 == winner
      ? player2
      : player2 == winner
          ? player1
          : null;

  int? get winnerScore => player1 == winner
      ? player1Score
      : player2 == winner
          ? player2Score
          : null;

  int? get looserScore => player1 == looser
      ? player1Score
      : player2 == looser
          ? player2Score
          : null;

  bool havePlayer(String player) => player1 == player || player2 == player;
  int? playerScore(String player) {
    if (!havePlayer(player)) return null;

    return player1 == player ? player1Score : player2Score;
  }

  bool hasPlayerPlayed(String player) {
    if (!havePlayer(player)) return false;

    return player1Score > 0 || player2Score > 0;
  }

  factory TournamentMatch.fromJson(Map<String, dynamic> json) =>
      _$TournamentMatchFromJson(json);
}
