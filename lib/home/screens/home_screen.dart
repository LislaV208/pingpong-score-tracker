import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/ads/banner_ad_view.dart';
import 'package:pingpong_score_tracker/configuration/screens/configuration_screen.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_config_screen.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_config_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/tournament_type_dialog.dart';
import 'package:pingpong_score_tracker/match_history/screens/match_history_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/match_type_dialog.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_storage.dart';
import 'package:pingpong_score_tracker/widgets/badge_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      Platform.isAndroid
          ? DeviceOrientation.landscapeLeft
          : DeviceOrientation.landscapeRight
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final ratio = width / height;

    log('Width: $width');
    log('Height: $height');
    log('Screen ratio: $ratio');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekran główny'),
        actions: [
          IconButton(
            onPressed: () => _onConfigurationPressed(context),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) return const SizedBox();

        return BannerAdView(
          child: Center(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _HomeScreenButton(
                            onPressed: _onStartMatchPressed(context),
                            icon: Icons.sports_cricket,
                            label: 'Rozpocznij mecz',
                            backgroundColor: Colors.green[700],
                          ),
                          _HomeTournamentButton(
                            onPressed: () => _onTournamentPressed(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _HomeScreenButton(
                            onPressed: () => _onManagePlayersPressed(context),
                            leading:
                                BlocSelector<PlayersCubit, PlayersState, int>(
                              selector: (state) => state.players.length,
                              builder: (context, playersCount) =>
                                  _PlayersIcon(playersCount: playersCount),
                            ),
                            label: 'Zarządzaj graczami',
                            backgroundColor: Colors.blue[700],
                          ),
                          _HomeScreenButton(
                            onPressed: () => _onMatchHistoryPressed(context),
                            icon: Icons.restore,
                            label: 'Historia meczy',
                            backgroundColor: Colors.blueGrey[700],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  VoidCallback? _onStartMatchPressed(BuildContext context) {
    return context.select<PlayersCubit, int>(
                (value) => value.state.players.length) <
            2
        ? null
        : () async {
            final navigator = Navigator.of(context);
            final matchType = await showDialog<MatchType?>(
              context: context,
              builder: (context) => const MatchTypeDialog(),
            );
            if (matchType != null) {
              navigator.pushNamed(
                matchType == MatchType.single
                    ? SingleMatchConfigScreen.route
                    : DoubleMatchConfigScreen.route,
              );
            }
          };
  }

  void _onTournamentPressed(BuildContext context) async {
    final bracketTournamentState = context.read<BracketTournamentCubit>().state;
    final circularTournamentStorage = context.read<CircularTournamentStorage>();

    final isBracketTournamentStarted =
        bracketTournamentState != BracketTournamentState.notStarted();
    final isCircularTournamentStarted =
        circularTournamentStorage.readIsTournamentStarted();

    final navigator = Navigator.of(context);

    final routeName = isBracketTournamentStarted
        ? BracketTournamentScreen.route
        : isCircularTournamentStarted
            ? CircularTournamentScreen.route
            : await showDialog<String>(
                context: context,
                builder: (context) => const TournamentTypeDialog(),
              );

    if (routeName != null) {
      navigator.pushNamed(routeName);
    }
  }

  void _onManagePlayersPressed(BuildContext context) {
    Navigator.of(context).pushNamed(PlayersScreen.route);
  }

  void _onMatchHistoryPressed(BuildContext context) {
    Navigator.of(context).pushNamed(MatchHistoryScreen.route);
  }

  void _onConfigurationPressed(BuildContext context) {
    Navigator.of(context).pushNamed(ConfigurationScreen.route);
  }
}

class _HomeScreenButton extends StatelessWidget {
  const _HomeScreenButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.leading,
    this.backgroundColor,
  }) : assert(icon == null && leading == null ||
            icon != null && leading == null ||
            icon == null && leading != null);

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Widget? leading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final ratio = width / height;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onPressed,
          child: ratio < 2
              ? _buildNarrowerContent(context)
              : _buildWiderContent(context),
        ),
      ),
    );
  }

  Widget _buildWiderContent(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Container(
        height: 84,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 20.0, 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: leading ??
                  FittedBox(
                    child: Icon(icon),
                  ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNarrowerContent(BuildContext context) {
    return Container(
      height: 84,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 0.0, 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: leading ??
                FittedBox(
                  child: Icon(icon),
                ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeTournamentButton extends StatelessWidget {
  const _HomeTournamentButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bracketTournamentState =
        context.watch<BracketTournamentCubit>().state;

    final circularTournamentStorage =
        context.watch<CircularTournamentStorage>();

    final isBracketTournamentStarted =
        bracketTournamentState != BracketTournamentState.notStarted();

    final isCircularTournamentStarted =
        circularTournamentStorage.readIsTournamentStarted();

    final isAnyTournamentStarted =
        isBracketTournamentStarted || isCircularTournamentStarted;

    final gamesPlayedCount = isBracketTournamentStarted
        ? bracketTournamentState.matchesPlayedCount
        : isCircularTournamentStarted
            ? circularTournamentStorage.readCurrentMatchIndex()
            : null;
    final totalMatchesCount = isBracketTournamentStarted
        ? bracketTournamentState.playersCount - 1
        : isCircularTournamentStarted
            ? circularTournamentStorage.readMatches().length
            : null;

    return _HomeScreenButton(
      onPressed: onPressed,
      icon: isAnyTournamentStarted ? null : Icons.emoji_events,
      leading: isAnyTournamentStarted
          ? Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Positioned(
                    top: 2.0,
                    child: BadgeIcon(
                      Icons.emoji_events,
                    )),
                Positioned(
                  bottom: 2,
                  child: Text(
                    '$gamesPlayedCount/$totalMatchesCount',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            )
          : null,
      label: 'Turniej',
      backgroundColor: Colors.amber[700],
    );
  }
}

class _PlayersIcon extends StatelessWidget {
  const _PlayersIcon({
    required this.playersCount,
  });

  final int playersCount;

  @override
  Widget build(BuildContext context) {
    return playersCount <= 0
        ? const Icon(
            Icons.people,
            size: 50,
          )
        : Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const Positioned(
                top: 2.0,
                child: Icon(
                  Icons.people,
                  size: 50,
                ),
              ),
              Positioned(
                bottom: 2,
                child: Text(
                  '$playersCount',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          );
  }
}
