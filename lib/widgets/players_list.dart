import 'package:flutter/material.dart';

class PlayersList extends StatelessWidget {
  const PlayersList(
      {super.key,
      required this.players,
      required this.itemBuilder,
      this.clipBehavior});

  final List<String> players;
  final Widget Function(int index, String player) itemBuilder;
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Scrollbar(
          thumbVisibility: true,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ListView(
              clipBehavior: clipBehavior ?? Clip.none,
              children: _generateListChildren(
                context,
                players: players,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateListChildren(
    BuildContext context, {
    required List<String> players,
  }) {
    Widget listItemBuilder(int index, String player) {
      return Expanded(
        child: Card(
          child: itemBuilder(index, player),
        ),
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < players.length; i += 2) {
      final player1 = players[i];
      final player2 = i + 1 >= players.length ? null : players[i + 1];

      final row = Row(
        children: [
          listItemBuilder(i, player1),
          if (player2 != null) listItemBuilder(i + 1, player2),
        ],
      );

      children.add(row);
    }

    return children;
  }
}
