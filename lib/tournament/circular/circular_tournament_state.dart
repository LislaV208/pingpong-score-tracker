import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_storage.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class CircularTournamentState with ChangeNotifier {
  CircularTournamentState(
    this.storage,
    List<TournamentMatch> matches, [
    int? currentMatchIndex,
  ])  : _matches = matches,
        _currentMatchIndex = currentMatchIndex ?? 0;

  final CircularTournamentStorage storage;

  late final List<TournamentMatch> _matches;
  var _currentMatchIndex = 0;
  var _isFinished = false;

  List<TournamentMatch> get matches => [..._matches];
  int get currentMatchIndex => _currentMatchIndex;
  TournamentMatch get currentMatch => _matches[_currentMatchIndex];
  bool get isFinished => _isFinished;

  void onMatchFinished(TournamentMatch match) {
    _matches[_currentMatchIndex] = match;
    if (_currentMatchIndex < _matches.length - 1) {
      _currentMatchIndex++;

      storage.writeMatches(_matches);
      storage.writeCurrentMatchIndex(_currentMatchIndex);
    } else {
      _isFinished = true;

      storage.writeMatches([]);
      storage.writeCurrentMatchIndex(0);
      storage.writeTournamentStarted(false);
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
