import 'package:jmpr_flutter/classes/setting.dart';

import '../utility/constant.dart';
import 'player.dart';

class PointSetting {
  Map<Position, Player> players;
  int currentKyoku = 0;
  int bonba = 0;
  int riichibou = 0;

  PointSetting({
    required this.players,
    this.currentKyoku = 0,
    this.bonba = 0,
    this.riichibou = 0,
  });

  PointSetting.fromSetting(Setting setting) : players = {} {
    Map<Position, Player> newPlayers = {};
    for (Position position in Position.values) {
      newPlayers[position] = Player(
        position: position,
        point: setting.givenStartingPoint,
        riichi: false,
      );
    }
    players = newPlayers;
  }

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

  @override
  String toString() {
    return '''
    {
      currentKyoku: $currentKyoku,
      bonba: $bonba,
      riichibou: $riichibou,
      players: $players,
    }
    ''';
  }
}
