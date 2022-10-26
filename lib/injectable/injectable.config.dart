// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../configuration/bloc/configuration_cubit.dart' as _i4;
import '../match/bloc/double_match_state.dart' as _i5;
import '../match/bloc/single_match_state.dart' as _i9;
import '../match/models/team.dart' as _i6;
import '../match_history/cubit/match_history_cubit.dart' as _i7;
import '../players/bloc/players_cubit.dart' as _i8;
import '../tournament/bracket/bloc/bracket_tournament_cubit.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i3.BracketTournamentCubit>(_i3.BracketTournamentCubit());
  gh.singleton<_i4.ConfigurationCubit>(_i4.ConfigurationCubit());
  gh.factory<_i5.DoubleMatchState>(() => _i5.DoubleMatchState(
        leftTeam: get<_i6.Team>(),
        rightTeam: get<_i6.Team>(),
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
  gh.singleton<_i7.MatchHistoryCubit>(_i7.MatchHistoryCubit());
  gh.singleton<_i8.PlayersCubit>(_i8.PlayersCubit());
  gh.factory<_i9.SingleMatchState>(() => _i9.SingleMatchState(
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
