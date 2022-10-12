import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';
import 'package:pingpong_score_tracker/match/widgets/player_score.dart';

class PlayerPointButton extends StatelessWidget {
  const PlayerPointButton({
    super.key,
    required this.player,
    required this.currentPlayerServing,
    required this.setScore,
  });

  final String player;
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
                context.read<StandardMatchCubit>().givePointToPlayer(player);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayerName(
                    name: player,
                    isServing: currentPlayerServing == player,
                  ),
                  PlayerScore(score: setScore),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
