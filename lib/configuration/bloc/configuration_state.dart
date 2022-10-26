import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pingpong_score_tracker/default_values.dart';

part 'configuration_state.freezed.dart';
part 'configuration_state.g.dart';

@freezed
class ConfigurationState with _$ConfigurationState {
  const factory ConfigurationState({
    required int pointsInSet,
    required int setsInMatch,
  }) = _ConfigurationState;

  factory ConfigurationState.classic() => const ConfigurationState(
        pointsInSet: DefaultValues.pointsInSet,
        setsInMatch: DefaultValues.setsInMatch,
      );

  factory ConfigurationState.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationStateFromJson(json);
}
