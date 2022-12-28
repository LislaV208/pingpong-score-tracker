import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_players_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_players_screen.dart';
import 'package:pingpong_score_tracker/widgets/app_button.dart';
import 'package:pingpong_score_tracker/widgets/app_dialog.dart';

class TournamentTypeDialog extends StatelessWidget {
  const TournamentTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Wybierz rodzaj turnieju',
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppButton(
            onPressed: () {
              Navigator.of(context).pop(BracketTournamentPlayersScreen.route);
            },
            child: const Text(
              'Turniej\npucharowy',
              textAlign: TextAlign.center,
            ),
          ),
          AppButton(
            onPressed: () {
              Navigator.of(context).pop(CircularTournamentPlayersScreen.route);
            },
            child: const Text(
              'Turniej\n"każdy z każdym"',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
