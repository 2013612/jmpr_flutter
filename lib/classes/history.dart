import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/setting.dart';

import '../utility/constant.dart';
import '../utility/enum/ending.dart';
import '../utility/enum/position.dart';
import 'point_setting.dart';

class History {
  PointSetting pointSetting;
  Setting setting;
  int index;
  Ending ending;

  History({
    required this.pointSetting,
    required this.setting,
    required this.index,
    required this.ending,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      pointSetting:
          PointSetting.fromJson(json["point_setting"] as Map<String, dynamic>),
      setting: Setting.fromJson(json["setting"] as Map<String, dynamic>),
      index: json["index"] as int,
      ending: Ending.values[json["ending"] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "point_setting": pointSetting.toJson(),
      "setting": setting.toJson(),
      "index": index,
      "ending": Ending.values.indexOf(ending),
    };
  }

  factory History.fromSnapshot(DocumentSnapshot snapshot) {
    return History.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  History clone() {
    return History(
      pointSetting: pointSetting.clone(),
      setting: setting.copyWith(),
      index: index,
      ending: ending,
    );
  }

  void resetPoint() {
    pointSetting = PointSetting.fromSetting(setting);
    ending = Ending.start;
    index++;
  }

  Map<Position, double> calResult() {
    final List<List<int>> cal = [];
    Position position(int index) {
      return Position.values[(setting.firstOya.index + cal[index][1]) % 4];
    }

    for (Position position in Position.values) {
      cal.add([
        pointSetting.players[position]!.point - setting.startingPoint,
        (Position.values.indexOf(position) -
                Position.values.indexOf(setting.firstOya) +
                4) %
            4,
      ]);
    }

    cal.sort((List<int> a, List<int> b) {
      if (a[0] == b[0]) {
        return a[1] - b[1];
      } else {
        return b[0] - a[0];
      }
    });

    final Map<Position, double> marks = {};
    final double topBonus =
        4 * (setting.startingPoint - setting.givenStartingPoint) / 1000;
    if (setting.isDouten) {
      if (cal[0][0] == cal[1][0] &&
          cal[1][0] == cal[2][0] &&
          cal[2][0] == cal[3][0]) {
        marks[position(0)] = cal[0][0] / 1000 + topBonus / 4;
        marks[position(1)] = cal[1][0] / 1000 + topBonus / 4;
        marks[position(2)] = cal[2][0] / 1000 + topBonus / 4;
        marks[position(3)] = cal[3][0] / 1000 + topBonus / 4;
      } else if (cal[0][0] == cal[1][0] && cal[1][0] == cal[2][0]) {
        marks[position(0)] = cal[0][0] / 1000 + (topBonus + setting.umaBig) / 3;
        marks[position(1)] = cal[1][0] / 1000 + (topBonus + setting.umaBig) / 3;
        marks[position(2)] = cal[2][0] / 1000 + (topBonus + setting.umaBig) / 3;
        marks[position(3)] = cal[3][0] / 1000 - setting.umaBig;
      } else if (cal[1][0] == cal[2][0] && cal[2][0] == cal[3][0]) {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000 - setting.umaBig / 3;
        marks[position(2)] = cal[2][0] / 1000 - setting.umaBig / 3;
        marks[position(3)] = cal[3][0] / 1000 - setting.umaBig / 3;
      } else if (cal[0][0] == cal[1][0] && cal[2][0] == cal[3][0]) {
        marks[position(0)] = cal[0][0] / 1000 +
            (topBonus + setting.umaBig + setting.umaSmall) / 2;
        marks[position(1)] = cal[1][0] / 1000 +
            (topBonus + setting.umaBig + setting.umaSmall) / 2;
        marks[position(2)] =
            cal[2][0] / 1000 - (setting.umaBig + setting.umaSmall) / 2;
        marks[position(3)] =
            cal[3][0] / 1000 - (setting.umaBig + setting.umaSmall) / 2;
      } else if (cal[0][0] == cal[1][0]) {
        marks[position(0)] = cal[0][0] / 1000 +
            (topBonus + setting.umaBig + setting.umaSmall) / 2;
        marks[position(1)] = cal[1][0] / 1000 +
            (topBonus + setting.umaBig + setting.umaSmall) / 2;
        marks[position(2)] = cal[2][0] / 1000 - setting.umaSmall;
        marks[position(3)] = cal[3][0] / 1000 - setting.umaBig;
      } else if (cal[1][0] == cal[2][0]) {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000;
        marks[position(2)] = cal[2][0] / 1000;
        marks[position(3)] = cal[3][0] / 1000 - setting.umaBig;
      } else if (cal[2][0] == cal[3][0]) {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000 + setting.umaSmall;
        marks[position(2)] =
            cal[2][0] / 1000 - (setting.umaBig + setting.umaSmall) / 2;
        marks[position(3)] =
            cal[3][0] / 1000 - (setting.umaBig + setting.umaSmall) / 2;
      } else {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000 + setting.umaSmall;
        marks[position(2)] = cal[2][0] / 1000 - setting.umaSmall;
        marks[position(3)] = cal[3][0] / 1000 - setting.umaBig;
      }
    } else {
      marks[position(0)] = cal[0][0] / 1000 + topBonus + setting.umaBig;
      marks[position(1)] = cal[1][0] / 1000 + setting.umaSmall;
      marks[position(2)] = cal[2][0] / 1000 - setting.umaSmall;
      marks[position(3)] = cal[3][0] / 1000 - setting.umaBig;
    }
    return marks;
  }

  void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
      Map<Position, int> hans, Map<Position, int> fus) {
    Position oya = _currentOya();
    int nearIndex = 100;
    ronPlayers.forEach((key, value) {
      if (value) {
        int point = _calPoint(hans[key]!, fus[key]!);
        if (key == oya) {
          point = (point * 6 + 99) ~/ 100 * 100;
        } else {
          point = (point * 4 + 99) ~/ 100 * 100;
        }
        pointSetting.players[key]!.point += point;
        pointSetting.players[ronedPlayer]!.point -= point;
        nearIndex = min(nearIndex, ((key.index - ronedPlayer.index) + 4) % 4);
      }
    });
    nearIndex = (nearIndex + ronedPlayer.index) % 4;
    pointSetting.players[ronedPlayer]!.point -=
        pointSetting.bonba * setting.bonbaPoint;
    pointSetting.players[Position.values[nearIndex]]!.point +=
        pointSetting.bonba * setting.bonbaPoint +
            pointSetting.riichibou * setting.riichibouPoint;
    pointSetting.riichibou = 0;
    if (ronPlayers[oya]!) {
      pointSetting.bonba++;
    } else {
      pointSetting.bonba = 0;
      pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
    }
    ending = Ending.ron;
  }

  void saveTsumo(Position tsumoPlayer, int han, int fu) {
    int point = _calPoint(han, fu);
    Position oya = _currentOya();
    _updatePlayerPointTsumo(point, tsumoPlayer);
    if (tsumoPlayer == oya) {
      pointSetting.bonba++;
    } else {
      pointSetting.bonba = 0;
      pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
    }
    ending = Ending.tsumo;
  }

  void saveRyukyoku(
      Map<Position, bool> tenpai, Map<Position, bool> nagashimangan) {
    int numOfTenpai = 0;
    int numOfNagashimagan = 0;
    tenpai.forEach((key, value) {
      if (value) numOfTenpai++;
    });
    nagashimangan.forEach((key, value) {
      if (value) numOfNagashimagan++;
    });
    Position oya = _currentOya();
    if (numOfNagashimagan > 0) {
      int bonba = pointSetting.bonba;
      int riichibou = pointSetting.riichibou;
      pointSetting.bonba = 0;
      pointSetting.riichibou = 0;
      nagashimangan.forEach((key, value) {
        if (value) {
          _updatePlayerPointTsumo(2000, key);
        }
      });
      pointSetting.bonba = bonba;
      pointSetting.riichibou = riichibou;
    } else {
      if (numOfTenpai != 0 && numOfTenpai != 4) {
        tenpai.forEach((key, value) {
          if (value) {
            pointSetting.players[key]!.point +=
                setting.ryukyokuPoint ~/ numOfTenpai;
          } else {
            pointSetting.players[key]!.point -=
                setting.ryukyokuPoint ~/ (4 - numOfTenpai);
          }
        });
      }
    }
    if (!tenpai[oya]!) {
      pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
    }
    pointSetting.bonba++;
    ending = Ending.ryukyoku;
  }

  void setRiichiFalse() {
    for (Position position in Position.values) {
      pointSetting.players[position]!.riichi = false;
    }
  }

  int _calPoint(int han, int fu) {
    int point = (pow(2, han + 2) * fu).toInt();
    if (point > 1920) {
      point = Constant.points[han]!;
    } else if (point == 1920 && setting.isKiriage) {
      point = 2000;
    }
    return point;
  }

  Position _currentOya() {
    return Position
        .values[(setting.firstOya.index + pointSetting.currentKyoku) % 4];
  }

  void _updatePlayerPointTsumo(int point, Position position) {
    Position oya = _currentOya();
    if (position == oya) {
      point *= 2;
    }
    pointSetting.players.forEach((key, value) {
      if (key == position) {
        if (key == oya) {
          value.point += (point + 99) ~/ 100 * 100 * 3 +
              pointSetting.bonba * setting.bonbaPoint +
              pointSetting.riichibou * setting.riichibouPoint;
        } else {
          value.point += (point + 99) ~/ 100 * 100 * 2 +
              (point * 2 + 99) ~/ 100 * 100 +
              pointSetting.bonba * setting.bonbaPoint +
              pointSetting.riichibou * setting.riichibouPoint;
        }
      } else {
        if (key == oya) {
          value.point -= (point * 2 + 99) ~/ 100 * 100 +
              pointSetting.bonba * setting.bonbaPoint ~/ 3;
        } else {
          value.point -= (point + 99) ~/ 100 * 100 +
              pointSetting.bonba * setting.bonbaPoint ~/ 3;
        }
      }
    });
    if (position != oya) {
      pointSetting.bonba = 0;
    }

    pointSetting.riichibou = 0;
  }

  @override
  String toString() {
    return '''
    {
      index: $index,
      ending: $ending,
      pointSetting: $pointSetting,
      setting: $setting,
    }
    ''';
  }
}
