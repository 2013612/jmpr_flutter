import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import 'about.dart';
import 'classes/history.dart';
import 'classes/player.dart';
import 'classes/point_setting.dart' as class_ps;
import 'classes/setting.dart' as class_s;
import 'common.dart';
import 'common_widgets/base_bar_button.dart';
import 'export_excel.dart';
import 'history.dart';
import 'language_dialog.dart';
import 'locale.dart';
import 'point_setting.dart';
import 'ron.dart';
import 'ryukyoku.dart';
import 'setting.dart';
import 'tsumo.dart';

class Layout extends StatefulWidget {
  final SetAppLocaleDelegate setAppLocaleDelegate;
  final Locale? locale;

  Layout(this.locale, this.setAppLocaleDelegate);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final Color _firstOyaColor = Colors.yellow;
  final Color _textColor = Colors.white;
  late class_s.Setting _currentSetting;
  late class_ps.PointSetting _currentPointSetting;
  final List<History> _histories = [];
  int _currentHistoryIndex = 0;
  late String _language;

  void addHistory() {
    if (_currentHistoryIndex < _histories.length) {
      _histories.removeRange(_currentHistoryIndex, _histories.length);
    }
    _histories.add(History(
        pointSetting: _currentPointSetting.clone(),
        setting: _currentSetting.clone()));
    _currentHistoryIndex++;
  }

