import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/injectable/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);
