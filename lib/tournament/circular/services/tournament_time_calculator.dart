// algorytm szacowania czasu turnieju bierze pod uwage nastepujace czynniki:
// - liczbę meczy do rozegrania
// - customową konfiguracje punktową meczu
// - średni czas trwania meczu na podstawie historii meczy
// - jezeli brak historii meczy, sredni czas trwania meczu to jakas ustalona wartosc (np 5min)

class TournamentTimeCalculator {
  const TournamentTimeCalculator({
    required this.matchesToPlayCount,
    required this.averageTimePerMatch,
  });

  final int matchesToPlayCount;
  final Duration averageTimePerMatch;

  Duration calculate() {
    final timePerMatch = averageTimePerMatch;
    final tournamentDuration = timePerMatch * matchesToPlayCount;

    return tournamentDuration;
  }
}