  @override
  void initState() {
    super.initState();
    _currentSetting = class_s.Setting(
      startingPoint: 30000,
      givenStartingPoint: 25000,
      riichibouPoint: 1000,
      bonbaPoint: 300,
      ryukyokuPoint: 3000,
      umaBig: 20,
      umaSmall: 10,
      isKiriage: false,
      isDouten: false,
      firstOya: Position.bottom,
    );
    Map<Position, Player> players = {};
    for (Position position in Position.values) {
      players[position] = Player(
        position: position,
        point: _currentSetting.givenStartingPoint,
        riichi: false,
      );
    }
    _currentPointSetting = class_ps.PointSetting(
      players: players,
      currentKyoku: 0,
      bonba: 0,
      riichibou: 0,
    );
    addHistory();
    _currentHistoryIndex = 1;
    _language = widget.locale!.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    Constant.languageChange(context);
    Map<String, String> choices = {
      "pointSetting": AppLocalizations.of(context)!.pointSetting,
      "setting": AppLocalizations.of(context)!.setting,
      "history": AppLocalizations.of(context)!.history,
      "exportToXlsx": AppLocalizations.of(context)!.exportToXlsx,
      "language": AppLocalizations.of(context)!.language,
      "about": AppLocalizations.of(context)!.about,
    };

    void setRiichiFalse() {
      for (Position position in Position.values) {
        _currentPointSetting.players[position]!.riichi = false;
      }
    }

    void reset() {
      for (Position position in Position.values) {
        _currentPointSetting.players[position]!.riichi = false;
        _currentPointSetting.players[position]!.point =
            _currentSetting.givenStartingPoint;
      }
      _currentPointSetting.currentKyoku = 0;
      _currentPointSetting.bonba = 0;
      _currentPointSetting.riichibou = 0;
      addHistory();
    }

    void goToHistory(History history) {
      setState(() {
        _currentPointSetting = history.pointSetting.clone();
        _currentSetting = history.setting.clone();
        _currentHistoryIndex = _histories.indexOf(history) + 1;
      });
    }

    void saveSetting(class_s.Setting setting) {
      setState(() {
        _currentSetting = setting;
        reset();
      });
    }

    void savePointSetting(class_ps.PointSetting pointSetting) {
      setState(() {
        _currentPointSetting = pointSetting;
        addHistory();
        setRiichiFalse();
      });
    }

    Position currentOya() {
      return Position.values[
          (_currentSetting.firstOya.index + _currentPointSetting.currentKyoku) %
              4];
    }

    void updatePlayerPointTsumo(int point, Position position) {
      Position oya = currentOya();
      if (position == oya) {
        point *= 2;
      }
      _currentPointSetting.players.forEach((key, value) {
        if (key == position) {
          if (key == oya) {
            value.point += (point + 99) ~/ 100 * 100 * 3 +
                _currentPointSetting.bonba * _currentSetting.bonbaPoint +
                _currentPointSetting.riichibou * _currentSetting.riichibouPoint;
          } else {
            value.point += (point + 99) ~/ 100 * 100 * 2 +
                (point * 2 + 99) ~/ 100 * 100 +
                _currentPointSetting.bonba * _currentSetting.bonbaPoint +
                _currentPointSetting.riichibou * _currentSetting.riichibouPoint;
          }
        } else {
          if (key == oya) {
            value.point -= (point * 2 + 99) ~/ 100 * 100 +
                _currentPointSetting.bonba * _currentSetting.bonbaPoint ~/ 3;
          } else {
            value.point -= (point + 99) ~/ 100 * 100 +
                _currentPointSetting.bonba * _currentSetting.bonbaPoint ~/ 3;
          }
        }
      });
      if (position != oya) {
        _currentPointSetting.bonba = 0;
      }

      _currentPointSetting.riichibou = 0;
    }

    int calPoint(int han, int fu) {
      int point = (pow(2, han + 2) * fu).toInt();
      if (point > 1920) {
        point = Constant.points[han]!;
      } else if (point == 1920 && _currentSetting.isKiriage) {
        point = 2000;
      }
      return point;
    }

    void saveTsumo(Position tsumoPlayer, int han, int fu) {
      int point = calPoint(han, fu);
      Position oya = currentOya();
      setState(() {
        updatePlayerPointTsumo(point, tsumoPlayer);
        if (tsumoPlayer == oya) {
          _currentPointSetting.bonba++;
        } else {
          _currentPointSetting.bonba = 0;
          _currentPointSetting.currentKyoku =
              (_currentPointSetting.currentKyoku + 1) % 16;
        }
        addHistory();
        setRiichiFalse();
      });
    }

    void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
        Map<Position, int> hans, Map<Position, int> fus) {
      Position oya = currentOya();
      setState(() {
        int nearIndex = 100;
        ronPlayers.forEach((key, value) {
          if (value) {
            int point = calPoint(hans[key]!, fus[key]!);
            if (key == oya) {
              point = (point * 6 + 99) ~/ 100 * 100;
            } else {
              point = (point * 4 + 99) ~/ 100 * 100;
            }
            _currentPointSetting.players[key]!.point += point;
            _currentPointSetting.players[ronedPlayer]!.point -= point;
            nearIndex =
                min(nearIndex, ((key.index - ronedPlayer.index) + 4) % 4);
          }
        });
        nearIndex = (nearIndex + ronedPlayer.index) % 4;
        _currentPointSetting.players[ronedPlayer]!.point -=
            _currentPointSetting.bonba * _currentSetting.bonbaPoint;
        _currentPointSetting.players[Position.values[nearIndex]]!.point +=
            _currentPointSetting.bonba * _currentSetting.bonbaPoint +
                _currentPointSetting.riichibou * _currentSetting.riichibouPoint;
        _currentPointSetting.riichibou = 0;
        if (ronPlayers[oya]!) {
          _currentPointSetting.bonba++;
        } else {
          _currentPointSetting.bonba = 0;
          _currentPointSetting.currentKyoku =
              (_currentPointSetting.currentKyoku + 1) % 16;
        }
        addHistory();
        setRiichiFalse();
      });
    }

