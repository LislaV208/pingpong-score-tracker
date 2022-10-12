import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';

@singleton
class PlayersCubit extends HydratedCubit<PlayersState> {
  PlayersCubit() : super(const PlayersState());

  @override
  PlayersState? fromJson(Map<String, dynamic> json) =>
      PlayersState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PlayersState state) => state.toJson();

  void addPlayer(String playerName) {
    final players = [...state.players];
    players.add(playerName);
    emit(state.copyWith(players: players));
  }

  void removePlayer(String playerName) {
    final players = [...state.players];
    players.remove(playerName);
    emit(state.copyWith(players: players));
  }
}
