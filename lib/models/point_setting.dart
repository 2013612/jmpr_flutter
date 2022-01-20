import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tuple/tuple.dart';

import '../utility/enum/position.dart';
import 'player.dart';
import 'setting.dart';

part 'point_setting.freezed.dart';
part 'point_setting.g.dart';

@freezed
class PointSetting with _$PointSetting {
  const PointSetting._();

  const factory PointSetting({
    required Map<Position, Player> players,
    @Default(0) @JsonKey(name: 'current_kyoku') int currentKyoku,
    @Default(0) int bonba,
    @Default(0) int riichibou,
  }) = _PointSetting;

  factory PointSetting.fromJson(Map<String, dynamic> json) =>
      _$PointSettingFromJson(json);

  factory PointSetting.fromSetting(Setting setting) {
    Map<Position, Player> players = {};
    for (Position position in Position.values) {
      players[position] = Player(
        point: setting.givenStartingPoint,
        isRiichi: false,
      );
    }
    return PointSetting(players: players);
  }

  Tuple2<PointSetting, Map<Position, Player>> saveRon(
      Position losePlayer, Map<Position, int> points, Setting setting) {
    print("points $points");
    Position oya = _currentOya(setting);
    int nearIndex = 100;
    Map<Position, int> changes = {};
    points.forEach((position, point) {
      if (position == oya) {
        point = (point * 6 + 99) ~/ 100 * 100;
      } else {
        point = (point * 4 + 99) ~/ 100 * 100;
      }
      changes[position] = (changes[position] ?? 0) + point;
      changes[losePlayer] = (changes[losePlayer] ?? 0) - point;
      if (point != 0) {
        nearIndex =
            min(nearIndex, ((position.index - losePlayer.index) + 4) % 4);
      }
    });
    nearIndex = (nearIndex + losePlayer.index) % 4;
    print("before $changes");
    print("bonba ${(changes[losePlayer] ?? 0) - bonba * setting.bonbaPoint}");
    print(changes[losePlayer]);
    changes[losePlayer] =
        (changes[losePlayer] ?? 0) - bonba * setting.bonbaPoint;
    print(changes[losePlayer]);
    changes[Position.values[nearIndex]] =
        (changes[Position.values[nearIndex]] ?? 0) +
            bonba * setting.bonbaPoint +
            riichibou * setting.riichibouPoint;
    print("after $changes");

    Map<Position, Player> pointChanges = _newPointChanges(changes);
    Map<Position, Player> playerPoints = _newPlayerPoints(changes);

    int newBonba = bonba;
    int newKyoku = currentKyoku;
    if (points[oya] != 0) {
      newBonba++;
    } else {
      newBonba = 0;
      newKyoku = (currentKyoku + 1) % 16;
    }

    return Tuple2(
      PointSetting(
        players: playerPoints,
        currentKyoku: newKyoku,
        riichibou: 0,
        bonba: newBonba,
      ),
      pointChanges,
    );
  }

  Tuple2<PointSetting, Map<Position, Player>> saveTsumo(
      Position tsumoPlayer, int point, Setting setting) {
    Position oya = _currentOya(setting);

    var changes = _pointChangeTsumo(tsumoPlayer, point, oya,
        bonba * setting.bonbaPoint, riichibou * setting.riichibouPoint);

    Map<Position, Player> pointChanges = _newPointChanges(changes);
    Map<Position, Player> playerPoints = _newPlayerPoints(changes);

    int newBonba = bonba;
    int newKyoku = currentKyoku;

    if (tsumoPlayer == oya) {
      newBonba++;
    } else {
      newBonba = 0;
      newKyoku = (currentKyoku + 1) % 16;
    }
    return Tuple2(
      PointSetting(
        players: playerPoints,
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
      nagashimangan.forEach((position, value) {
        if (value) {
          _pointChangeTsumo(position, 2000, oya).forEach((position, value) {
            changes[position] = (changes[position] ?? 0) + value;
          });
        }
      });
    } else {
      if (numOfTenpai != 0 && numOfTenpai != 4) {
        tenpai.forEach((position, value) {
          if (value) {
            changes[position] = setting.ryukyokuPoint ~/ numOfTenpai;
          } else {
            changes[position] = -setting.ryukyokuPoint ~/ (4 - numOfTenpai);
          }
        });
      } else {
        for (var position in Position.values) {
          changes[position] = 0;
        }
      }
    }

    Map<Position, Player> pointChanges = _newPointChanges(changes);
    Map<Position, Player> playerPoints = _newPlayerPoints(changes);

    int newKyoku = currentKyoku;
    if (!tenpai[oya]!) {
      newKyoku = (currentKyoku + 1) % 16;
    }

    return Tuple2(
      PointSetting(
        players: playerPoints,
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
                (marks[positionFromPriority(k)] ?? 0) +
                    totalPointsAvailable / 1000 / playerCount;
          }
          i = j;
        }
      }
    } else {
      for (int i = 0; i < 4; i++) {
        marks[positionFromPriority(i)] = (marks[positionFromPriority(i)] ?? 0) +
            (playerWithPriorities[i].score + bonus[i]) / 1000;
      }
    }

    return marks;
  }

  Map<Position, int> _pointChangeTsumo(
      Position tsumoPlayer, int point, Position oya,
      [int totalBonba = 0, int totalRiichibou = 0]) {
    if (tsumoPlayer == oya) {
      point *= 2;
    }

    Map<Position, int> changes = {};

    for (var position in Position.values) {
      if (position == tsumoPlayer) {
        if (position == oya) {
          changes[position] =
              (point + 99) ~/ 100 * 100 * 3 + totalBonba + totalRiichibou;
        } else {
          changes[position] = (point + 99) ~/ 100 * 100 * 2 +
              (point * 2 + 99) ~/ 100 * 100 +
              totalBonba +
              totalRiichibou;
        }
      } else {
        if (position == oya) {
          changes[position] = -(point * 2 + 99) ~/ 100 * 100 - totalBonba ~/ 3;
        } else {
          changes[position] = -(point + 99) ~/ 100 * 100 - totalBonba ~/ 3;
        }
      }
    }
    return changes;
  }

  Map<Position, Player> _newPointChanges(Map<Position, int> changes) {
    return changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: players[position]?.isRiichi ?? false,
          point: change,
        ),
      ),
    );
  }

  Map<Position, Player> _newPlayerPoints(Map<Position, int> changes) {
    return changes.map(
      (position, change) => MapEntry(
        position,
        Player(
          isRiichi: false,
          point: (players[position]?.point ?? 0) + change,
        ),
      ),
    );
  }

  Position _currentOya(Setting setting) {
    return Position.values[(setting.firstOya.index + currentKyoku) % 4];
  }
}

class PlayerWithPriority {
  int score;
  int priority;

  PlayerWithPriority(this.score, this.priority);

  @override
  String toString() {
    return "score: $score, priority: $priority";
  }
}
