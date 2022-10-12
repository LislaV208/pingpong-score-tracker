import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';
import 'package:pingpong_score_tracker/match/widgets/player_score.dart';

class TeamPointButton extends StatelessWidget {
  const TeamPointButton({
    super.key,
    required this.team,
    required this.currentPlayerServing,
    required this.setScore,
  });

  final Team team;
  final String currentPlayerServing;
  final int setScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        child: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0.05),
            child: InkWell(
              onTap: () {
                context.read<DoubleMatchCubit>().givePointToTeam(team);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayerName(
                    name: team.topPlayer,
                    isServing: currentPlayerServing == team.topPlayer,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: PlayerScore(score: setScore),
                  ),
                  PlayerName(
                    name: team.bottomPlayer,
                    isServing: currentPlayerServing == team.bottomPlayer,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
