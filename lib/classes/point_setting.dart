import '../common.dart';
import 'player.dart';

class PointSetting {
  Map<Position, Player> players;
  int currentKyoku;
  int bonba;
  int riichibou;

  PointSetting(
      {required this.players,
      required this.currentKyoku,
      required this.bonba,
      required this.riichibou});

  PointSetting clone() {
    Map<Position, Player> newPlayers = {};
    players.forEach((key, value) {
      newPlayers[key] = value.clone();
    });
    return PointSetting(
      players: newPlayers,
      currentKyoku: currentKyoku,
      bonba: bonba,
      riichibou: riichibou,
    );
  }
}
