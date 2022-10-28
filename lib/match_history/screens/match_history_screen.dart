import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_cubit.dart';
import 'package:pingpong_score_tracker/match_history/cubit/match_history_state.dart';
import 'package:pingpong_score_tracker/match_history/widgets/clear_history_dialog.dart';
import 'package:pingpong_score_tracker/match_history/widgets/match_history_list_item.dart';

class MatchHistoryScreen extends StatelessWidget {
  const MatchHistoryScreen({super.key});

  static const route = 'match-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia meczy'),
        actions: [
          IconButton(
            onPressed: () async {
              final cubit = context.read<MatchHistoryCubit>();
              if (cubit.state.history.isEmpty) return;

              final clearHistoryConfirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => const ClearHistoryDialog(),
                  ) ??
                  false;

              if (clearHistoryConfirmed) {
                cubit.clearHistory();
              }
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MatchHistoryCubit, MatchHistoryState>(
          builder: (context, state) {
            final historyEntries = state.history.reversed.toList();
            if (historyEntries.isEmpty) {
              return const Center(
                child: Text('Brak danych'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemCount: historyEntries.length,
                itemBuilder: (context, index) {
                  return MatchHistoryListItem(
                    entry: historyEntries[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
