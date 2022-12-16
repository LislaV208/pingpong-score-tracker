import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pingpong_score_tracker/app.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_storage.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

const isFreeVersion = true;
const isAdTestMode = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isFreeVersion) {
    await MobileAds.instance.initialize();
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [
      SystemUiOverlay.top,
    ],
  );

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final circularTournamentStorage = CircularTournamentStorage();
  await circularTournamentStorage.init();

  HydratedBlocOverrides.runZoned(
    () {
      Wakelock.enable();
      runApp(
        ChangeNotifierProvider.value(
          value: circularTournamentStorage,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ConfigurationCubit()),
              BlocProvider(create: (context) => PlayersCubit()),
              BlocProvider(create: (context) => BracketTournamentCubit()),
              BlocProvider(create: (context) => MatchHistoryCubit()),
            ],
            child: const App(),
          ),
        ),
      );
    },
    storage: storage,
  );
}
