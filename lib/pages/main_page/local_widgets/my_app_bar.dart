import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/pages/user_info/sign_in_page.dart';

import '../../../providers/histories.dart';
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
    final histories = ref.watch(historiesProvider);

    Map<String, String> choices = {
      "pointSetting": i18n.pointSetting,
      "setting": i18n.setting,
      "history": i18n.history,
      "exportToXlsx": i18n.exportToXlsx,
      "language": i18n.language,
      "about": i18n.about,
      "userInfo": "userInfo",
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
                    builder: (context) => PointSetting(),
                  ),
                );
                break;
              case "setting":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
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
              case "userInfo":
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
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
