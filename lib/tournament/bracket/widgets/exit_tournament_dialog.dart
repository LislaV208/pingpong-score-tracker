import 'package:flutter/material.dart';

enum ExitTournamentDialogResult {
  continueTournament,
  saveAndExit,
  cancel,
}

class ExitTournamentDialog extends StatelessWidget {
  const ExitTournamentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text('Czy anulować turniej?'),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  pop(context, ExitTournamentDialogResult.cancel);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Anuluj'),
              ),
              ElevatedButton(
                onPressed: () {
                  pop(context, ExitTournamentDialogResult.saveAndExit);
                },
                child: const Text('Zapisz i wyjdź'),
              ),
              TextButton(
                onPressed: () {
                  pop(context, ExitTournamentDialogResult.continueTournament);
                },
                child: const Text('Wróć'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void pop(BuildContext context, ExitTournamentDialogResult result) {
    Navigator.of(context).pop(result);
  }
}
