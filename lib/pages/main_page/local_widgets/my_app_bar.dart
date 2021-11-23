import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../classes/history.dart';
import '../../../classes/point_setting.dart' as class_ps;
import '../../../classes/setting.dart' as class_s;
import '../../../providers/histories.dart';
import '../../../providers/point_setting.dart';
import '../../../providers/setting.dart';
import '../../about/about.dart';
import '../../export_excel/export_excel.dart';
import '../../history/history.dart';
import '../../point_setting/point_setting.dart';
import '../../setting/setting.dart';
import 'language_dialog.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    var index = ref.watch(historyIndexProvider).state;
    final histories = ref.watch(historiesProvider);

    void addHistory() {
      if (index < histories.length) {
        histories.removeRange(index, histories.length);
      }
      histories.add(
        History(
          pointSetting: ref.watch(pointSettingProvider).clone(),
          setting: ref.watch(settingProvider).state.clone(),
        ),
      );
      ref.watch(historyIndexProvider).state++;
    }

    void reset() {
      ref.refresh(pointSettingProvider);
      addHistory();
    }

    void setRiichiFalse() {
      ref.read(pointSettingProvider.notifier).setRiichiFalse();
    }

    void saveSetting(class_s.Setting newSetting) {
      ref.watch(settingProvider).state = newSetting;
      reset();
    }

    void savePointSetting(class_ps.PointSetting pointSetting) {
      ref.read(pointSettingProvider.notifier).newPointSetting(pointSetting);
      addHistory();
      setRiichiFalse();
    }

    Map<String, String> choices = {
      "pointSetting": i18n.pointSetting,
      "setting": i18n.setting,
      "history": i18n.history,
      "exportToXlsx": i18n.exportToXlsx,
      "language": i18n.language,
      "about": i18n.about,
    };
    return AppBar(
      title: FittedBox(
        child: Text(i18n.appTitle),
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
                    msg: i18n.errorAtLeastTwoRecords,
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
}
