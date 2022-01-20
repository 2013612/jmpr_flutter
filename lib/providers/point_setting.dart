import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/player.dart';
import '../models/point_setting.dart';
import '../utility/enum/position.dart';

import 'games.dart';

final pointSettingProvider =
    StateNotifierProvider<PointSettingNotifier, PointSetting>((ref) {
  final games = ref.watch(gamesProvider);
  final indexes = ref.watch(indexProvider);
  return PointSettingNotifier(
      games[indexes.item1].pointSettings[indexes.item2]);
});

class PointSettingNotifier extends StateNotifier<PointSetting> {
  PointSettingNotifier(PointSetting pointSetting) : super(pointSetting);

  void toggleRiichi(Position position, int riichibouPoint) {
    if (!state.players[position]!.isRiichi) {
      var newPlayer = Player(
        point: state.players[position]!.point - riichibouPoint,
        isRiichi: true,
      );
      state.players[position] = newPlayer;
      state = state.copyWith(riichibou: state.riichibou + 1);
    } else {
      var newPlayer = Player(
        point: state.players[position]!.point + riichibouPoint,
        isRiichi: false,
      );
      state.players[position] = newPlayer;
      state = state.copyWith(riichibou: state.riichibou - 1);
    }
  }
}
