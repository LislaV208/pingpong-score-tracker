import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match/match_type.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';

class MatchTypeDialog extends StatelessWidget {
  const MatchTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final canPlayDouble = context
        .select<PlayersCubit, bool>((cubit) => cubit.state.players.length >= 4);

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const ListTile(
            title: Text('Wybierz tryb gry'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(MatchType.single);
                },
                child: const Text('Singiel'),
              ),
              ElevatedButton(
                onPressed: canPlayDouble
                    ? () {
                        Navigator.of(context).pop(MatchType.double);
                      }
                    : null,
                child: const Text('Debel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
