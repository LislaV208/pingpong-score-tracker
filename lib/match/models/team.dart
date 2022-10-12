import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';

@freezed
class Team with _$Team {
  const Team._();

  const factory Team({
    required String topPlayer,
    required String bottomPlayer,
  }) = _Team;

  String get name => '$topPlayer - $bottomPlayer';
}
