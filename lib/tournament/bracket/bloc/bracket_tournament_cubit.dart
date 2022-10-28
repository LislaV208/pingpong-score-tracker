import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class BracketTournamentCubit extends HydratedCubit<BracketTournamentState> {
  BracketTournamentCubit() : super(BracketTournamentState.notStarted());

  @override
  BracketTournamentState? fromJson(Map<String, dynamic> json) =>
      BracketTournamentState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(BracketTournamentState state) => state.toJson();

  void start(List<String> players) {
    emit(BracketTournamentState.fromPlayersList(players));
  }

  void onMatchFinished(int score1, int score2) {
    final matchesPlayedCount = state.matchesPlayedCount;
    final match = state.matches[matchesPlayedCount].copyWith();

    // swap scores if players finished swapped
    if ((score1 + score2) % 2 == 0) {
      final temp = score1;
      score1 = score2;
      score2 = temp;
    }

    final updatedMatch = TournamentMatch(
      player1: match.player1,
      player2: match.player2,
      player1Score: score1,
      player2Score: score2,
    );

    final matches = [...state.matches];
    matches[matchesPlayedCount] = updatedMatch;

    final updatedMatchesPlayedCount = matchesPlayedCount + 1;

    if (updatedMatchesPlayedCount < matches.length) {
      if (updatedMatch.hasWinner) {
        // if is odd
        if (updatedMatchesPlayedCount % 2 == 1) {
          matches.add(
            TournamentMatch(player1: updatedMatch.winner!, player2: ''),
          );
        } else {
          final lastMatch =
              matches.last.copyWith(player2: updatedMatch.winner!);
          matches.last = lastMatch;
        }
      }
    }

    emit(state.copyWith(
      matches: matches,
      matchesPlayedCount: updatedMatchesPlayedCount,
    ));
  }

  void setToNotStarted() {
    emit(BracketTournamentState.notStarted());
  }
}
