import 'package:flutter/material.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({
    super.key,
    required this.players,
    required this.itemBuilder,
    this.controller,
    this.portrait = false,
    this.reverse = false,
    this.clipBehavior,
  });

  final List<String> players;
  final Widget Function(int index, String player) itemBuilder;
  final ScrollController? controller;
  final bool portrait;
  final bool reverse;
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ListView(
            controller: controller,
            clipBehavior: clipBehavior ?? Clip.none,
            reverse: reverse,
            children: _generateListChildren(
              context,
              players: players,
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
      final card = Card(
        child: itemBuilder(index, player),
      );

      return portrait ? card : Expanded(child: card);
    }

    final children = <Widget>[];
    if (portrait) {
      for (var i = 0; i < players.length; ++i) {
        children.add(
          listItemBuilder(i, players[i]),
        );
      }
    } else {
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
    }

    return children;
  }
}
