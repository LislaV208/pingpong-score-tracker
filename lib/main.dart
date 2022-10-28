import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pingpong_score_tracker/app.dart';
import 'package:pingpong_score_tracker/bloc/app_cubit.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () {
      configureDependencies();
      Wakelock.enable();
      runApp(
        BlocProvider.value(
          value: getIt.get<AppCubit>(),
          child: const App(),
        ),
      );
    },
    storage: storage,
  );
}
