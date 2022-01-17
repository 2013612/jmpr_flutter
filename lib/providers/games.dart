import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../models/game.dart';

final gamesProvider = Provider<List<Game>>(
  (ref) => [],
);

final indexProvider = StateProvider((_) => Tuple2<int, int>(0, 0));

void removeUnusedGameAndPointSetting(WidgetRef ref) {
  final games = ref.watch(gamesProvider);
  final index = ref.watch(indexProvider);

  if (index.item1 + 1 < games.length) {
    games.removeRange(index.item1 + 1, games.length);
  }

  if (index.item2 + 1 < games[index.item1].pointSettings.length) {
    games[index.item1]
        .pointSettings
        .removeRange(index.item2 + 1, games[index.item1].pointSettings.length);
  }
}
