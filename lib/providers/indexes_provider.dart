import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utility/indexes.dart';

final indexesProvider = StateProvider<Indexes>((_) => Indexes(0, 0));
