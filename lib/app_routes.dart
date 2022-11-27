part of 'app.dart';

final _appRoutes = {
  HomeScreen.route: (_) => const HomeScreen(),
  AddInitialPlayersScreen.route: (_) => const AddInitialPlayersScreen(),
  SingleMatchConfigScreen.route: (_) => const SingleMatchConfigScreen(),
  DoubleMatchConfigScreen.route: (_) => const DoubleMatchConfigScreen(),
  // SignleMatchScreen needs parameters, so it uses anonymous navigation
  // SingleMatchScreen.route: (_) => const SingleMatchScreen(),
  DoubleMatchScreen.route: (_) => const DoubleMatchScreen(),
  PlayersScreen.route: (_) => const PlayersScreen(),
  // AddEditPlayerScreen needs parameters, so it uses anonymous navigation
  // AddEditPlayerScreen.route: (_) => const AddEditPlayerScreen(),
  BracketTournamentPlayersScreen.route: (_) =>
      const BracketTournamentPlayersScreen(),
  BracketTournamentScreen.route: (_) => const BracketTournamentScreen(),
  ConfigurationScreen.route: (_) => const ConfigurationScreen(),
  MatchHistoryScreen.route: (_) => const MatchHistoryScreen(),
  TournamentTypeScreen.route: (_) => const TournamentTypeScreen(),
  CircularTournamentPlayersScreen.route: (_) =>
      const CircularTournamentPlayersScreen(),
  CircularTournamentScreen.route: (_) => const CircularTournamentScreen(),
};
