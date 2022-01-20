import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/game.dart';
import '../../models/point_setting.dart';
import '../../models/setting.dart';
import '../../providers/games.dart';
import '../../utility/constant.dart';
import '../../utility/validators.dart';
import 'local_widgets/main_landscape.dart';
import 'local_widgets/main_portrait.dart';
import 'local_widgets/my_app_bar.dart';
import 'local_widgets/my_bottom_app_bar.dart';

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Validators.context = context;
    Constant.changeLanguage(context);
    if (ref.watch(gamesProvider).isEmpty) {
      ref.watch(gamesProvider).add(
            Game(
              gamePlayers: [],
              createdAt: DateTime.now(),
              setting: Setting(),
              transactions: [],
              pointSettings: [PointSetting.fromSetting(Setting())],
            ),
          );
    }
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: MyAppBar(),
        body: MainPortrait(),
        bottomNavigationBar: MyBottomAppBar(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: MyAppBar(),
        body: MainLandscape(),
        bottomNavigationBar: MyBottomAppBar(),
      );
    }
  }
}
