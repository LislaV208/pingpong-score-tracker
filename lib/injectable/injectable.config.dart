// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../match/bloc/double_match_cubit.dart' as _i9;
import '../match/bloc/double_match_state.dart' as _i3;
import '../match/bloc/standard_match_cubit.dart' as _i10;
import '../match/bloc/standard_match_state.dart' as _i8;
import '../match/models/team.dart' as _i4;
import '../match_history/cubit/match_history_cubit.dart' as _i6;
import '../players/bloc/players_cubit.dart' as _i7;
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
  gh.factory<_i3.DoubleMatchState>(() => _i3.DoubleMatchState(
        leftTeam: get<_i4.Team>(),
        rightTeam: get<_i4.Team>(),
        playerServingSet: get<_i5.Player>(),
        playerServingMatch: get<_i5.Player>(),
        currentPlayerServing: get<_i5.Player>(),
        isFinished: get<bool>(),
        leftTeamSetScore: get<int>(),
        rightTeamSetScore: get<int>(),
        leftTeamMatchScore: get<int>(),
        rightTeamMatchScore: get<int>(),
        playerServesCount: get<int>(),
        canUndo: get<bool>(),
      ));
  gh.singleton<_i6.MatchHistoryCubit>(_i6.MatchHistoryCubit());
  gh.singleton<_i7.PlayersCubit>(_i7.PlayersCubit());
  gh.factory<_i8.StandardMatchState>(() => _i8.StandardMatchState(
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
  gh.factory<_i9.DoubleMatchCubit>(() => _i9.DoubleMatchCubit(
        get<_i3.DoubleMatchState>(),
        get<_i6.MatchHistoryCubit>(),
      ));
  gh.factory<_i10.StandardMatchCubit>(() => _i10.StandardMatchCubit(
        get<_i8.StandardMatchState>(),
        get<_i6.MatchHistoryCubit>(),
      ));
  return get;
}
