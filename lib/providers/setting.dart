import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/setting.dart';

final settingProvider = StateProvider(
  (_) => Setting(),
);
