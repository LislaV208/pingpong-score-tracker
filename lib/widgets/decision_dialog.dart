import 'package:flutter/material.dart';

Future<T?> showDecisionDialog<T>(
  BuildContext context, {
  required String title,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => DecisionDialog(title: title),
    );

class DecisionDialog extends StatelessWidget {
  const DecisionDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(title),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Tak'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Nie'),
              )
            ],
          )
        ],
      ),
    );
  }
}
