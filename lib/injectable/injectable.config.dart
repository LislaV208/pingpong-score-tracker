// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/app_cubit.dart' as _i3;
import '../configuration/bloc/configuration_cubit.dart' as _i5;
import '../match/bloc/double_match_state.dart' as _i6;
import '../match/bloc/single_match_state.dart' as _i10;
import '../match/models/team.dart' as _i7;
import '../match_history/cubit/match_history_cubit.dart' as _i8;
import '../players/bloc/players_cubit.dart' as _i9;
import '../tournament/bracket/bloc/bracket_tournament_cubit.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i3.AppCubit>(_i3.AppCubit());
  gh.singleton<_i4.BracketTournamentCubit>(_i4.BracketTournamentCubit());
  gh.singleton<_i5.ConfigurationCubit>(_i5.ConfigurationCubit());
  gh.factory<_i6.DoubleMatchState>(() => _i6.DoubleMatchState(
        leftTeam: get<_i7.Team>(),
        rightTeam: get<_i7.Team>(),
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
  gh.singleton<_i8.MatchHistoryCubit>(_i8.MatchHistoryCubit());
  gh.singleton<_i9.PlayersCubit>(_i9.PlayersCubit());
  gh.factory<_i10.SingleMatchState>(() => _i10.SingleMatchState(
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
  return get;
}
