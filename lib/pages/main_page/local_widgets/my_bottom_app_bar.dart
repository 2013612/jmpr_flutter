import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/base_bar_button.dart';
import '../../../models/game.dart';
import '../../../models/point_setting.dart';
import '../../../models/setting.dart';
import '../../../providers/games_provider.dart';
import '../../../providers/indexes_provider.dart';
import '../../../utility/indexes.dart';
import '../../ron/ron.dart';
import '../../ryukyoku/ryukyoku.dart';
import '../../tsumo/tsumo.dart';

class MyBottomAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;

    void reset() {
      final indexes = ref.watch(indexesProvider);

      ref.watch(gamesProvider).add(
            Game(
              gamePlayers: [],
              createdAt: DateTime.now(),
              setting: Setting(),
              transactions: [],
              pointSettings: [PointSetting.fromSetting(Setting())],
            ),
          );
      ref.watch(indexesProvider.state).state =
          Indexes(indexes.gameIndex + 1, 0);
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
