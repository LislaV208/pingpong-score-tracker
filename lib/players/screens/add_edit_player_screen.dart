import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
import 'package:pingpong_score_tracker/widgets/elevated_circle_button.dart';

class AddEditPlayerScreen extends HookWidget {
  const AddEditPlayerScreen({super.key, this.player});

  final String? player;

  static const maxNameLength = 20;

  bool get isAddingMode => player == null;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: player);
    final validationText = useState<String>('');
    bool isValid = validationText.value.isEmpty;
    final counter = useState<int>(player?.length ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(isAddingMode ? 'Nowy gracz' : 'Edytuj gracza: $player'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    maxLength: maxNameLength,
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      counterText: '${counter.value}/$maxNameLength',
                      fillColor: Colors.grey.withOpacity(0.05),
                      filled: true,
                      labelText: 'Nazwa',
                      errorText: isValid ? null : validationText.value,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
                    onChanged: (value) {
                      counter.value = value.length;
                    },
                    onSubmitted: (value) => _onSave(
                      context,
                      playerName: value,
                      validationText: validationText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 16.0),
                  child: ElevatedCircleButton(
                    onPressed: () => _onSave(
                      context,
                      playerName: controller.text,
                      validationText: validationText,
                    ),
                    icon: const Icon(Icons.done),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave(
    BuildContext context, {
    required String playerName,
    required ValueNotifier<String> validationText,
  }) {
    final cubit = context.read<PlayersCubit>();
    try {
      playerName = playerName.trim();
      if (isAddingMode) {
        cubit.addPlayer(playerName);
      } else {
        cubit.editPlayer(player!, playerName);
      }
      Navigator.of(context).pop();
    } on ValidationException catch (exception) {
      validationText.value = '';
      switch (exception.error) {
        case ValidationError.emptyName:
          validationText.value = 'Podaj nazwę gracza.';
          break;
        case ValidationError.nameInUse:
          validationText.value =
              'Znaleziono gracza o takiej same nazwie. Podaj inną nazwę.';
          break;
      }
    }
  }
}
