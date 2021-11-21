import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/history.dart';
import '../classes/point_setting.dart';
import '../classes/setting.dart';
import 'constant.dart';

final settingProvider = StateProvider(
  (_) => Setting(),
);

final pointSettingProvider = StateProvider(
  (ref) {
    final setting = ref.watch(settingProvider).state;

    return PointSetting.fromSetting(setting);
  },
);

final historyProvider = Provider(
  (ref) => [
    History(
      pointSetting: ref.watch(pointSettingProvider).state.clone(),
      setting: ref.watch(settingProvider).state.clone(),
    )
  ],
);

final historyIndexProvider = StateProvider((_) => 1);

final localeProvider = StateProvider((_) => Locale('ja'));

class PointSettingNotifier extends StateNotifier<PointSetting> {
  PointSettingNotifier(Setting setting)
      : super(PointSetting.fromSetting(setting));

  void setRiichiFalse() {
    for (Position position in Position.values) {
      state.players[position]!.riichi = false;
    }
  }
}
