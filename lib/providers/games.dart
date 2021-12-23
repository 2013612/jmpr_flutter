import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../models/game.dart';

final gamesProvider = Provider<List<Game>>(
  (ref) => [],
);

final indexProvider = StateProvider((_) => Tuple2<int, int>(0, 0));

void removeUnusedHistory(WidgetRef ref) {
  final games = ref.watch(gamesProvider);
  final index = ref.watch(indexProvider);

  if (index.item1 + 1 < games.length) {
    games.removeRange(index.item1 + 1, games.length);
  }

  if (index.item2 + 1 < games[index.item1].histories.length) {
    games[index.item1]
        .histories
        .removeRange(index.item2 + 1, games[index.item1].histories.length);
  }
}
