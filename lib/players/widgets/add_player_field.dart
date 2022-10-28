import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/default_values.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/widgets/app_snack_bar.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class AddPlayerField extends HookWidget {
  const AddPlayerField({
    super.key,
    this.isDense = false,
    this.onSaveSuccess,
  });

  final bool isDense;
  final void Function(String value)? onSaveSuccess;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final counter = useState<int>(0);
    final validationText = useState<String>('');
    bool isValid = validationText.value.isEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 16.0, 6.0, 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              maxLength: DefaultValues.maxPlayerNameLength,
              controller: controller,
              decoration: InputDecoration(
                isDense: isDense,
                counterText:
                    '${counter.value}/${DefaultValues.maxPlayerNameLength}',
                fillColor: Colors.grey.withOpacity(0.05),
                filled: true,
                labelText: 'Podaj nazwę gracza',
                errorText: isValid ? null : validationText.value,
                errorStyle: const TextStyle(fontSize: 14),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _clearTextField(
                        controller: controller,
                        validationText: validationText,
                      ),
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
              onChanged: (value) {
                counter.value = value.length;
              },
              onEditingComplete: () {
                _onSave(
                  context,
                  controller: controller,
                  validationText: validationText,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 16.0),
            child: ElevatedCircleButton(
              onPressed: () => _onSave(
                context,
                controller: controller,
                validationText: validationText,
              ),
              icon: const Icon(Icons.done),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave(
    BuildContext context, {
    required TextEditingController controller,
    required ValueNotifier<String> validationText,
  }) {
    final cubit = context.read<PlayersCubit>();
    if (cubit.state.players.length >= DefaultValues.maxPlayersCount) {
      AppSnackBar.show(context, 'Utworzono maksymalną liczbę graczy');
      return;
    }

    final playerName = controller.text.trim();
    try {
      cubit.addPlayer(playerName);
      _clearTextField(controller: controller, validationText: validationText);
      onSaveSuccess?.call(playerName);
    } on ValidationException catch (exception) {
      validationText.value = '';
      switch (exception.error) {
        case ValidationError.emptyName:
          validationText.value = 'Podaj nazwę gracza.';
          break;
        case ValidationError.nameInUse:
          validationText.value = 'Istnieje już taki gracz.';
          break;
      }
    }
  }

  void _clearTextField({
    required TextEditingController controller,
    required ValueNotifier<String> validationText,
  }) {
    controller.clear();
    validationText.value = '';
  }
}
