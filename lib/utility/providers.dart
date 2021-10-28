import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/classes/history.dart';
import 'package:jmpr_flutter/classes/player.dart';
import 'package:jmpr_flutter/classes/point_setting.dart';

import '../classes/setting.dart';
import 'constant.dart';

final settingProvider = StateProvider(
  (_) => Setting(
    startingPoint: 30000,
    givenStartingPoint: 25000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 20,
    umaSmall: 10,
    isKiriage: false,
    isDouten: false,
    firstOya: Position.bottom,
  ),
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
