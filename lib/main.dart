// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/models/team.dart';
import 'package:pingpong_score_tracker/match/screens/double_match_screen.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () {
      configureDependencies();
      Wakelock.enable();
      runApp(const MyApp());
    },
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: BlocProvider.value(
        value: getIt.get<PlayersCubit>(),
        child: const PlayersScreen(),
      ),
      // home: BlocProvider(
      //   create: (context) => StandardMatchCubit(
      //     StandardMatchState(
      //       leftPlayer: Player(name: 'Long'),
      //       rightPlayer: Player(name: 'Pong'),
      //       playerServing: Player(name: 'Long'),
      //       currentPlayerServing: Player(name: 'Long'),
      //     ),
      //   ),
      //   child: const StandardMatchScreen(),
      // ),
      // home: const MatchScreen(),
      // home: BlocProvider(
      //   create: (context) => DoubleMatchCubit(
      //     DoubleMatchState(
      //       leftTeam: Team(
      //         topPlayer: Player(name: 'Long'),
      //         bottomPlayer: Player(name: 'Dong'),
      //       ),
      //       rightTeam: Team(
      //         topPlayer: Player(name: 'Arong'),
      //         bottomPlayer: Player(name: 'Mong'),
      //       ),
      //       playerServingSet: Player(name: 'Dong'),
      //       playerServingMatch: Player(name: 'Dong'),
      //       currentPlayerServing: Player(name: 'Dong'),
      //     ),
      //   ),
      //   child: const DoubleMatchScreen(),
      // ),
    );
  }
}
