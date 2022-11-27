import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/tournament/circular/screens/circular_tournament_view.dart';

class CircularTournamentScreen extends StatelessWidget {
  const CircularTournamentScreen({super.key});

  static const route = 'circular-tournament';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Turniej'),
          actions: [
            // if (!state.isFinished)
            IconButton(
              onPressed: () => _onAbourtTournament(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: SafeArea(
          child: CircularTournamentView(),
        ),
        // TODO: implement
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => _onFabPressed(
            context,
            // state,
          ),
          child: Icon(Icons.arrow_forward),
          // child: Icon(state.isFinished ? Icons.done : Icons.arrow_forward),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    // final cubit = context.read<BracketTournamentCubit>();
    // final navigator = Navigator.of(context);

    // if (cubit.state.isFinished == true) {
    //   cubit.setToNotStarted();
    // }
    // navigator.popUntil(
    //   ModalRoute.withName(HomeScreen.route),
    // );

    // return false;

    // TODO: implement
    return true;
  }

  void _onAbourtTournament(BuildContext context) async {
    // final cubit = context.read<BracketTournamentCubit>();
    // final navigator = Navigator.of(context);

    // final doAbortTournament = await showDialog<bool>(
    //       context: context,
    //       builder: (context) => const ExitTournamentDialog(),
    //     ) ??
    //     false;

    // if (doAbortTournament) {
    //   cubit.setToNotStarted();
    //   navigator.popUntil(
    //     ModalRoute.withName(HomeScreen.route),
    //   );
    // }

    // TODO: implement
  }

  void _onFabPressed(
    BuildContext context,
    // state,
  ) {}
}
