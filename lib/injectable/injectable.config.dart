// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../match/bloc/standard_match_cubit.dart' as _i6;
import '../match/bloc/standard_match_state.dart' as _i4;
import '../players/bloc/players_cubit.dart' as _i3;
import '../players/models/player.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.PlayersCubit>(_i3.PlayersCubit());
  gh.factory<_i4.StandardMatchState>(() => _i4.StandardMatchState(
        leftPlayer: get<_i5.Player>(),
        rightPlayer: get<_i5.Player>(),
        playerServing: get<_i5.Player>(),
        currentPlayerServing: get<_i5.Player>(),
        isFinished: get<bool>(),
        leftPlayerSetScore: get<int>(),
        rightPlayerSetScore: get<int>(),
        leftPlayerMatchScore: get<int>(),
        rightPlayerMatchScore: get<int>(),
        playerServesCount: get<int>(),
        canUndo: get<bool>(),
      ));
  gh.factory<_i6.StandardMatchCubit>(
      () => _i6.StandardMatchCubit(get<_i4.StandardMatchState>()));
  return get;
}
