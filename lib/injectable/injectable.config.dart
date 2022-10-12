// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../match/bloc/double_match_cubit.dart' as _i8;
import '../match/bloc/double_match_state.dart' as _i3;
import '../match/bloc/standard_match_cubit.dart' as _i9;
import '../match/bloc/standard_match_state.dart' as _i7;
import '../match/models/team.dart' as _i4;
import '../match_history/cubit/match_history_cubit.dart' as _i5;
import '../players/bloc/players_cubit.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.DoubleMatchState>(() => _i3.DoubleMatchState(
        leftTeam: get<_i4.Team>(),
        rightTeam: get<_i4.Team>(),
        playerServingSet: get<String>(),
        playerServingMatch: get<String>(),
        currentPlayerServing: get<String>(),
        isFinished: get<bool>(),
        leftTeamSetScore: get<int>(),
        rightTeamSetScore: get<int>(),
        leftTeamMatchScore: get<int>(),
        rightTeamMatchScore: get<int>(),
        playerServesCount: get<int>(),
        canUndo: get<bool>(),
      ));
  gh.singleton<_i5.MatchHistoryCubit>(_i5.MatchHistoryCubit());
  gh.singleton<_i6.PlayersCubit>(_i6.PlayersCubit());
  gh.factory<_i7.StandardMatchState>(() => _i7.StandardMatchState(
        leftPlayer: get<String>(),
        rightPlayer: get<String>(),
        playerServing: get<String>(),
        currentPlayerServing: get<String>(),
        isFinished: get<bool>(),
        leftPlayerSetScore: get<int>(),
        rightPlayerSetScore: get<int>(),
        leftPlayerMatchScore: get<int>(),
        rightPlayerMatchScore: get<int>(),
        playerServesCount: get<int>(),
        canUndo: get<bool>(),
      ));
  gh.factory<_i8.DoubleMatchCubit>(() => _i8.DoubleMatchCubit(
        get<_i3.DoubleMatchState>(),
        get<_i5.MatchHistoryCubit>(),
      ));
  gh.factory<_i9.StandardMatchCubit>(() => _i9.StandardMatchCubit(
        get<_i7.StandardMatchState>(),
        get<_i5.MatchHistoryCubit>(),
      ));
  return get;
}
