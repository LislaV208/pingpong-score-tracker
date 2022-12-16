import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingpong_score_tracker/ads/banner_ad_view.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_cubit.dart';
import 'package:pingpong_score_tracker/configuration/bloc/configuration_state.dart';
import 'package:pingpong_score_tracker/widgets/increment_decrement_value.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  static const route = 'configuration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfiguracja'),
      ),
      body: BannerAdView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 16,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Text('Liczba punktów w secie'),
                                  const Spacer(),
                                  BlocSelector<ConfigurationCubit,
                                      ConfigurationState, int>(
                                    selector: (state) => state.pointsInSet,
                                    builder: (context, pointsInSet) {
                                      return IncrementDecrementValue(
                                        value: pointsInSet,
                                        onIncrement: () => context
                                            .read<ConfigurationCubit>()
                                            .incrementPointsInSet(),
                                        onDecrement: () => context
                                            .read<ConfigurationCubit>()
                                            .decrementPointsInSet(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Text('Liczba setów w meczu'),
                                  const Spacer(),
                                  BlocSelector<ConfigurationCubit,
                                      ConfigurationState, int>(
                                    selector: (state) => state.setsInMatch,
                                    builder: (context, setsInMatch) {
                                      return IncrementDecrementValue(
                                        value: setsInMatch,
                                        onIncrement: () => context
                                            .read<ConfigurationCubit>()
                                            .incrementSetsInMatch(),
                                        onDecrement: () => context
                                            .read<ConfigurationCubit>()
                                            .decrementSetsInMatch(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.read<ConfigurationCubit>().restoreDefaultValues();
                  },
                  child: const Text('Przywróć wartości domyślne'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
