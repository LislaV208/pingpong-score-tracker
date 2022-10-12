import 'package:freezed_annotation/freezed_annotation.dart';

part 'players_state.freezed.dart';
part 'players_state.g.dart';

@freezed
class PlayersState with _$PlayersState {
  const factory PlayersState({
    @Default([]) List<String> players,
  }) = _PlayersState;

  factory PlayersState.fromJson(Map<String, dynamic> json) =>
      _$PlayersStateFromJson(json);
}
