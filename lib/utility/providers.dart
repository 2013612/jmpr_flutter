import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/history.dart';
import '../classes/player.dart';
import '../classes/point_setting.dart';
import '../classes/setting.dart';
import 'constant.dart';

final settingProvider = StateProvider(
  (_) => Setting(),
);

final pointSettingProvider = StateProvider(
  (ref) {
    final setting = ref.watch(settingProvider).state;
    Map<Position, Player> players = {};
    for (Position position in Position.values) {
      players[position] = Player(
        position: position,
        point: setting.givenStartingPoint,
        riichi: false,
      );
    }
    return PointSetting(
      players: players,
      currentKyoku: 0,
      bonba: 0,
      riichibou: 0,
    );
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
