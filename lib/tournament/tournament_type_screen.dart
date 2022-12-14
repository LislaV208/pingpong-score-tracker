import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_players_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_players_screen.dart';

class TournamentTypeScreen extends StatelessWidget {
  const TournamentTypeScreen({super.key});

  static const route = 'tournament-type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz rodzaj turnieju'),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _goToBracketTournamentScreen(context),
                child: const Text('Turniej pucharowy'),
              ),
              const VerticalDivider(thickness: 3.0),
              ElevatedButton(
                onPressed: () => _goToCircularTournamentScreen(context),
                child: const Text(
                  'Turniej\nkażdy z każdym',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToBracketTournamentScreen(BuildContext context) {
    final tournamentState = context.read<BracketTournamentCubit>().state;
    final routeName = tournamentState == BracketTournamentState.notStarted()
        ? BracketTournamentPlayersScreen.route
        : BracketTournamentScreen.route;

    Navigator.of(context).pushNamed(routeName);
  }

  void _goToCircularTournamentScreen(BuildContext context) {
    // TODO: go to different route based on circural tournament state

    Navigator.of(context).pushNamed(CircularTournamentPlayersScreen.route);
  }
}
