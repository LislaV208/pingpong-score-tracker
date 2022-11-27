import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class CircularTournamentState with ChangeNotifier {
  CircularTournamentState(List<String> players) {
    
  }

  late final List<TournamentMatch> _matches;
}