    void saveRyukyoku(
        Map<Position, bool> tenpai, Map<Position, bool> nagashimangan) {
      int numOfTenpai = 0;
      int numOfNagashimagan = 0;
      tenpai.forEach((key, value) {
        if (value) numOfTenpai++;
      });
      nagashimangan.forEach((key, value) {
        if (value) numOfNagashimagan++;
      });
      Position oya = currentOya();
      setState(() {
        if (numOfNagashimagan > 0) {
          int? bonba = _currentPointSetting.bonba;
          int? riichibou = _currentPointSetting.riichibou;
          _currentPointSetting.bonba = 0;
          _currentPointSetting.riichibou = 0;
          nagashimangan.forEach((key, value) {
            if (value) {
              updatePlayerPointTsumo(2000, key);
            }
          });
          _currentPointSetting.bonba = bonba;
          _currentPointSetting.riichibou = riichibou;
        } else {
          if (numOfTenpai != 0 && numOfTenpai != 4) {
            tenpai.forEach((key, value) {
              if (value) {
                _currentPointSetting.players[key]!.point +=
                    _currentSetting.ryukyokuPoint ~/ numOfTenpai;
              } else {
                _currentPointSetting.players[key]!.point -=
                    _currentSetting.ryukyokuPoint ~/ (4 - numOfTenpai);
              }
            });
          }
        }
        if (!tenpai[oya]!) {
          _currentPointSetting.currentKyoku =
              (_currentPointSetting.currentKyoku + 1) % 16;
        }
        _currentPointSetting.bonba++;
        addHistory();
        setRiichiFalse();
      });
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

    void showResult() {
      Map<Position, double> marks = calResult(_histories.last);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.result),
          content: Column(
            children: marks.entries
                .map((mark) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Constant.positionTexts[mark.key]!,
                          ),
                        ),
                        Text(
                          mark.value.toStringAsFixed(2),
                        ),
                      ],
                    ))
                .toList(),
          ),
          scrollable: true,
        ),
      );
    }

    Future<Excel?> createExcelFile(
        String folder, String fileName, String sheetName) async {
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
        Map<Position, String> playerNames) async {
      Excel? excel = await createExcelFile(folder, fileName, sheetName);
      if (excel == null) {
        return false;
      }
      final int topRow = 2;
      final class_s.Setting _setting = _histories[endIndex].setting;

      CellIndex cell(int col, int row) {
        return CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row);
      }

      Position position(int index) {
        return Position.values[(_setting.firstOya.index + index) % 4];
      }

      Map<Position, double> marks = calResult(_histories[endIndex]);

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
            _histories[endIndex].pointSetting.players[position(index)]!.point);
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
            _histories[row + 1]
                .pointSetting
                .players[position(pos)]!
                .riichi
                .toString()
                .toUpperCase());
        excel.updateCell(
            sheetName,
            cell(3 + pos * 3, row + topRow - startIndex),
            _histories[row + 1].pointSetting.players[position(pos)]!.point -
                _histories[row].pointSetting.players[position(pos)]!.point);
        excel.updateCell(
            sheetName,
            cell(4 + pos * 3, row + topRow - startIndex),
            _histories[row].pointSetting.players[position(pos)]!.point);
      }

      for (int i = startIndex; i < endIndex; i++) {
        excel.updateCell(sheetName, cell(0, i - startIndex + topRow),
            "${Constant.kyokus[_histories[i].pointSetting.currentKyoku]} ${_histories[i].pointSetting.bonba}${AppLocalizations.of(context)!.bonba}");
        excel.updateCell(
            sheetName,
            cell(1, i - startIndex + topRow),
            playerNames[Position.values[(_setting.firstOya.index +
                    _histories[i].pointSetting.currentKyoku) %
                4]]);
        List.generate(4, (index) => updateExcelKyoku(i, index));
        excel.updateCell(sheetName, cell(14, i - startIndex + topRow),
            _histories[i + 1].pointSetting.riichibou * _setting.riichibouPoint);
      }

      // excel.encode().then((onValue) {
      //   File(join(folder, "$fileName.xlsx"))
      //     ..createSync(recursive: true)
      //     ..writeAsBytesSync(onValue);
      //   Fluttertoast.showToast(
      //     msg: AppLocalizations.of(context).generateSuccess(fileName),
      //     backgroundColor: Colors.blue,
      //   );
      //   OpenFile.open(join(folder, "$fileName.xlsx"));
      // }).catchError((error) {
      //   Fluttertoast.showToast(
      //       msg: "${AppLocalizations.of(context).error}${": $error"}",
      //       backgroundColor: Colors.red);
      // });
      return true;
    }

    Widget pointAndRiichiSwitch(Position position) {
      String sittingText = Constant.sittingTexts[(position.index -
              (_currentSetting.firstOya.index +
                  _currentPointSetting.currentKyoku) +
              8) %
          4];
      return GestureDetector(
        onTap: () {
          setState(() {
            if (!_currentPointSetting.players[position]!.riichi) {
              _currentPointSetting.riichibou++;
              _currentPointSetting.players[position]!.point -= 1000;
              _currentPointSetting.players[position]!.riichi = true;
            } else {
              _currentPointSetting.riichibou--;
              _currentPointSetting.players[position]!.point += 1000;
              _currentPointSetting.players[position]!.riichi = false;
            }
          });
        },
        child: Column(
          children: [
            Spacer(),
            Image.asset(_currentPointSetting.players[position]!.riichi
                ? "assets/riichibou.png"
                : "assets/no_riichibou.png"),
            Text(
              "$sittingText ${_currentPointSetting.players[position]!.point}",
              style: TextStyle(
                color: _currentSetting.firstOya == position
                    ? _firstOyaColor
                    : _textColor,
                fontSize: 20.0,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      );
    }

    PreferredSizeWidget myAppBar() {
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
                              currentPointSetting: _currentPointSetting,
                              save: savePointSetting,
                            )),
                  );
                  break;
                case "setting":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Setting(
                              currentSetting: _currentSetting,
                              save: saveSetting,
                            )),
                  );
                  break;
                case "language":
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => LanguageDialog(
                      changeLanguageTo: (String lang) {
                        setState(() {
                          _language = lang;
                        });
                        widget.setAppLocaleDelegate
                            .setLocale(supportedLocales[_language]!);
                        Constant.languageChange(context);
                      },
                      initialValue: _language,
                    ),
                  );
                  break;
                case "exportToXlsx":
                  if (_histories.length < 2) {
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
                        histories: _histories,
                        next: generateExcel,
                      ),
                    ),
                  );
                  break;
                case "history":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(
                        histories: _histories,
                        goTo: goToHistory,
                      ),
                    ),
                  );
                  break;
                case "about":
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                  break;
              }
            },
          ),
        ],
      );
    }

    Widget myBottomAppBar() {
      return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BaseBarButton(
                name: AppLocalizations.of(context)!.ron,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ron(next: saveRon)));
                }),
            BaseBarButton(
                name: AppLocalizations.of(context)!.tsumo,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tsumo(save: saveTsumo)));
                }),
            BaseBarButton(
                name: AppLocalizations.of(context)!.ryukyoku,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ryukyoku(save: saveRyukyoku)));
                }),
            BaseBarButton(
                name: AppLocalizations.of(context)!.reset,
                onPress: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.confirm),
                      content: Text(AppLocalizations.of(context)!.confirmReset),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(reset);
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      );
    }

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: myAppBar(),
        body: Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              EmptyGrid(),
              Center(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: pointAndRiichiSwitch(Position.top),
                ),
              ),
              EmptyGrid(),
              Center(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: pointAndRiichiSwitch(Position.left),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      Constant.kyokus[_currentPointSetting.currentKyoku]!,
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "${_currentPointSetting.bonba} 本場",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "供托: ${_currentPointSetting.riichibou}",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: pointAndRiichiSwitch(Position.right),
                ),
              ),
              EmptyGrid(),
              Center(
                child: pointAndRiichiSwitch(Position.bottom),
              ),
              FractionallySizedBox(
                heightFactor: 0.3,
                widthFactor: 0.6,
                child: ElevatedButton(
                  onPressed: showResult,
                  child: Text(AppLocalizations.of(context)!.result),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: myBottomAppBar(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: myAppBar(),
        body: Row(
          children: [
            Spacer(),
            Flexible(
              child: RotatedBox(
                quarterTurns: 1,
                child: pointAndRiichiSwitch(Position.left),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: pointAndRiichiSwitch(Position.top),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                Flexible(child: pointAndRiichiSwitch(Position.bottom)),
              ],
            ),
            Flexible(
              child: RotatedBox(
                quarterTurns: 3,
                child: pointAndRiichiSwitch(Position.right),
              ),
            ),
            Spacer(),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    Constant.kyokus[_currentPointSetting.currentKyoku]!,
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${_currentPointSetting.bonba} 本場",
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "供托: ${_currentPointSetting.riichibou}",
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: showResult,
              child: Text(AppLocalizations.of(context)!.result),
            ),
            Spacer(),
          ],
        ),
        bottomNavigationBar: myBottomAppBar(),
      );
    }
  }
}

class EmptyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
