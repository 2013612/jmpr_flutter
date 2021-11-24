import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import '../../classes/history.dart';
import '../../classes/point_setting.dart';
import '../../classes/setting.dart';
import '../../common_widgets/base_bar_button.dart';
import '../../providers/histories.dart';
import '../../utility/constant.dart';
import 'local_widgets/user_input.dart';

class ChooseHistory extends ConsumerStatefulWidget {
  @override
  _ChooseHistoryState createState() => _ChooseHistoryState();
}

class _ChooseHistoryState extends ConsumerState<ChooseHistory> {
  final List<int> chosen = [];
  late final List<History> reversedHistories;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    Map<Position, double> calResult(History history) {
      final PointSetting _pointSetting = history.pointSetting;
      final Setting _setting = history.setting;
      final List<List<int>> cal = [];
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

      final Map<Position, double> marks = {};
      final double topBonus =
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
                  child:
                      Text(AppLocalizations.of(context)!.openExcel(fileName)),
                ),
              ],
            ),
          );
          return null;
        }
      } on Exception catch (exception) {
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
      final histories = ref.watch(historiesProvider);
      final Setting _setting = histories[endIndex].setting;

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

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.history),
      ),
      body: ListView.builder(
        itemCount: reversedHistories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
                "${Constant.kyokus[reversedHistories[index].pointSetting.currentKyoku]} - ${reversedHistories[index].pointSetting.bonba}"),
            title: FittedBox(
              child: Text(
                reversedHistories[index].pointSetting.players.entries.fold(
                    "",
                    (previousValue, player) =>
                        "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            dense: true,
            selected: chosen.contains(index),
            onTap: () {
              if (chosen.contains(index)) {
                setState(() {
                  chosen.remove(index);
                });
              } else {
                if (chosen.length == 2) {
                  return;
                } else {
                  setState(() {
                    chosen.add(index);
                  });
                }
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BaseBarButton(
              name: i18n.cancel,
              onPress: () => Navigator.pop(context),
            ),
            BaseBarButton(
              name: i18n.next,
              onPress: () {
                if (chosen.length < 2) {
                  Fluttertoast.showToast(
                    msg: i18n.errorExactTwoRecords,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else if (!reversedHistories[chosen[0]]
                    .setting
                    .equal(reversedHistories[chosen[1]].setting)) {
                  Fluttertoast.showToast(
                    msg: i18n.errorSettingsAreDifferent,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else {
                  chosen[0] = reversedHistories.length - 1 - chosen[0];
                  chosen[1] = reversedHistories.length - 1 - chosen[1];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInput(
                        (String folder, String fileName, String sheetName,
                            Map<Position, String> playerNames) async {
                          bool success2 = true;
                          await generateExcel(
                                  min(chosen[0], chosen[1]),
                                  max(chosen[0], chosen[1]),
                                  folder,
                                  fileName,
                                  sheetName,
                                  playerNames)
                              .then((bool success) {
                            if (success) {
                              Navigator.pop(context);
                            } else {
                              success2 = false;
                            }
                          });
                          return success2;
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    reversedHistories = ref.read(historiesProvider).reversed.toList();
  }
}
