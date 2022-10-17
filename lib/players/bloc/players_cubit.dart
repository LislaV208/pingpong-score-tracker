import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/players/bloc/players_state.dart';

enum ValidationError {
  emptyName,
  nameInUse,
}

class ValidationException implements Exception {
  ValidationException(this.error);

  final ValidationError error;
}

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

    final error = _validate(playerName, players);
    if (error != null) throw ValidationException(error);

    players.add(playerName);
    emit(state.copyWith(players: players));
  }

  void editPlayer(String oldPlayerName, String newPlayerName) {
    final players = [...state.players];

    final error = _validate(newPlayerName, players);
    if (error != null) throw ValidationException(error);

    final index = players.indexOf(oldPlayerName);
    players[index] = newPlayerName;
    emit(state.copyWith(players: players));
  }

  void removePlayer(String playerName) {
    final players = [...state.players];
    players.remove(playerName);
    emit(state.copyWith(players: players));
  }

  ValidationError? _validate(String playerName, List<String> players) {
    if (playerName.isEmpty || playerName.trim().isEmpty) {
      return ValidationError.emptyName;
    }
    if (players.contains(playerName)) return ValidationError.nameInUse;

    return null;
  }
}
