import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';

class BracketTournamentCubit extends Cubit<BracketTournamentState> {
  BracketTournamentCubit(List<String> players)
      : super(
          BracketTournamentState.fromPlayersList(players),
        );
}
