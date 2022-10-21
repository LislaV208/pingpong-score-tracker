import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_config_screen.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_config_screen.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/match_history/screens/match_history_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:pingpong_score_tracker/players/widgets/match_type_dialog.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_players_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/widgets/badge_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ekran główny')),
      body: Center(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
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
                          _HomeScreenButton(
                            onPressed: () => _onTournamentPressed(context),
                            icon: Icons.emoji_events,
                            label: 'Turniej',
                            backgroundColor: Colors.amber[700],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _HomeScreenButton(
                            onPressed: () => _onManagePlayersPressed(context),
                            leading: BadgeIcon(
                              Icons.people,
                              badgeText:
                                  '${context.select<PlayersCubit, int>((cubit) => cubit.state.players.length)}',
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
                  TextButton(
                    onPressed: () {
                      // TODO: implement
                    },
                    child: const Text(
                      'O autorze',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
              builder: (context) => BlocProvider.value(
                value: getIt.get<PlayersCubit>(),
                child: const MatchTypeDialog(),
              ),
            );
            if (matchType != null) {
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: getIt.get<PlayersCubit>(),
                    child: matchType == MatchType.single
                        ? const SingledMatchConfigScreen()
                        : const DoubleMatchConfigScreen(),
                  ),
                ),
              );
            }
          };
  }

  void _onTournamentPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tournamentState = getIt.get<BracketTournamentCubit>().state;
          if (tournamentState == BracketTournamentState.notStarted()) {
            return BlocProvider.value(
              value: getIt.get<PlayersCubit>(),
              child: const BracketPlayersScreen(),
            );
          }
          return BlocProvider.value(
            value: getIt.get<BracketTournamentCubit>(),
            child: const BracketTournamentScreen(),
          );
        },
      ),
    );
  }

  void _onManagePlayersPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt.get<PlayersCubit>(),
          child: const PlayersScreen(),
        ),
      ),
    );
  }

  void _onMatchHistoryPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt.get<MatchHistoryCubit>(),
          child: const MatchHistoryScreen(),
        ),
      ),
    );
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Container(
              height: 84,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 20.0, 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      child: leading ?? Icon(icon),
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
          ),
        ),
      ),
    );
  }
}