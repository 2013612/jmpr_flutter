import 'dart:math';

import 'package:tuple/tuple.dart';

import '../models/player.dart';
import '../models/setting.dart';
import '../utility/enum/position.dart';
import '../utility/iterable_methods.dart';

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
        point: setting.givenStartingPoint,
        isRiichi: false,
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

  Tuple2<PointSetting, Map<Position, Player>> saveRon(
      Position losePlayer, Map<Position, int> points, Setting setting) {
    Position oya = _currentOya(setting);
    int nearIndex = 100;
    Map<Position, int> changes = {};
    points.forEach((position, point) {
      if (position == oya) {
        point = (point * 6 + 99) ~/ 100 * 100;
      } else {
        point = (point * 4 + 99) ~/ 100 * 100;
      }
      changes[position] = changes[position] ?? 0 + point;
      changes[losePlayer] = changes[position] ?? 0 - point;
      nearIndex = min(nearIndex, ((position.index - losePlayer.index) + 4) % 4);
    });
    nearIndex = (nearIndex + losePlayer.index) % 4;
    changes[losePlayer] = changes[losePlayer] ?? 0 - bonba * setting.bonbaPoint;
    changes[Position.values[nearIndex]] = changes[Position.values[nearIndex]] ??
        0 + bonba * setting.bonbaPoint + riichibou * setting.riichibouPoint;

    Map<Position, Player> pointChanges = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: players[position]?.isRiichi ?? false,
          point: change,
        ),
      ),
    );
    Map<Position, Player> currentPlayerPoints = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: false,
          point: players[position]?.point ?? 0 + change,
        ),
      ),
    );

    int newBonba = bonba;
    int newKyoku = currentKyoku;
    if (points.containsKey(oya)) {
      newBonba++;
    } else {
      newBonba = 0;
      newKyoku = (currentKyoku + 1) % 16;
    }

    return Tuple2(
      PointSetting(
        players: currentPlayerPoints,
        currentKyoku: newKyoku,
        riichibou: 0,
        bonba: newBonba,
      ),
      pointChanges,
    );
  }

  Tuple2<PointSetting, Map<Position, Player>> saveTsumo(
      Position tsumoPlayer, int point, Setting setting) {
    var changes = _pointChangeTsumo(tsumoPlayer, point, setting);

    Map<Position, Player> pointChanges = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: players[position]?.isRiichi ?? false,
          point: change,
        ),
      ),
    );
    Map<Position, Player> currentPlayerPoints = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: false,
          point: players[position]?.point ?? 0 + change,
        ),
      ),
    );

    int newBonba = bonba;
    int newKyoku = currentKyoku;

    if (tsumoPlayer == _currentOya(setting)) {
      newBonba++;
    } else {
      newBonba = 0;
      newKyoku = (currentKyoku + 1) % 16;
    }
    return Tuple2(
      PointSetting(
        players: currentPlayerPoints,
        currentKyoku: newKyoku,
        riichibou: 0,
        bonba: newBonba,
      ),
      pointChanges,
    );
  }

  Tuple2<PointSetting, Map<Position, Player>> saveRyukyoku(
      Map<Position, bool> tenpai,
      Map<Position, bool> nagashimangan,
      Setting setting) {
    int numOfTenpai = 0;
    int numOfNagashimagan = 0;
    tenpai.forEach((key, value) {
      if (value) numOfTenpai++;
    });
    nagashimangan.forEach((key, value) {
      if (value) numOfNagashimagan++;
    });
    Position oya = _currentOya(setting);
    Map<Position, int> changes = {};
    if (numOfNagashimagan > 0) {
      int newBonba = bonba;
      int newRiichibou = riichibou;
      bonba = 0;
      riichibou = 0;
      nagashimangan.forEach((position, value) {
        if (value) {
          _pointChangeTsumo(position, 2000, setting).forEach((position, value) {
            changes[position] = changes[position] ?? 0 + value;
          });
        }
      });
      bonba = newBonba;
      riichibou = newRiichibou;
    } else {
      if (numOfTenpai != 0 && numOfTenpai != 4) {
        tenpai.forEach((position, value) {
          if (value) {
            changes[position] = setting.ryukyokuPoint ~/ numOfTenpai;
          } else {
            changes[position] = -setting.ryukyokuPoint ~/ (4 - numOfTenpai);
          }
        });
      }
    }

    Map<Position, Player> pointChanges = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: players[position]?.isRiichi ?? false,
          point: change,
        ),
      ),
    );
    Map<Position, Player> currentPlayerPoints = changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: false,
          point: players[position]?.point ?? 0 + change,
        ),
      ),
    );

    int newKyoku = currentKyoku;
    if (!tenpai[oya]!) {
      newKyoku = (currentKyoku + 1) % 16;
    }

    return Tuple2(
      PointSetting(
        players: currentPlayerPoints,
        currentKyoku: newKyoku,
        riichibou: riichibou,
        bonba: bonba + 1,
      ),
      pointChanges,
    );
  }

  Map<Position, double> calResult(Setting setting) {
    final List<PlayerWithPriority> playerWithPriorities = [];
    Position positionFromPriority(int index) {
      return Position.values[
          (setting.firstOya.index + playerWithPriorities[index].priority) % 4];
    }

    for (Position position in Position.values) {
      playerWithPriorities.add(PlayerWithPriority(
        players[position]!.point - setting.startingPoint,
        (Position.values.indexOf(position) -
                Position.values.indexOf(setting.firstOya) +
                4) %
            4,
      ));
    }

    playerWithPriorities.sort((PlayerWithPriority a, PlayerWithPriority b) {
      if (a.score == b.score) {
        return a.priority - b.priority;
      }
      return b.score - a.score;
    });

    final Map<Position, double> marks = {};
    List<int> bonus = [
      4 * (setting.startingPoint - setting.givenStartingPoint) +
          setting.umaBig * 1000,
      setting.umaSmall * 1000,
      -setting.umaSmall * 1000,
      -setting.umaBig * 1000,
    ];

    if (setting.isDouten) {
      int totalPlayerCount = 4;
      {
        int i = 0;
        while (i < totalPlayerCount) {
          int j = i;
          int totalPointsAvailable = 0;
          while (j < totalPlayerCount &&
              playerWithPriorities[i].score == playerWithPriorities[j].score) {
            totalPointsAvailable += bonus[j];
            j++;
          }
          int playerCount = j - i;
          for (int k = i; k < j; k++) {
            marks[positionFromPriority(k)] =
                totalPointsAvailable / 1000 / playerCount;
          }
          i = j;
        }
      }
    } else {
      marks[positionFromPriority(0)] =
          (playerWithPriorities[0].priority + bonus[0]) / 1000;
      marks[positionFromPriority(1)] =
          (playerWithPriorities[1].priority + bonus[1]) / 1000;
      marks[positionFromPriority(2)] =
          (playerWithPriorities[2].priority + bonus[2]) / 1000;
      marks[positionFromPriority(3)] =
          (playerWithPriorities[3].priority + bonus[3]) / 1000;
    }

    return marks;
  }

  Map<Position, int> _pointChangeTsumo(
      Position tsumoPlayer, int point, Setting setting) {
    Position oya = _currentOya(setting);
    if (tsumoPlayer == oya) {
      point *= 2;
    }
    Map<Position, int> changes = {};

    for (var position in Position.values) {
      if (position == tsumoPlayer) {
        if (position == oya) {
          changes[position] = (point + 99) ~/ 100 * 100 * 3 +
              bonba * setting.bonbaPoint +
              riichibou * setting.riichibouPoint;
        } else {
          changes[position] = (point + 99) ~/ 100 * 100 * 2 +
              (point * 2 + 99) ~/ 100 * 100 +
              bonba * setting.bonbaPoint +
              riichibou * setting.riichibouPoint;
        }
      } else {
        if (position == oya) {
          changes[position] =
              -(point * 2 + 99) ~/ 100 * 100 + bonba * setting.bonbaPoint ~/ 3;
        } else {
          changes[position] =
              -(point + 99) ~/ 100 * 100 + bonba * setting.bonbaPoint ~/ 3;
        }
      }
    }
    return changes;
  }

  Position _currentOya(Setting setting) {
    return Position.values[(setting.firstOya.index + currentKyoku) % 4];
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> playersJson = List.generate(4, (index) => {});
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
      newPlayers[position] = player.copyWith();
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

class PlayerWithPriority {
  int score;
  int priority;

  PlayerWithPriority(this.score, this.priority);
}
