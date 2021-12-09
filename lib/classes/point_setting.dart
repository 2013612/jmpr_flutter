import '../utility/enum/position.dart';
import '../utility/iterable_methods.dart';
import 'player.dart';
import 'setting.dart';

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

  factory PointSetting.fromJson(Map<String, dynamic> json) {
    Map<Position, Player> newPlayers = {};
    (json["players"] as List<Map<String, dynamic>>)
        .forEachIndexed((player, index) {
      newPlayers[Position.values[index]] = Player.fromJson(player);
    });
    return PointSetting(
      players: newPlayers,
      currentKyoku: json["current_kyoku"] as int,
      bonba: json["bonba"] as int,
      riichibou: json["riichibou"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> playersJson = List.filled(4, {});
    players.forEach((key, value) {
      playersJson[Position.values.indexOf(key)] = value.toJson();
    });
    return {
      "players": playersJson,
      "current_kyoku": currentKyoku,
      "bonba": bonba,
      "riichibou": riichibou,
    };
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
