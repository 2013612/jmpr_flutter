import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/point_setting.dart';
import '../classes/setting.dart';
import '../utility/constant.dart';
import 'setting.dart';

final pointSettingProvider =
    StateNotifierProvider<PointSettingNotifier, PointSetting>(
  (ref) {
    final setting = ref.watch(settingProvider).state;
    return PointSettingNotifier(setting);
  },
);

class PointSettingNotifier extends StateNotifier<PointSetting> {
  final Setting setting;
  PointSettingNotifier(this.setting) : super(PointSetting.fromSetting(setting));

  void newPointSetting(PointSetting pointSetting) {
    state = pointSetting;
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
        state.players[key]!.point += point;
        state.players[ronedPlayer]!.point -= point;
        nearIndex = min(nearIndex, ((key.index - ronedPlayer.index) + 4) % 4);
      }
    });
    nearIndex = (nearIndex + ronedPlayer.index) % 4;
    state.players[ronedPlayer]!.point -= state.bonba * setting.bonbaPoint;
    state.players[Position.values[nearIndex]]!.point +=
        state.bonba * setting.bonbaPoint +
            state.riichibou * setting.riichibouPoint;
    state.riichibou = 0;
    if (ronPlayers[oya]!) {
      state.bonba++;
    } else {
      state.bonba = 0;
      state.currentKyoku = (state.currentKyoku + 1) % 16;
    }
    state = state.clone();
  }

  void saveRyukyoku(
      Map<Position, bool> tenpai, Map<Position, bool> nagashimangan) {
    int numOfTenpai = 0;
    int numOfNagashimagan = 0;
    var setting = Setting();
    tenpai.forEach((key, value) {
      if (value) numOfTenpai++;
    });
    nagashimangan.forEach((key, value) {
      if (value) numOfNagashimagan++;
    });
    Position oya = _currentOya();
    if (numOfNagashimagan > 0) {
      int? bonba = state.bonba;
      int? riichibou = state.riichibou;
      state.bonba = 0;
      state.riichibou = 0;
      nagashimangan.forEach((key, value) {
        if (value) {
          _updatePlayerPointTsumo(2000, key);
        }
      });
      state.bonba = bonba;
      state.riichibou = riichibou;
    } else {
      if (numOfTenpai != 0 && numOfTenpai != 4) {
        tenpai.forEach((key, value) {
          if (value) {
            state.players[key]!.point += setting.ryukyokuPoint ~/ numOfTenpai;
          } else {
            state.players[key]!.point -=
                setting.ryukyokuPoint ~/ (4 - numOfTenpai);
          }
        });
      }
    }
    if (!tenpai[oya]!) {
      state.currentKyoku = (state.currentKyoku + 1) % 16;
    }
    state.bonba++;
    state = state.clone();
  }

  void saveTsumo(Position tsumoPlayer, int han, int fu) {
    int point = _calPoint(han, fu);
    Position oya = _currentOya();
    _updatePlayerPointTsumo(point, tsumoPlayer);
    if (tsumoPlayer == oya) {
      state.bonba++;
    } else {
      state.bonba = 0;
      state.currentKyoku = (state.currentKyoku + 1) % 16;
    }
    state = state.clone();
  }

  void setRiichiFalse() {
    for (Position position in Position.values) {
      state.players[position]!.riichi = false;
    }
    state = state.clone();
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
    return Position.values[(setting.firstOya.index + state.currentKyoku) % 4];
  }

  void _updatePlayerPointTsumo(int point, Position position) {
    Position oya = _currentOya();
    if (position == oya) {
      point *= 2;
    }
    state.players.forEach((key, value) {
      if (key == position) {
        if (key == oya) {
          value.point += (point + 99) ~/ 100 * 100 * 3 +
              state.bonba * setting.bonbaPoint +
              state.riichibou * setting.riichibouPoint;
        } else {
          value.point += (point + 99) ~/ 100 * 100 * 2 +
              (point * 2 + 99) ~/ 100 * 100 +
              state.bonba * setting.bonbaPoint +
              state.riichibou * setting.riichibouPoint;
        }
      } else {
        if (key == oya) {
          value.point -= (point * 2 + 99) ~/ 100 * 100 +
              state.bonba * setting.bonbaPoint ~/ 3;
        } else {
          value.point -=
              (point + 99) ~/ 100 * 100 + state.bonba * setting.bonbaPoint ~/ 3;
        }
      }
    });
    if (position != oya) {
      state.bonba = 0;
    }

    state.riichibou = 0;
  }
}
