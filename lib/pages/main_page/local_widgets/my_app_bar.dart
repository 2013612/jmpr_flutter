import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../classes/history.dart';
import '../../../utility/constant.dart';
import '../../../utility/providers.dart';
import '../../about/about.dart';
import '../../export_excel/export_excel.dart';
import '../../history/history.dart';
import '../../point_setting/point_setting.dart';
import '../../setting/setting.dart';
import 'language_dialog.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    var setting = ref.watch(settingProvider).state;
    var pointSetting = ref.watch(pointSettingProvider).state;
    var index = ref.watch(historyIndexProvider).state;
    final histories = ref.watch(historyProvider);

    void addHistory() {
      if (index < histories.length) {
        histories.removeRange(index, histories.length);
      }
      histories.add(
        History(
          pointSetting: ref.watch(pointSettingProvider).state.clone(),
          setting: ref.watch(settingProvider).state.clone(),
        ),
      );
      index++;
    }

    void reset() {
      for (Position position in Position.values) {
        pointSetting.players[position]!.riichi = false;
        pointSetting.players[position]!.point = setting.givenStartingPoint;
      }
      pointSetting.currentKyoku = 0;
      pointSetting.bonba = 0;
      pointSetting.riichibou = 0;
      addHistory();
    }

    void setRiichiFalse() {
      for (Position position in Position.values) {
        pointSetting.players[position]!.riichi = false;
      }
    }

    void saveSetting(Setting setting) {
      setting = setting;
      reset();
    }

    void savePointSetting(PointSetting pointSetting) {
      pointSetting = pointSetting;
      addHistory();
      setRiichiFalse();
    }

    Map<String, String> choices = {
      "pointSetting": AppLocalizations.of(context)!.pointSetting,
      "setting": AppLocalizations.of(context)!.setting,
      "history": AppLocalizations.of(context)!.history,
      "exportToXlsx": AppLocalizations.of(context)!.exportToXlsx,
      "language": AppLocalizations.of(context)!.language,
      "about": AppLocalizations.of(context)!.about,
    };
    return AppBar(
      title: FittedBox(
        child: Text(AppLocalizations.of(context)!.appTitle),
      ),
      actions: [
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return choices.entries.map((choice) {
              return PopupMenuItem<String>(
                value: choice.key,
                child: Text(choice.value),
              );
            }).toList();
          },
          icon: Icon(
            Icons.menu,
          ),
          onSelected: (string) {
            switch (string) {
              case "pointSetting":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PointSetting(
                      save: savePointSetting,
                    ),
                  ),
                );
                break;
              case "setting":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(
                      save: saveSetting,
                    ),
                  ),
                );
                break;
              case "language":
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => LanguageDialog(),
                );
                break;
              case "exportToXlsx":
                if (histories.length < 2) {
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.errorAtLeastTwoRecords,
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseHistory(),
                  ),
                );
                break;
              case "history":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(),
                  ),
                );
                break;
              case "about":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
                break;
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
