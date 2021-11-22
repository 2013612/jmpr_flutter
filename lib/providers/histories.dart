import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/history.dart';
import 'point_setting.dart';
import 'setting.dart';

final historiesProvider = Provider(
  (ref) => [
    History(
      pointSetting: ref.watch(pointSettingProvider).clone(),
      setting: ref.watch(settingProvider).state.clone(),
    )
  ],
);

final historyIndexProvider = StateProvider((_) => 1);
