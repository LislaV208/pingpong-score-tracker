import 'package:pingpong_score_tracker/players/models/player.dart';

enum PlayerPosition {
  left,
  right,
  leftTop,
  leftBottom,
  rightTop,
  rightBottom,
}

abstract class MatchConfig {
  final Map<PlayerPosition, Player> _playersWithPositions = {};

  void setPlayer(PlayerPosition position, Player player);
}

class StandardMatchConfig extends MatchConfig {
  @override
  void setPlayer(PlayerPosition position, Player player) {
    assert(position == PlayerPosition.left || position == PlayerPosition.right);

    _playersWithPositions[position] = player;
  }
}

class DoubleMatchConfig extends MatchConfig {
  @override
  void setPlayer(PlayerPosition position, Player player) {
    assert(position != PlayerPosition.left && position != PlayerPosition.right);

    _playersWithPositions[position] = player;
  }
}
