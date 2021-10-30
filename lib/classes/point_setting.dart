import '../utility/constant.dart';
import 'player.dart';

class PointSetting {
  Map<Position, Player> players;
  int currentKyoku;
  int bonba;
  int riichibou;

  PointSetting({
    required this.players,
    this.currentKyoku = 0,
    this.bonba = 0,
    this.riichibou = 0,
  });

  PointSetting clone() {
    Map<Position, Player> newPlayers = {};
    players.forEach((position, player) {
      newPlayers[position] = player.clone();
    });
    return PointSetting(
      players: newPlayers,
      currentKyoku: currentKyoku,
      bonba: bonba,
      riichibou: riichibou,
    );
  }
}
