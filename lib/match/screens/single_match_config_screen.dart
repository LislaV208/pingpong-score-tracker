import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/match_config_screen.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/player_dropdown_button/single_player_dropdown_button.dart';
import 'package:pingpong_score_tracker/match/widgets/single_serve_dialog.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';

class SingledMatchConfigScreen extends HookWidget {
  const SingledMatchConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leftPlayer = useState<String?>(null);
    final rightPlayer = useState<String?>(null);

    final players = context
        .select<PlayersCubit, List<String>>((cubit) => cubit.state.players);

    return MatchConfigScreen(
      matchScreenBuilder: (playerServing) => BlocProvider(
        create: (context) => SingleMatchCubit(
          SingleMatchState(
            leftPlayer: leftPlayer.value!,
            rightPlayer: rightPlayer.value!,
            playerServing: playerServing,
            currentPlayerServing: playerServing,
          ),
          historyCubit: getIt.get<MatchHistoryCubit>(),
        ),
        child: SingleMatchScreen(
          matchType: MatchType.single,
          onFinished: (navigator, _) {
            navigator.popUntil(
              ModalRoute.withName('/'),
            );
          },
        ),
      ),
      serveDialogBuilder: (context) => SingleServeDialog(
        leftPlayer: leftPlayer.value!,
        rightPlayer: rightPlayer.value!,
      ),
      leftChild: _PlayerChoice(
        title: 'Zawodnik z lewej strony:',
        players: players,
        playerNotifier: leftPlayer,
        otherPlayerNotifier: rightPlayer,
      ),
      rightChild: _PlayerChoice(
        title: 'Zawodnik z prawej strony:',
        players: players,
        playerNotifier: rightPlayer,
        otherPlayerNotifier: leftPlayer,
      ),
      selectRandomPlayers: () =>
          _selectRandomPlayers(leftPlayer, rightPlayer, players),
      swapTeams: leftPlayer.value == null && rightPlayer.value == null
          ? null
          : () => _swapPlayers(leftPlayer, rightPlayer),
      clearSelectedPlayers:
          leftPlayer.value != null || rightPlayer.value != null
              ? () {
                  leftPlayer.value = null;
                  rightPlayer.value = null;
                }
              : null,
      arePlayersSelected: leftPlayer.value != null && rightPlayer.value != null,
    );
  }

  void _selectRandomPlayers(
    ValueNotifier<String?> leftPlayer,
    ValueNotifier<String?> rightPlayer,
    List<String> players,
  ) {
    if (leftPlayer.value != null &&
        rightPlayer.value != null &&
        players.length == 2) {
      _swapPlayers(leftPlayer, rightPlayer);
    } else {
      var randomIndex = Random().nextInt(players.length);
      leftPlayer.value = players[randomIndex];

      final reducedPlayers = [...players]..removeWhere((element) =>
          element == leftPlayer.value || element == rightPlayer.value);

      randomIndex = Random().nextInt(reducedPlayers.length);
      rightPlayer.value = reducedPlayers[randomIndex];
    }
  }

  void _swapPlayers(
    ValueNotifier<String?> leftPlayer,
    ValueNotifier<String?> rightPlayer,
  ) {
    final temp = leftPlayer.value;
    leftPlayer.value = rightPlayer.value;
    rightPlayer.value = temp;
  }
}

class _PlayerChoice extends StatelessWidget {
  const _PlayerChoice({
    required this.title,
    required this.players,
    required this.playerNotifier,
    required this.otherPlayerNotifier,
  });

  final String title;
  final List<String> players;
  final ValueNotifier<String?> playerNotifier;
  final ValueNotifier<String?> otherPlayerNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        const SizedBox(height: 10.0),
        SinglePlayerDropdownButton(
          players: players,
          playerNotifier: playerNotifier,
          otherPlayerNotifier: otherPlayerNotifier,
        ),
      ],
    );
  }
}
