import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';

part 'match_history_entry.freezed.dart';
part 'match_history_entry.g.dart';

@freezed
class MatchHistoryEntry with _$MatchHistoryEntry {
  const factory MatchHistoryEntry({
    required String leftPlayer,
    required int leftPlayerScore,
    required String rightPlayer,
    required int rightPlayerScore,
    required DateTime startedAt,
    required DateTime finishedAt,
    required MatchType matchType,
  }) = _MatchHistoryEntry;

  factory MatchHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$MatchHistoryEntryFromJson(json);
}
