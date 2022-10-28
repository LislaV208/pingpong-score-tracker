import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_state.dart';
import 'package:pingpong_score_tracker/utils/parsing_utils.dart';

class ConfigurationCubit extends HydratedCubit<ConfigurationState> {
  ConfigurationCubit() : super(ConfigurationState.classic());

  @override
  ConfigurationState? fromJson(Map<String, dynamic> json) {
    return tryParse(
      parse: () => ConfigurationState.fromJson(json),
      fallbackValue: ConfigurationState.classic(),
    );
  }

  @override
  Map<String, dynamic>? toJson(ConfigurationState state) {
    return tryParse(
      parse: () => state.toJson(),
      fallbackValue: ConfigurationState.classic().toJson(),
    );
  }

  void incrementPointsInSet() {
    final value = state.pointsInSet + 1;
    if (_isValid(value)) {
      emit(state.copyWith(pointsInSet: value));
    }
  }

  void decrementPointsInSet() {
    final value = state.pointsInSet - 1;
    if (_isValid(value)) {
      emit(state.copyWith(pointsInSet: value));
    }
  }

  void incrementSetsInMatch() {
    final value = state.setsInMatch + 1;
    if (_isValid(value)) {
      emit(state.copyWith(setsInMatch: value));
    }
  }

  void decrementSetsInMatch() {
    final value = state.setsInMatch - 1;
    if (_isValid(value)) {
      emit(state.copyWith(setsInMatch: value));
    }
  }

  void restoreDefaultValues() {
    emit(ConfigurationState.classic());
  }

  bool _isValid(int value) {
    return value > 0;
  }
}
