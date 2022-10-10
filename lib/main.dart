import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';

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
      //   child: const StandardMatchScreen(
      //     leftPlayer: Player(name: 'Long'),
      //     rightPlayer: Player(name: 'Pong'),
      //   ),
      // ),
      // home: const MatchScreen(),
    );
  }
}
