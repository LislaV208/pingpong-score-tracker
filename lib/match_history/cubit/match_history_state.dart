import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';

part 'match_history_state.freezed.dart';
part 'match_history_state.g.dart';

@freezed
class MatchHistoryState with _$MatchHistoryState {
  const MatchHistoryState._();

  const factory MatchHistoryState({
    @Default([]) List<MatchHistoryEntry> history,
  }) = _MatchHistoryState;

  factory MatchHistoryState.fromJson(Map<String, dynamic> json) =>
      _$MatchHistoryStateFromJson(json);

  List<Duration> get matchesDuration => history
      .map(
        (history) => history.finishedAt.difference(history.startedAt),
      )
      .toList();
}
