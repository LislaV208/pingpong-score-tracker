import 'dart:math';

import 'package:random_string/random_string.dart';

List<String> generateRandomPlayers(
  int count, {
  int minCharacters = 4,
  int maxCharacters = 12,
}) {
  return List.generate(
    count,
    (index) {
      final length =
          Random().nextInt(maxCharacters - minCharacters) + minCharacters;
      return randomAlpha(length);
    },
  );
}
