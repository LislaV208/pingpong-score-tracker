import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/widgets/app_button.dart';
import 'package:pingpong_score_tracker/widgets/app_dialog.dart';
import 'package:pingpong_score_tracker/widgets/row_button_panel.dart';

class MatchTypeDialog extends StatelessWidget {
  const MatchTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final canPlayDouble = context
        .select<PlayersCubit, bool>((cubit) => cubit.state.players.length >= 4);

    return AppDialog(
      title: 'Wybierz rodzaj rozgrywki',
      child: RowButtonPanel(
        buttons: [
          AppButton(
            onPressed: () {
              Navigator.of(context).pop(MatchType.single);
            },
            child: const Text('Singiel'),
          ),
          AppButton(
            onPressed: canPlayDouble
                ? () {
                    Navigator.of(context).pop(MatchType.double);
                  }
                : null,
            child: const Text('Debel'),
          ),
        ],
      ),
    );
  }
}
