part of 'app.dart';

final _appRoutes = {
  HomeScreen.route: (_) => const HomeScreen(),
  AddInitialPlayersScreen.route: (_) => const AddInitialPlayersScreen(),
  SingleMatchConfigScreen.route: (_) => const SingleMatchConfigScreen(),
  DoubleMatchConfigScreen.route: (_) => const DoubleMatchConfigScreen(),
  // SignleMatchScreen needs parameters, so it uses anonymous navigation
  DoubleMatchScreen.route: (_) => const DoubleMatchScreen(),
  PlayersScreen.route: (_) => const PlayersScreen(),
  AddEditPlayerScreen.route: (_) => const AddEditPlayerScreen(),
  BracketPlayersScreen.route: (_) => const BracketPlayersScreen(),
  BracketTournamentScreen.route: (_) => const BracketTournamentScreen(),
  ConfigurationScreen.route: (_) => const ConfigurationScreen(),
};