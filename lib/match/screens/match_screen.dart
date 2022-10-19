import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/match/widgets/end_match_dialog.dart';
import 'package:pingpong_score_tracker/match/widgets/player_score.dart';
import 'package:pingpong_score_tracker/match/widgets/undo_button.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.matchScore,
    required this.leftTeamLabels,
    required this.rightTeamLabels,
    required this.onGivePointToLeftTeam,
    required this.onGivePointToRightTeam,
    required this.onUndoPressed,
    required this.leftTeamSetScore,
    required this.rightTeamSetScore,
  });

  final Widget matchScore;
  final int leftTeamSetScore;
  final int rightTeamSetScore;
  final List<Widget> leftTeamLabels;
  final List<Widget> rightTeamLabels;
  final VoidCallback onGivePointToLeftTeam;
  final VoidCallback onGivePointToRightTeam;
  final VoidCallback? onUndoPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => const EndMatchDialog(),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: matchScore,
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _PointButton(
                      onPressed: onGivePointToLeftTeam,
                      score: leftTeamSetScore,
                      children: leftTeamLabels,
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: _PointButton(
                      onPressed: onGivePointToRightTeam,
                      score: rightTeamSetScore,
                      children: rightTeamLabels,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: UndoButton(onPressed: onUndoPressed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointButton extends StatelessWidget {
  const _PointButton({
    required this.onPressed,
    required this.score,
    required this.children,
  });

  final VoidCallback onPressed;
  final int score;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    assert(children.isNotEmpty && children.length <= 2);

    final scoreWidget = PlayerScore(score: score);

    return Container(
      color: Colors.green.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0.05),
            child: InkWell(
              onTap: onPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children.length == 1
                    ? [
                        children.first,
                        scoreWidget,
                      ]
                    : children.length == 2
                        ? [
                            children.first,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 40.0,
                              ),
                              child: scoreWidget,
                            ),
                            children.last,
                          ]
                        : [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
