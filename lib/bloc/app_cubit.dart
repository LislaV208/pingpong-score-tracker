import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pingpong_score_tracker/bloc/app_state.dart';
import 'package:pingpong_score_tracker/utils/parsing_utils.dart';

@singleton
class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(AppState.initial());

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return tryParse(
      parse: () => AppState.fromJson(json),
      fallbackValue: AppState.initial(),
    );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return tryParse(
      parse: () => state.toJson(),
      fallbackValue: AppState.initial().toJson(),
    );
  }

  void initialize() {
    emit(state.copyWith(isInitialized: true));
  }
}
