import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../../classes/point_setting.dart';
import '../../../common_widgets/base_bar_button.dart';
import '../../../models/game.dart';
import '../../../models/setting.dart';
import '../../../providers/games.dart';
import '../../ron/ron.dart';
import '../../ryukyoku/ryukyoku.dart';
import '../../tsumo/tsumo.dart';

class MyBottomAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;

    void reset() {
      final index = ref.watch(indexProvider);

      ref.watch(gamesProvider).add(
            Game(
              gamePlayers: [],
              createdAt: DateTime.now(),
              setting: Setting(),
              transactions: [],
              pointSettings: [PointSetting.fromSetting(Setting())],
            ),
          );
      ref.watch(indexProvider.state).state = Tuple2(index.item1 + 1, 0);
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BaseBarButton(
              name: i18n.ron,
              onPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Ron()));
              }),
          BaseBarButton(
              name: i18n.tsumo,
              onPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Tsumo()));
              }),
          BaseBarButton(
              name: i18n.ryukyoku,
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ryukyoku()));
              }),
          BaseBarButton(
            name: i18n.reset,
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(i18n.confirm),
                  content: Text(i18n.confirmReset),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(i18n.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        reset();
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
