import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/home/screens/home_screen.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/single_match_state.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/match/screens/single_match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/serve_dialog.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/tournament/bracket/widgets/exit_tournament_dialog.dart';
import 'package:pingpong_score_tracker/tournament/circular/circular_tournament_state.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_view.dart';
import 'package:pingpong_score_tracker/tournament/circular/services/circular_tournament_storage.dart';
import 'package:pingpong_score_tracker/tournament/models/tournament_match.dart';

class CircularTournamentScreen extends StatefulWidget {
  const CircularTournamentScreen({super.key});

  static const route = 'circular-tournament';

  @override
  State<CircularTournamentScreen> createState() =>
      _CircularTournamentScreenState();
}

class _CircularTournamentScreenState extends State<CircularTournamentScreen> {
  final matchesCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<CircularTournamentState>();
      final storage = context.read<CircularTournamentStorage>();

      storage.writeTournamentStarted(true);
      storage.writeMatches(state.matches);

      matchesCarouselController.animateToPage(state.currentMatchIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CircularTournamentState>();

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
        body: SafeArea(
          child: CircularTournamentView(
            state: state,
            matchesCarouselController: matchesCarouselController,
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => _onFabPressed(context),
          child: Icon(state.isFinished ? Icons.done : Icons.arrow_forward),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(context).popUntil(
      ModalRoute.withName(HomeScreen.route),
    );

    return false;
  }

  void _onAbourtTournament(BuildContext context) async {
    final navigator = Navigator.of(context);
    final tournamentStorage = context.read<CircularTournamentStorage>();

    final doAbortTournament = await showDialog<bool>(
          context: context,
          builder: (context) => const ExitTournamentDialog(),
        ) ??
        false;

    if (doAbortTournament) {
      tournamentStorage.writeTournamentStarted(false);
      tournamentStorage.writeMatches([]);
      tournamentStorage.writeCurrentMatchIndex(0);
      navigator.popUntil(
        ModalRoute.withName(HomeScreen.route),
      );
    }
  }

  void _onFabPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    final state = context.read<CircularTournamentState>();
    final currentMatch = state.currentMatch;

    if (state.isFinished) {
      navigator.popUntil(
        ModalRoute.withName(HomeScreen.route),
      );

      return;
    }

    final playerServing = await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) => ServeDialog.single(
        leftPlayer: currentMatch.player1,
        rightPlayer: currentMatch.player2,
      ),
    );

    if (playerServing != null) {
      final finishedMatch = await navigator.push<TournamentMatch>(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SingleMatchCubit(
              SingleMatchState(
                leftPlayer: currentMatch.player1,
                rightPlayer: currentMatch.player2,
                playerServing: playerServing,
                currentPlayerServing: playerServing,
              ),
              historyCubit: context.read<MatchHistoryCubit>(),
              configurationCubit: context.read<ConfigurationCubit>(),
            ),
            child: SingleMatchScreen(
              matchType: MatchType.tournament,
              onFinished: (navigator, state) {
                final match = currentMatch.copyWith(
                  player2Score: state.leftPlayerMatchScore,
                  player1Score: state.rightPlayerMatchScore,
                );
                navigator.pop<TournamentMatch>(match);
              },
            ),
          ),
        ),
      );

      if (finishedMatch != null) {
        state.onMatchFinished(finishedMatch);
        if (!state.isFinished) {
          matchesCarouselController.animateToPage(state.currentMatchIndex);
        }
      }
    }
  }
}
