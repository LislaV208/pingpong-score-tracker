import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/ads/banner_ad_view.dart';
import 'package:pingpong_score_tracker/utils/media_query_utils.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class MatchConfigScreen extends StatelessWidget {
  const MatchConfigScreen({
    super.key,
    required this.matchScreenBuilder,
    required this.serveDialogBuilder,
    required this.leftChild,
    required this.rightChild,
    required this.selectRandomPlayers,
    required this.swapTeams,
    required this.clearSelectedPlayers,
    required this.arePlayersSelected,
    this.centerFab = false,
  });

  final Widget Function(String playerServing) matchScreenBuilder;
  final Widget Function(BuildContext context) serveDialogBuilder;
  final Widget leftChild;
  final Widget rightChild;
  final VoidCallback selectRandomPlayers;
  final VoidCallback? swapTeams;
  final VoidCallback? clearSelectedPlayers;
  final bool arePlayersSelected;
  final bool centerFab;

  @override
  Widget build(BuildContext context) {
    print('Right view padding: ${MediaQuery.of(context).viewPadding.right}');
    var fab = AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: arePlayersSelected
          ? Offset.zero
          : centerFab
              ? const Offset(3, 0)
              : const Offset(0, 3),
      child: Padding(
        padding: EdgeInsets.only(
          right: isWideScreen(context)
              ? 0.0
              : MediaQuery.of(context).viewPadding.right,
        ),
        // EdgeInsets.only(right: 0.0),
        child: FloatingActionButton(
          onPressed: arePlayersSelected
              ? () async {
                  final navigator = Navigator.of(context);
                  final playerServing = await showDialog<String>(
                    context: context,
                    builder: serveDialogBuilder,
                  );

                  if (playerServing != null) {
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => matchScreenBuilder(playerServing),
                      ),
                    );
                  }
                }
              : null,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );

    var content = Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(child: leftChild),
            const VerticalDivider(thickness: 5.0),
            Expanded(child: rightChild),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedCircleButton(
                onPressed: selectRandomPlayers,
                icon: const Icon(
                  Icons.question_mark,
                ),
                label: 'Losuj',
              ),
              ElevatedCircleButton(
                onPressed: swapTeams,
                icon: const Icon(
                  Icons.compare_arrows,
                ),
                label: 'Zamień',
              ),
              ElevatedCircleButton(
                onPressed: clearSelectedPlayers,
                icon: const Icon(
                  Icons.clear,
                ),
                label: 'Wyczyść',
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfiguracja meczu'),
      ),
      body: BannerAdView(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText1 ?? const TextStyle(),
          child: SafeArea(
            child: centerFab
                ? Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: fab,
                      ),
                      content
                    ],
                  )
                : content,
          ),
        ),
      ),
      floatingActionButton: centerFab ? null : fab,
    );
  }
}
