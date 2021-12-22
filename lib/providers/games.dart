import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../models/game.dart';

final gamesProvider = Provider<List<Game>>(
  (ref) => [],
);

final indexProvider = StateProvider((_) => Tuple2<int, int>(0, 0));
