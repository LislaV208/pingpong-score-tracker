import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pingpong_score_tracker/ads/ad_units.dart';
import 'package:pingpong_score_tracker/home/screens/home_screen.dart';
import 'package:pingpong_score_tracker/main.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_cubit.dart';
import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
import 'package:pingpong_score_tracker/match/screens/match_screen.dart';
import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
import 'package:pingpong_score_tracker/match/widgets/player_name.dart';

class DoubleMatchScreen extends StatefulWidget {
  const DoubleMatchScreen({super.key});

  static const route = 'double-match';

  @override
  State<DoubleMatchScreen> createState() => _DoubleMatchScreenState();
}

class _DoubleMatchScreenState extends State<DoubleMatchScreen> {
  InterstitialAd? ad;

  @override
  void initState() {
    super.initState();

    if (isFreeVersion) {
      InterstitialAd.load(
        adUnitId: AdUnits.interstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this.ad = ad;
          },
          onAdFailedToLoad: (error) {},
        ),
      );
    }
  }

  @override
  void dispose() {
    ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoubleMatchCubit, DoubleMatchState>(
      listener: (context, state) async {
        if (state.isFinished) {
          final cubit = context.read<DoubleMatchCubit>();
          final navigator = Navigator.of(context);

          final isFinished = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (_) => MatchFinishedDialog(
                  leftPlayer: state.leftTeam.name,
                  rightPlayer: state.rightTeam.name,
                  leftScore: state.leftTeamMatchScore,
                  rightScore: state.rightTeamMatchScore,
                  undo: () => context.read<DoubleMatchCubit>().undo(),
                ),
              ) ??
              false;

          if (isFinished) {
            cubit.addMatchHistoryEntry();

            if (isFreeVersion) {
              await ad?.show();
            }

            navigator.popUntil(
              ModalRoute.withName(HomeScreen.route),
            );
          }
        }
      },
      builder: (context, state) {
        return MatchScreen(
          matchScore: MatchScore(
            scoreLeft: state.leftTeamMatchScore,
            scoreRight: state.rightTeamMatchScore,
          ),
          leftTeamSetScore: state.leftTeamSetScore,
          rightTeamSetScore: state.rightTeamSetScore,
          leftTeamLabels: [
            PlayerName(
              name: state.leftTeam.topPlayer,
              isServing: state.currentPlayerServing == state.leftTeam.topPlayer,
            ),
            PlayerName(
              name: state.leftTeam.bottomPlayer,
              isServing:
                  state.currentPlayerServing == state.leftTeam.bottomPlayer,
            ),
          ],
          rightTeamLabels: [
            PlayerName(
              name: state.rightTeam.topPlayer,
              isServing:
                  state.currentPlayerServing == state.rightTeam.topPlayer,
            ),
            PlayerName(
              name: state.rightTeam.bottomPlayer,
              isServing:
                  state.currentPlayerServing == state.rightTeam.bottomPlayer,
            ),
          ],
          onGivePointToLeftTeam: () =>
              context.read<DoubleMatchCubit>().givePointToTeam(state.leftTeam),
          onGivePointToRightTeam: () =>
              context.read<DoubleMatchCubit>().givePointToTeam(state.rightTeam),
          onUndoPressed: state.canUndo
              ? () => context.read<DoubleMatchCubit>().undo()
              : null,
          onFlipTeamsPressed: () =>
              context.read<DoubleMatchCubit>().flipTeams(),
        );
      },
    );
  }
}
