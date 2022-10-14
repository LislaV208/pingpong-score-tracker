import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/bracket_graph.dart';

class BracketTournamentScreen extends StatelessWidget {
  const BracketTournamentScreen({
    super.key,
    required this.players,
  });

  final List<String> players;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Turniej')),
      body: SafeArea(
        child: BracketGraph(players: players),
      ),
    );
  }
}
