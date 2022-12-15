import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircularTournamentStorage with ChangeNotifier {
  late SharedPreferences _storage;

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  bool readIsTournamentStarted() {
    return _storage.getBool('isTournamentStarted') ?? false;
  }

  Future<void> writeTournamentStarted(bool value) async {
    await _storage.setBool('isTournamentStarted', value);

    notifyListeners();
  }

  List<TournamentMatch> readMatches() {
    final decodedMatches = _storage.getStringList('matches') ?? [];

    return decodedMatches
        .map((json) => TournamentMatch.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> writeMatches(List<TournamentMatch> matches) async {
    final encodedMatches =
        matches.map((match) => jsonEncode(match.toJson())).toList();
    _storage.setStringList('matches', encodedMatches);

    notifyListeners();
  }

  int readCurrentMatchIndex() {
    return _storage.getInt('currentMatchIndex') ?? 0;
  }

  Future<void> writeCurrentMatchIndex(int value) async {
    await _storage.setInt('currentMatchIndex', value);

    notifyListeners();
  }
}
