import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_match.freezed.dart';

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

  String? get winner => player1Score > player2Score
      ? player1
      : player2Score > player1Score
          ? player2
          : null;

  String? get looser => player1 == winner
      ? player1
      : player2 == winner
          ? player2
          : null;
}
