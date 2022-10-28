import 'package:flutter/material.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.index,
    required this.player,
    required this.onDeletePlayer,
    this.dense = false,
    this.onEditPlayer,
  });

  final int index;
  final String player;
  final void Function(BuildContext context, String player) onDeletePlayer;
  final bool dense;
  final void Function(BuildContext context, {String? player})? onEditPlayer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      minLeadingWidth: 20.0,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('${index + 1}.')],
      ),
      title: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(player),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEditPlayer != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEditPlayer!(context, player: player),
            ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => onDeletePlayer(context, player),
          ),
        ],
      ),
    );
  }
}
