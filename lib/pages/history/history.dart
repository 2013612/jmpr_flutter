import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/histories.dart';
import 'package:jmpr_flutter/providers/point_setting.dart';
import 'package:jmpr_flutter/providers/setting.dart';

import '../../utility/constant.dart';

class HistoryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final ShapeBorder _shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    );
    final histories = ref.watch(historiesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.history),
      ),
      body: ListView(
        children: histories.reversed
            .map(
              (history) => ListTile(
                leading: Text(
                    "${Constant.kyokus[history.pointSetting.currentKyoku]} - ${history.pointSetting.bonba}"),
                title: FittedBox(
                  child: Text(
                    history.pointSetting.players.entries.fold(
                        "",
                        (previousValue, player) =>
                            "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
                  ),
                ),
                shape: _shapeBorder,
                dense: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(i18n.confirm),
                        content: Text(i18n.confirmHistory),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(i18n.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref.watch(settingProvider).state =
                                  history.setting.clone();
                              ref
                                  .read(pointSettingProvider.notifier)
                                  .newPointSetting(
                                      history.pointSetting.clone());
                              ref.watch(historyIndexProvider).state =
                                  histories.indexOf(history) + 1;
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
