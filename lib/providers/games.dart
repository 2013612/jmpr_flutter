import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/game.dart';
import 'indexes_provider.dart';

final gamesProvider = Provider<List<Game>>(
  (ref) => [],
);

void removeUnusedGameAndPointSetting(WidgetRef ref) {
  final games = ref.watch(gamesProvider);
  final indexes = ref.watch(indexesProvider);

  if (indexes.gameIndex + 1 < games.length) {
    games.removeRange(indexes.gameIndex + 1, games.length);
  }

  if (indexes.pointSettingIndex + 1 <
      games[indexes.gameIndex].pointSettings.length) {
    games[indexes.gameIndex].pointSettings.removeRange(
        indexes.pointSettingIndex + 1,
        games[indexes.gameIndex].pointSettings.length);
  }
}
