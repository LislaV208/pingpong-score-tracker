import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/configuration/screens/configuration_screen.dart';
import 'package:pingpong_score_tracker/home/screens/home_screen.dart';
import 'package:pingpong_score_tracker/match_history/screens/match_history_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/screens/add_initial_players_screen.dart';

import 'package:pingpong_score_tracker/match/screens/double_match_config_screen.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_screen.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_config_screen.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:pingpong_score_tracker/qr_code_share/screens/scan_qr_code_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_players_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/screens/bracket_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_screen.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/berger_table_generator.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_match_generator.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_storage.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';
import 'package:provider/provider.dart';

import 'tournament/circular/screens/circular_tournament_players_screen.dart';

part 'app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitialized =
        context.read<PlayersCubit>().state.players.length >= 2;

    final initialRoute =
        isInitialized ? HomeScreen.route : AddInitialPlayersScreen.route;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey[800],
          contentTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.dark,
      routes: _appRoutes,
      initialRoute: initialRoute,
    );
  }
}
