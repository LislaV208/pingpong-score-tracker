import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_state.dart';
import 'package:pingpong_score_tracker/match_history/models/match_history_entry.dart';

@singleton
class MatchHistoryCubit extends HydratedCubit<MatchHistoryState> {
  MatchHistoryCubit() : super(const MatchHistoryState());

  @override
  MatchHistoryState? fromJson(Map<String, dynamic> json) =>
      MatchHistoryState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MatchHistoryState state) => state.toJson();

  void addMatchHistoryEntry(MatchHistoryEntry entry) {
    final history = [...state.history];
    history.add(entry);

    emit(state.copyWith(history: history));
  }

  void clearHistory() {
    emit(state.copyWith(history: []));
  }
}
