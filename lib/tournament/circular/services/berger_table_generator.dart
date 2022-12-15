class BergerTableMatch<T> {
  const BergerTableMatch(this.leftPlayer, this.rightPlayer);

  final T leftPlayer;
  final T rightPlayer;

  @override
  String toString() => '($leftPlayer - $rightPlayer)';
}

class BergerTableGenerator<T> {
  const BergerTableGenerator(this.players);

  final List<T> players;

  int get playersCount => players.length;
  int get roundsCount =>
      playersCount.isEven ? playersCount ~/ 2 : (playersCount + 1) ~/ 2;
  int get fixedIndex => playersCount.isEven ? playersCount - 1 : playersCount;

  List<BergerTableMatch<T>> generate() {
    final matches = <BergerTableMatch<T>>[];

    if (playersCount < 2) return matches;

    var leftIndex = 0;
    var rightIndex = fixedIndex;

    final roundsToGenerate =
        playersCount.isEven ? playersCount - 1 : playersCount;

    for (var i = 0; i < roundsToGenerate; ++i) {
      final round = _generateRound(leftIndex, rightIndex);
      matches.addAll(round);

      leftIndex = leftIndex == fixedIndex
          ? players.indexOf(matches.last.rightPlayer)
          : fixedIndex;
      rightIndex = rightIndex == fixedIndex
          ? players.indexOf(matches.last.rightPlayer)
          : fixedIndex;
    }

    return matches;
  }

  List<BergerTableMatch<T>> _generateRound(
    int leftIndex,
    int rightIndex,
  ) {
    final matches = <BergerTableMatch<T>>[];
    for (var i = 0; i < roundsCount; ++i) {
      if (!(playersCount.isOdd && i == 0)) {
        final match = BergerTableMatch<T>(
          players[leftIndex],
          players[rightIndex],
        );
        matches.add(match);
      }

      final previosLeftIndex = leftIndex;

      leftIndex = leftIndex == fixedIndex ? rightIndex + 1 : leftIndex + 1;
      if (leftIndex >= fixedIndex) {
        leftIndex = 0;
      }

      rightIndex =
          rightIndex == fixedIndex ? previosLeftIndex - 1 : rightIndex - 1;
      if (rightIndex < 0) {
        rightIndex = fixedIndex - 1;
      }
    }
    return matches;
  }
}