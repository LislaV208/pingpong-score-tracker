import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class CircularTournamentState with ChangeNotifier {
  CircularTournamentState(List<TournamentMatch> matches) : _matches = matches;

  late final List<TournamentMatch> _matches;
  List<TournamentMatch> get matches => [..._matches];

  var _currentMatchIndex = 0;
  int get currentMatchIndex => _currentMatchIndex;
  TournamentMatch get currentMatch => _matches[_currentMatchIndex];

  var _isFinished = false;
  bool get isFinished => _isFinished;

  void onMatchFinished(TournamentMatch match) {
    _matches[_currentMatchIndex] = match;
    if (_currentMatchIndex < _matches.length - 1) {
      _currentMatchIndex++;
    } else {
      _isFinished = true;
    }

    notifyListeners();
  }

  int getPlayerPlayedMatchesCount(String player) {
    return _getPlayerMatchesCount(
      (match) => match.hasPlayerPlayed(player),
    );
  }

  int getPlayerWonMatchesCount(String player) {
    return _getPlayerMatchesCount((match) => match.winner == player);
  }

  int getPlayerLostMatchesCount(String player) {
    return _getPlayerMatchesCount((match) => match.looser == player);
  }

  int _getPlayerMatchesCount(bool Function(TournamentMatch match) predicate) {
    return _matches.fold<int>(
      0,
      (previousValue, match) =>
          predicate(match) ? previousValue + 1 : previousValue,
    );
  }
}
