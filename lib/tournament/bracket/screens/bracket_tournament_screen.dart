import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/injectable/injectable.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/single_serve_dialog.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/players/screens/players_screen.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/bracket_graph.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/exit_tournament_dialog.dart';

import '../../../match_history/cubit/match_history_cubit.dart';

class BracketTournamentScreen extends StatelessWidget {
  const BracketTournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BracketTournamentCubit>().state;

    return WillPopScope(
      onWillPop: () async {
        final cubit = context.read<BracketTournamentCubit>();
        final navigator = Navigator.of(context);

        if (cubit.state.isFinished == true) {
          cubit.setToNotStarted();
          navigator.popUntil(
            ModalRoute.withName('/'),
          );

          return false;
        }

        final result = await showDialog<ExitTournamentDialogResult>(
              context: context,
              builder: (context) => const ExitTournamentDialog(),
            ) ??
            ExitTournamentDialogResult.continueTournament;

        if (result != ExitTournamentDialogResult.continueTournament) {
          if (result == ExitTournamentDialogResult.cancel) {
            cubit.setToNotStarted();
          }

          navigator.popUntil(
            ModalRoute.withName('/'),
          );
        }

        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Turniej')),
        body: const SafeArea(
          child: BracketGraph(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            final cubit = context.read<BracketTournamentCubit>();

            if (state.isFinished) {
              cubit.setToNotStarted();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: getIt.get<PlayersCubit>(),
                    child: const PlayersScreen(),
                  ),
                ),
                (route) => false,
              );

              return;
            }

            final playerServing = await showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (context) => SingleServeDialog(
                leftPlayer: state.upcomingMatch!.player1,
                rightPlayer: state.upcomingMatch!.player2,
              ),
            );

            if (playerServing != null) {
              final playedMatchState = await navigator.push<SingleMatchState>(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => SingleMatchCubit(
                      SingleMatchState(
                        leftPlayer: state.upcomingMatch!.player1,
                        rightPlayer: state.upcomingMatch!.player2,
                        playerServing: playerServing,
                        currentPlayerServing: playerServing,
                      ),
                      historyCubit: getIt.get<MatchHistoryCubit>(),
                    ),
                    child: SingleMatchScreen(
                      matchType: MatchType.tournament,
                      onFinished: (navigator, state) {
                        navigator.pop(state);
                      },
                    ),
                  ),
                ),
              );

              cubit.onMatchFinished(
                playedMatchState!.leftPlayerMatchScore,
                playedMatchState.rightPlayerMatchScore,
              );
            }
          },
          child: Icon(state.isFinished ? Icons.done : Icons.arrow_forward),
        ),
      ),
    );
  }
}
