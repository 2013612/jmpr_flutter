import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/history.dart';
import '../classes/point_setting.dart';
import '../classes/setting.dart';
import 'constant.dart';

final settingProvider = StateProvider(
  (_) => Setting(),
);

final pointSettingProvider =
    StateNotifierProvider<PointSettingNotifier, PointSetting>(
  (ref) {
    final setting = ref.watch(settingProvider).state;
    return PointSettingNotifier(setting);
  },
);

final historyProvider = Provider(
  (ref) => [
    History(
      pointSetting: ref.watch(pointSettingProvider).clone(),
      setting: ref.watch(settingProvider).state.clone(),
    )
  ],
);

final historyIndexProvider = StateProvider((_) => 1);

final localeProvider = StateProvider((_) => Locale('ja'));

class PointSettingNotifier extends StateNotifier<PointSetting> {
  PointSettingNotifier(Setting setting)
      : super(PointSetting.fromSetting(setting));

  void newPointSetting(PointSetting pointSetting) {
    state = pointSetting;
  }

  void setRiichiFalse() {
    final newState = state.clone();
    for (Position position in Position.values) {
      newState.players[position]!.riichi = false;
    }
    state = newState;
  }

  void saveRyukyoku(Map<Position, bool> tenpai,
      Map<Position, bool> nagashimangan, Setting setting) {
    var newState = state.clone();
    int numOfTenpai = 0;
    int numOfNagashimagan = 0;
    var setting = Setting();
    tenpai.forEach((key, value) {
      if (value) numOfTenpai++;
    });
    nagashimangan.forEach((key, value) {
      if (value) numOfNagashimagan++;
    });
    //Position oya = currentOya();
    Position oya =
        Position.values[(setting.firstOya.index + newState.currentKyoku) % 4];
    if (numOfNagashimagan > 0) {
      int? bonba = newState.bonba;
      int? riichibou = newState.riichibou;
      newState.bonba = 0;
      newState.riichibou = 0;
      nagashimangan.forEach((key, value) {
        if (value) {
          updatePlayerPointTsumo(2000, key, setting);
        }
      });
      newState.bonba = bonba;
      newState.riichibou = riichibou;
    } else {
      if (numOfTenpai != 0 && numOfTenpai != 4) {
        tenpai.forEach((key, value) {
          if (value) {
            newState.players[key]!.point +=
                setting.ryukyokuPoint ~/ numOfTenpai;
          } else {
            newState.players[key]!.point -=
                setting.ryukyokuPoint ~/ (4 - numOfTenpai);
          }
        });
      }
    }
    if (!tenpai[oya]!) {
      newState.currentKyoku = (newState.currentKyoku + 1) % 16;
    }
    newState.bonba++;
    state = newState;
  }

  void updatePlayerPointTsumo(int point, Position position, Setting setting) {
    final newState = state.clone();
    //Position oya = currentOya();
    Position oya =
        Position.values[(setting.firstOya.index + newState.currentKyoku) % 4];
    if (position == oya) {
      point *= 2;
    }
    newState.players.forEach((key, value) {
      if (key == position) {
        if (key == oya) {
          value.point += (point + 99) ~/ 100 * 100 * 3 +
              newState.bonba * setting.bonbaPoint +
              newState.riichibou * setting.riichibouPoint;
        } else {
          value.point += (point + 99) ~/ 100 * 100 * 2 +
              (point * 2 + 99) ~/ 100 * 100 +
              newState.bonba * setting.bonbaPoint +
              newState.riichibou * setting.riichibouPoint;
        }
      } else {
        if (key == oya) {
          value.point -= (point * 2 + 99) ~/ 100 * 100 +
              newState.bonba * setting.bonbaPoint ~/ 3;
        } else {
          value.point -= (point + 99) ~/ 100 * 100 +
              newState.bonba * setting.bonbaPoint ~/ 3;
        }
      }
    });
    if (position != oya) {
      newState.bonba = 0;
    }

    newState.riichibou = 0;
    state = newState;
  }
}
