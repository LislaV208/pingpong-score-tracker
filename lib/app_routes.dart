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
  BracketPlayersScreen.route: (_) => const BracketPlayersScreen(),
  BracketTournamentScreen.route: (_) => const BracketTournamentScreen(),
  ConfigurationScreen.route: (_) => const ConfigurationScreen(),
  MatchHistoryScreen.route: (_) => const MatchHistoryScreen(),
  TournamentTypeScreen.route: (_) => const TournamentTypeScreen(),
};
