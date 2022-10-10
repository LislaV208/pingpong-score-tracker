import 'package:flutter/material.dart';

class EndMatchDialog extends StatelessWidget {
  const EndMatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ListTile(
            title: Text('Czy zakończyć mecz?'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Tak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Powrót'),
          ),
        ],
      ),
    );
  }
}
