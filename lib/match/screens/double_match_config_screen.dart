import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';

import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_screen.dart';
import 'package:pingpong_score_tracker/match/screens/match_config_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/player_dropdown_button/double_player_dropdown_button.dart';
import 'package:pingpong_score_tracker/match/widgets/serve_dialog.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/utils/media_query_utils.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class DoubleMatchConfigScreen extends HookWidget {
  const DoubleMatchConfigScreen({super.key});

  static const route = 'double-match-config';

  @override
  Widget build(BuildContext context) {
    final leftTopPlayer = useState<String?>(null);
    final leftBottomPlayer = useState<String?>(null);
    final rightTopPlayer = useState<String?>(null);
    final rightBottomPlayer = useState<String?>(null);

    final players = context
        .select<PlayersCubit, List<String>>((cubit) => cubit.state.players);

    return MatchConfigScreen(
      centerFab: true,
      matchScreenBuilder: (playerServing) => BlocProvider(
        create: (context) => DoubleMatchCubit(
          DoubleMatchState(
            leftTeam: Team(
              topPlayer: leftTopPlayer.value!,
              bottomPlayer: leftBottomPlayer.value!,
            ),
            rightTeam: Team(
              topPlayer: rightTopPlayer.value!,
              bottomPlayer: rightBottomPlayer.value!,
            ),
            playerServingSet: playerServing,
            playerServingMatch: playerServing,
            currentPlayerServing: playerServing,
          ),
          historyCubit: context.read<MatchHistoryCubit>(),
          configurationCubit: context.read<ConfigurationCubit>(),
        ),
        child: const DoubleMatchScreen(),
      ),
      serveDialogBuilder: (context) => ServeDialog.double(
        leftTopPlayer: leftTopPlayer.value!,
        leftBottomPlayer: leftBottomPlayer.value!,
        rightTopPlayer: rightTopPlayer.value!,
        rightBottomPlayer: rightBottomPlayer.value!,
      ),
      leftChild: _SidePanel(
        players: players,
        topTitle: 'Zawodnik w lewym górnym rogu:',
        bottomTitle: 'Zawodnik w lewym dolnym rogu:',
        topPlayer: leftTopPlayer,
        topOtherPlayers: [
          leftBottomPlayer,
          rightTopPlayer,
          rightBottomPlayer,
        ],
        bottomPlayer: leftBottomPlayer,
        bottomOtherPlayers: [
          leftTopPlayer,
          rightTopPlayer,
          rightBottomPlayer,
        ],
        alignment: isWideScreen(context) ? null : Alignment.centerLeft,
      ),
      rightChild: _SidePanel(
        players: players,
        topTitle: 'Zawodnik w prawym górnym rogu:',
        bottomTitle: 'Zawodnik w prawym dolnym rogu:',
        topPlayer: rightTopPlayer,
        topOtherPlayers: [
          leftTopPlayer,
          leftBottomPlayer,
          rightBottomPlayer,
        ],
        bottomPlayer: rightBottomPlayer,
        bottomOtherPlayers: [
          leftTopPlayer,
          leftBottomPlayer,
          rightTopPlayer,
        ],
        alignment: isWideScreen(context) ? null : Alignment.centerRight,
      ),
      selectRandomPlayers: () => _selectRandomPlayers(
        players: players,
        leftTopPlayer: leftTopPlayer,
        leftBottomPlayer: leftBottomPlayer,
        rightTopPlayer: rightTopPlayer,
        rightBottomPlayer: rightBottomPlayer,
      ),
      swapTeams: leftTopPlayer.value != null ||
              leftBottomPlayer.value != null ||
              rightTopPlayer.value != null ||
              rightBottomPlayer.value != null
          ? () => _swapPlayers(
                leftTopPlayer,
                leftBottomPlayer,
                rightTopPlayer,
                rightBottomPlayer,
              )
          : null,
      clearSelectedPlayers: leftTopPlayer.value != null ||
              leftBottomPlayer.value != null ||
              rightTopPlayer.value != null ||
              rightBottomPlayer.value != null
          ? () {
              leftTopPlayer.value = null;
              leftBottomPlayer.value = null;
              rightTopPlayer.value = null;
              rightBottomPlayer.value = null;
            }
          : null,
      arePlayersSelected: leftTopPlayer.value != null &&
          leftBottomPlayer.value != null &&
          rightTopPlayer.value != null &&
          rightBottomPlayer.value != null,
    );
  }

  void _selectRandomPlayers({
    required List<String> players,
    required ValueNotifier<String?> leftTopPlayer,
    required ValueNotifier<String?> leftBottomPlayer,
    required ValueNotifier<String?> rightTopPlayer,
    required ValueNotifier<String?> rightBottomPlayer,
  }) {
    final selectedPlayers = <String>[];

    List<String> reducePlayers() {
      return [...players]..removeWhere(
          (element) => selectedPlayers.contains(element),
        );
    }

    var randomIndex = Random().nextInt(players.length);
    leftTopPlayer.value = players[randomIndex];
    selectedPlayers.add(players[randomIndex]);

    var availablePlayers = reducePlayers();
    randomIndex = Random().nextInt(availablePlayers.length);
    leftBottomPlayer.value = availablePlayers[randomIndex];
    selectedPlayers.add(availablePlayers[randomIndex]);

    availablePlayers = reducePlayers();
    randomIndex = Random().nextInt(availablePlayers.length);
    rightTopPlayer.value = availablePlayers[randomIndex];
    selectedPlayers.add(availablePlayers[randomIndex]);

    availablePlayers = reducePlayers();
    randomIndex = Random().nextInt(availablePlayers.length);
    rightBottomPlayer.value = availablePlayers[randomIndex];
    selectedPlayers.add(availablePlayers[randomIndex]);
  }

  void _swapPlayers(
    ValueNotifier<String?> leftTopPlayer,
    ValueNotifier<String?> leftBottomPlayer,
    ValueNotifier<String?> rightTopPlayer,
    ValueNotifier<String?> rightBottomPlayer,
  ) {
    final tempLeftTop = leftTopPlayer.value;
    leftTopPlayer.value = rightTopPlayer.value;
    rightTopPlayer.value = tempLeftTop;

    final tempLeftBottom = leftBottomPlayer.value;
    leftBottomPlayer.value = rightBottomPlayer.value;
    rightBottomPlayer.value = tempLeftBottom;
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({
    required this.players,
    required this.topTitle,
    required this.bottomTitle,
    required this.topPlayer,
    required this.topOtherPlayers,
    required this.bottomPlayer,
    required this.bottomOtherPlayers,
    this.alignment,
  });

  final List<String> players;
  final String topTitle;
  final String bottomTitle;
  final ValueNotifier<String?> topPlayer;
  final List<ValueNotifier<String?>> topOtherPlayers;
  final ValueNotifier<String?> bottomPlayer;
  final List<ValueNotifier<String?>> bottomOtherPlayers;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _PlayerChoice(
            title: topTitle,
            players: players,
            playerNotifier: topPlayer,
            otherPlayerNotifiers: topOtherPlayers,
          ),
          ElevatedCircleButton(
            onPressed: topPlayer.value != null || bottomPlayer.value != null
                ? () {
                    final temp = topPlayer.value;
                    topPlayer.value = bottomPlayer.value;
                    bottomPlayer.value = temp;
                  }
                : null,
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.compare_arrows),
            ),
            label: 'Zamień',
          ),
          _PlayerChoice(
            title: bottomTitle,
            players: players,
            playerNotifier: bottomPlayer,
            otherPlayerNotifiers: bottomOtherPlayers,
          ),
        ],
      ),
    );
  }
}

class _PlayerChoice extends StatelessWidget {
  const _PlayerChoice({
    required this.title,
    required this.players,
    required this.playerNotifier,
    required this.otherPlayerNotifiers,
  });

  final String title;
  final List<String> players;
  final ValueNotifier<String?> playerNotifier;
  final List<ValueNotifier<String?>> otherPlayerNotifiers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isWideScreen(context) ? null : 13.0,
          ),
        ),
        const SizedBox(height: 10.0),
        DoublePlayerDropdownButton(
          players: players,
          playerNotifier: playerNotifier,
          otherPlayerNotifiers: otherPlayerNotifiers,
        ),
      ],
    );
  }
}
