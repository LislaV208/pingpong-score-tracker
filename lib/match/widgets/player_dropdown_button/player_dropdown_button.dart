import 'package:flutter/material.dart';

class PlayerDropdownButton extends StatelessWidget {
  const PlayerDropdownButton({
    super.key,
    required this.players,
    required this.playerNotifier,
    required this.removeOtherPlayersPredicate,
    required this.setOtherPlayersOnChange,
  });

  final List<String> players;
  final ValueNotifier<String?> playerNotifier;

  final bool Function(DropdownMenuItem<String> item)
      removeOtherPlayersPredicate;
  final void Function() setOtherPlayersOnChange;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: DropdownButton<String>(
            value: playerNotifier.value,
            isExpanded: true,
            isDense: true,
            items: players
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Center(child: Text(item)),
                  ),
                )
                .toList()
              ..removeWhere(removeOtherPlayersPredicate),
            underline: const SizedBox(),
            hint: const Center(child: Text('Wybierz')),
            onChanged: (value) {
              if (value != null) {
                playerNotifier.value = value;

                setOtherPlayersOnChange();
              }
            },
          ),
        ),
      ),
    );
  }
}
