import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/players/models/player.dart';

part 'players_state.freezed.dart';
part 'players_state.g.dart';

@freezed
class PlayersState with _$PlayersState {
  const factory PlayersState({
    @Default([]) List<Player> players,
  }) = _PlayersState;

  factory PlayersState.fromJson(Map<String, dynamic> json) =>
      _$PlayersStateFromJson(json);
}
