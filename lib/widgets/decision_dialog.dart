import 'package:flutter/material.dart';
import 'package:pingpong_score_tracker/widgets/app_button.dart';
import 'package:pingpong_score_tracker/widgets/app_dialog.dart';
import 'package:pingpong_score_tracker/widgets/row_button_panel.dart';

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
    return AppDialog(
      title: title,
      child: RowButtonPanel(
        buttons: [
          AppButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Tak'),
          ),
          AppButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Nie'),
          )
        ],
      ),
    );
  }
}
