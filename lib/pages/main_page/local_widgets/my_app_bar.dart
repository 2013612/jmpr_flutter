import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import '../../../classes/history.dart';
import '../../../classes/point_setting.dart' as class_ps;
import '../../../classes/setting.dart' as class_s;
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

    Map<Position, double> calResult(History history) {
      final class_ps.PointSetting _pointSetting = history.pointSetting;
      final class_s.Setting _setting = history.setting;
      List<List<int>> cal = [];
      Position position(int index) {
        return Position.values[(_setting.firstOya.index + cal[index][1]) % 4];
      }

      for (Position position in Position.values) {
        cal.add([
          _pointSetting.players[position]!.point - _setting.startingPoint,
          (Position.values.indexOf(position) -
                  Position.values.indexOf(_setting.firstOya) +
                  4) %
              4,
        ]);
      }

      cal.sort((List<int> a, List<int> b) {
        if (a[0] == b[0]) {
          return a[1] - b[1];
        } else {
          return b[0] - a[0];
        }
      });

      Map<Position, double> marks = {};
      double topBonus =
          4 * (_setting.startingPoint - _setting.givenStartingPoint) / 1000;
      if (_setting.isDouten) {
        if (cal[0][0] == cal[1][0] &&
            cal[1][0] == cal[2][0] &&
            cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus / 4;
          marks[position(1)] = cal[1][0] / 1000 + topBonus / 4;
          marks[position(2)] = cal[2][0] / 1000 + topBonus / 4;
          marks[position(3)] = cal[3][0] / 1000 + topBonus / 4;
        } else if (cal[0][0] == cal[1][0] && cal[1][0] == cal[2][0]) {
          marks[position(0)] =
              cal[0][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(1)] =
              cal[1][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(2)] =
              cal[2][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[1][0] == cal[2][0] && cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 - _setting.umaBig / 3;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaBig / 3;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig / 3;
        } else if (cal[0][0] == cal[1][0] && cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(1)] = cal[1][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(2)] =
              cal[2][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
          marks[position(3)] =
              cal[3][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
        } else if (cal[0][0] == cal[1][0]) {
          marks[position(0)] = cal[0][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(1)] = cal[1][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[1][0] == cal[2][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000;
          marks[position(2)] = cal[2][0] / 1000;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
          marks[position(2)] =
              cal[2][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
          marks[position(3)] =
              cal[3][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
        } else {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        }
      } else {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
        marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
        marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
      }
      return marks;
    }

    Future<Excel?> createExcelFile(
      String folder,
      String fileName,
      String sheetName,
    ) async {
      Excel? excel;
      try {
        final bytes = File(join(folder, "$fileName.xlsx")).readAsBytesSync();
        excel = Excel.decodeBytes(bytes);
        if (excel.tables.keys.contains(sheetName)) {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(AppLocalizations.of(context)!
                        .warningExistingSheetName(sheetName, fileName)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          OpenFile.open(join(folder, "$fileName.xlsx"));
                          Navigator.pop(context);
                        },
                        child: Text(
                            AppLocalizations.of(context)!.openExcel(fileName)),
                      ),
                    ],
                  ));
          return null;
        }
      } catch (exception) {
        print(exception);
      }
      if (excel == null) {
        excel = Excel.createExcel();
        excel.rename("Sheet1", sheetName);
      }
      return excel;
    }

    Future<bool> generateExcel(
      int startIndex,
      int endIndex,
      String folder,
      String fileName,
      String sheetName,
      Map<Position, String> playerNames,
    ) async {
      Excel? excel = await createExcelFile(folder, fileName, sheetName);
      if (excel == null) {
        return false;
      }
      final int topRow = 2;
      final class_s.Setting _setting = histories[endIndex].setting;

      CellIndex cell(int col, int row) {
        return CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row);
      }

      Position position(int index) {
        return Position.values[(_setting.firstOya.index + index) % 4];
      }

      Map<Position, double> marks = calResult(histories[endIndex]);

      excel.updateCell(
          sheetName, cell(0, 1), AppLocalizations.of(context)!.kyoku);
      excel.updateCell(
          sheetName, cell(1, 1), AppLocalizations.of(context)!.oya);
      List.generate(4, (index) {
        excel.merge(sheetName, cell(2 + 3 * index, 0), cell(4 + 3 * index, 0),
            customValue: playerNames[position(index)]);
        excel.updateCell(sheetName, cell(2 + 3 * index, 1),
            AppLocalizations.of(context)!.riichi);
        excel.updateCell(sheetName, cell(3 + 3 * index, 1),
            AppLocalizations.of(context)!.pointVariation);
        excel.updateCell(sheetName, cell(4 + 3 * index, 1),
            AppLocalizations.of(context)!.currentPoint);
        excel.updateCell(
            sheetName,
            cell(4 + 3 * index, endIndex - startIndex + topRow),
            histories[endIndex].pointSetting.players[position(index)]!.point);
        excel.updateCell(
            sheetName,
            cell(4 + 3 * index, endIndex - startIndex + 1 + topRow),
            marks[position(index)]);
      });
      excel.updateCell(
          sheetName, cell(14, 1), AppLocalizations.of(context)!.kyoutaku);

      void updateExcelKyoku(int row, int pos) {
        excel.updateCell(
            sheetName,
            cell(2 + pos * 3, row + topRow - startIndex),
            histories[row + 1]
                .pointSetting
                .players[position(pos)]!
                .riichi
                .toString()
                .toUpperCase());
        excel.updateCell(
            sheetName,
            cell(3 + pos * 3, row + topRow - startIndex),
            histories[row + 1].pointSetting.players[position(pos)]!.point -
                histories[row].pointSetting.players[position(pos)]!.point);
        excel.updateCell(
            sheetName,
            cell(4 + pos * 3, row + topRow - startIndex),
            histories[row].pointSetting.players[position(pos)]!.point);
      }

      for (int i = startIndex; i < endIndex; i++) {
        excel.updateCell(sheetName, cell(0, i - startIndex + topRow),
            "${Constant.kyokus[histories[i].pointSetting.currentKyoku]} ${histories[i].pointSetting.bonba}${AppLocalizations.of(context)!.bonba}");
        excel.updateCell(
            sheetName,
            cell(1, i - startIndex + topRow),
            playerNames[Position.values[(_setting.firstOya.index +
                    histories[i].pointSetting.currentKyoku) %
                4]]);
        List.generate(4, (index) => updateExcelKyoku(i, index));
        excel.updateCell(sheetName, cell(14, i - startIndex + topRow),
            histories[i + 1].pointSetting.riichibou * _setting.riichibouPoint);
      }

      var fileBytes = excel.save();

      File(join(folder, "$fileName.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      Fluttertoast.showToast(
        msg: i18n.generateSuccess(fileName),
        backgroundColor: Colors.blue,
      );
      OpenFile.open(join(folder, "$fileName.xlsx"));

      // excel.encode().then((onValue) {
      //   File(join(folder, "$fileName.xlsx"))
      //     ..createSync(recursive: true)
      //     ..writeAsBytesSync(onValue);
      //   Fluttertoast.showToast(
      //     msg: i18n.generateSuccess(fileName),
      //     backgroundColor: Colors.blue,
      //   );
      //   OpenFile.open(join(folder, "$fileName.xlsx"));
      // }).catchError((error) {
      //   Fluttertoast.showToast(
      //       msg: "${i18n.error}${": $error"}", backgroundColor: Colors.red);
      // });
      return true;
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
                    builder: (context) => ChooseHistory(
                      histories: histories,
                      next: generateExcel,
                    ),
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
