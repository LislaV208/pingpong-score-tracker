import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/ads/banner_ad_view.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/home/screens/home_screen.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/serve_dialog.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/bloc/bracket_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/bracket_graph.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/exit_tournament_dialog.dart';

import '../../../match_history/cubit/match_history_cubit.dart';

class BracketTournamentScreen extends StatelessWidget {
  const BracketTournamentScreen({super.key});

  static const route = 'bracket-tournament';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BracketTournamentCubit>().state;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Turniej'),
          actions: [
            if (!state.isFinished)
              IconButton(
                onPressed: () => _onAbourtTournament(context),
                icon: const Icon(Icons.close),
              ),
          ],
        ),
        body: const BannerAdView(
          child: SafeArea(
            child: BracketGraph(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onFabPressed(context, state),
          child: Icon(state.isFinished ? Icons.done : Icons.arrow_forward),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    final cubit = context.read<BracketTournamentCubit>();
    final navigator = Navigator.of(context);

    if (cubit.state.isFinished == true) {
      cubit.setToNotStarted();
    }
    navigator.popUntil(
      ModalRoute.withName(HomeScreen.route),
    );

    return false;
  }

  void _onAbourtTournament(BuildContext context) async {
    final cubit = context.read<BracketTournamentCubit>();
    final navigator = Navigator.of(context);

    final doAbortTournament = await showDialog<bool>(
          context: context,
          builder: (context) => const ExitTournamentDialog(),
        ) ??
        false;

    if (doAbortTournament) {
      cubit.setToNotStarted();
      navigator.popUntil(
        ModalRoute.withName(HomeScreen.route),
      );
    }
  }

  void _onFabPressed(BuildContext context, BracketTournamentState state) async {
    final navigator = Navigator.of(context);
    final cubit = context.read<BracketTournamentCubit>();

    if (state.isFinished) {
      cubit.setToNotStarted();
      navigator.popUntil(
        ModalRoute.withName(HomeScreen.route),
      );

      return;
    }

    final playerServing = await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) => ServeDialog.single(
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
              historyCubit: context.read<MatchHistoryCubit>(),
              configurationCubit: context.read<ConfigurationCubit>(),
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
  }
}
