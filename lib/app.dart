import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/bloc/app_cubit.dart';
import 'package:pingpong_score_tracker/bloc/app_state.dart';
import 'package:pingpong_score_tracker/home_screen.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/screens/add_initial_players_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

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
      home: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final homeScreen = state.isInitialized
              ? const HomeScreen()
              : const AddInitialPlayersScreen();

          return BlocProvider.value(
            value: getIt.get<PlayersCubit>(),
            child: homeScreen,
          );
        },
      ),
    );
  }
}
