import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/histories.dart';
import 'package:jmpr_flutter/providers/point_setting.dart';
import 'package:jmpr_flutter/providers/setting.dart';

import '../../../classes/history.dart';
import '../../../common_widgets/base_bar_button.dart';
import '../../../utility/constant.dart';
import '../../ron/ron.dart';
import '../../ryukyoku/ryukyoku.dart';
import '../../tsumo/tsumo.dart';

class MyBottomAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    var index = ref.watch(historyIndexProvider).state;
    final histories = ref.watch(historiesProvider);

    void setRiichiFalse() {
      ref.read(pointSettingProvider.notifier).setRiichiFalse();
    }

    void addHistory() {
      if (index < histories.length) {
        histories.removeRange(index, histories.length);
      }
      ref.watch(historiesProvider).add(
            History(
              pointSetting: ref.watch(pointSettingProvider).clone(),
              setting: ref.watch(settingProvider).state.clone(),
            ),
          );
      index++;
    }

    void reset() {
      ref.refresh(pointSettingProvider);
      // for (Position position in Position.values) {
      //   pointSetting.players[position]!.riichi = false;
      //   pointSetting.players[position]!.point = setting.givenStartingPoint;
      // }
      // pointSetting.currentKyoku = 0;
      // pointSetting.bonba = 0;
      // pointSetting.riichibou = 0;
      addHistory();
    }

    void saveTsumo(Position tsumoPlayer, int han, int fu) {
      ref.read(pointSettingProvider.notifier).saveTsumo(tsumoPlayer, han, fu);
      addHistory();
      setRiichiFalse();
    }

    void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
        Map<Position, int> hans, Map<Position, int> fus) {
      ref
          .read(pointSettingProvider.notifier)
          .saveRon(ronedPlayer, ronPlayers, hans, fus);
      addHistory();
      setRiichiFalse();
    }

    void saveRyukyoku(
        Map<Position, bool> tenpai, Map<Position, bool> nagashimangan) {
      ref
          .read(pointSettingProvider.notifier)
          .saveRyukyoku(tenpai, nagashimangan);
      addHistory();
      setRiichiFalse();
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BaseBarButton(
              name: i18n.ron,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ron(next: saveRon)));
              }),
          BaseBarButton(
              name: i18n.tsumo,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tsumo(save: saveTsumo)));
              }),
          BaseBarButton(
              name: i18n.ryukyoku,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ryukyoku(save: saveRyukyoku)));
              }),
          BaseBarButton(
            name: i18n.reset,
            onPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
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
