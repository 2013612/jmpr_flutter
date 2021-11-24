import 'dart:math';

import '../utility/constant.dart';
import 'point_setting.dart';
import 'setting.dart';

class History {
  PointSetting pointSetting;
  Setting setting;

  History({required this.pointSetting, required this.setting});

  History clone() {
    return History(
        pointSetting: pointSetting.clone(), setting: setting.clone());
  }

  void resetPoint() {
    pointSetting = PointSetting.fromSetting(setting);
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
      pointSetting: $pointSetting,
      setting: $setting,
    }
    ''';
  }
}
