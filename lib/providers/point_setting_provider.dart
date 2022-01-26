import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/player.dart';
import '../models/point_setting.dart';
import '../utility/enum/position.dart';

import 'games_provider.dart';
import 'indexes_provider.dart';

final pointSettingProvider =
    StateNotifierProvider<PointSettingNotifier, PointSetting>((ref) {
  final games = ref.watch(gamesProvider);
  final indexes = ref.watch(indexesProvider);
  final pointSetting = games[indexes.gameIndex]
      .pointSettings[indexes.pointSettingIndex]
      .copyWith();
  return PointSettingNotifier(pointSetting.copyWith(
      players: pointSetting.players
          .map((key, player) => MapEntry(key, player.copyWith()))));
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
