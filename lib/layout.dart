import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:jmpr_flutter/history.dart';
import 'package:jmpr_flutter/languageDialog.dart';
import 'package:jmpr_flutter/locale.dart';
import 'package:jmpr_flutter/pointSetting.dart';
import 'package:jmpr_flutter/ron.dart';
import 'package:jmpr_flutter/ryukyoku.dart';
import 'package:jmpr_flutter/setting.dart';
import 'package:jmpr_flutter/common.dart';
import 'package:jmpr_flutter/tsumo.dart';
import 'package:jmpr_flutter/about.dart';

class Layout extends StatefulWidget {
  final SetAppLocaleDelegate setAppLocaleDelegate;
  final Locale locale;

  Layout(this.locale, this.setAppLocaleDelegate);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Position firstOya = Position.Bottom;
  final Color firstOyaColor = Colors.red[300];
  final Color nonFirstOyaColor = Colors.white;
  SettingParameter currentSetting;
  PointSettingParameter currentPointSetting;
  List<History> histories = [];
  int currentHistoryIndex = 0;
  String language;

  void addHistory() {
    if (currentHistoryIndex < histories.length) {
      histories.removeRange(currentHistoryIndex, histories.length);
    }
    histories.add(History(
        pointSetting: currentPointSetting.clone(),
        setting: currentSetting.clone()));
    currentHistoryIndex++;
  }

  @override
  void initState() {
    super.initState();
    currentSetting = SettingParameter(
      startingPoint: 30000,
      givenStartingPoint: 25000,
      riichibouPoint: 1000,
      bonbaPoint: 300,
      ryukyokuPoint: 3000,
      umaBig: 20,
      umaSmall: 10,
      kiriage: false,
      douten: false,
    );
    Map<Position, Player> players = Map();
    Position.values.forEach((element) {
      players[element] = Player(
          position: element,
          point: currentSetting.givenStartingPoint,
          riichi: false);
    });
    currentPointSetting = PointSettingParameter(
      players: players,
      currentKyoku: 0,
      bonba: 0,
      riichibou: 0,
    );
    addHistory();
    currentHistoryIndex = 1;
    language = widget.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    Constant.languageChange(context);
    Map<String, String> choices = {
      "pointSetting": AppLocalizations.of(context).pointSetting,
      "setting": AppLocalizations.of(context).setting,
      "history": AppLocalizations.of(context).history,
      "language": AppLocalizations.of(context).language,
      "about": AppLocalizations.of(context).about
    };

    void setRiichiFalse() {
      Position.values.forEach((element) {
        currentPointSetting.players[element].riichi = false;
      });
    }

    void reset() {
      Position.values.forEach((element) {
        currentPointSetting.players[element].riichi = false;
        currentPointSetting.players[element].point =
            currentSetting.givenStartingPoint;
      });
      currentPointSetting.currentKyoku = 0;
      currentPointSetting.bonba = 0;
      currentPointSetting.riichibou = 0;
      addHistory();
    }

    void saveHistory(History history) {
      setState(() {
        currentPointSetting = history.pointSetting.clone();
        currentSetting = history.setting.clone();
        currentHistoryIndex = histories.indexOf(history) + 1;
      });
    }

    void saveSetting(SettingParameter setting, Position newFirstOya) {
      setState(() {
        currentSetting = setting;
        firstOya = newFirstOya;
        reset();
      });
    }

    void savePointSetting(PointSettingParameter pointSetting) {
      setState(() {
        currentPointSetting = pointSetting;
        setRiichiFalse();
        addHistory();
      });
    }

    void updatePlayerPointTsumo(int point, Position position) {
      Position oya = Position
          .values[(firstOya.index + currentPointSetting.currentKyoku) % 4];
      if (position == oya) {
        point *= 2;
      }
      currentPointSetting.players.forEach((key, value) {
        if (key == position) {
          if (key == oya) {
            value.point += (point + 99) ~/ 100 * 100 * 3 +
                currentPointSetting.bonba * currentSetting.bonbaPoint +
                currentPointSetting.riichibou * currentSetting.riichibouPoint;
          } else {
            value.point += (point + 99) ~/ 100 * 100 * 2 +
                (point * 2 + 99) ~/ 100 * 100 +
                currentPointSetting.bonba * currentSetting.bonbaPoint +
                currentPointSetting.riichibou * currentSetting.riichibouPoint;
          }
        } else {
          if (key == oya) {
            value.point -= (point * 2 + 99) ~/ 100 * 100 +
                currentPointSetting.bonba * currentSetting.bonbaPoint ~/ 3;
          } else {
            value.point -= (point + 99) ~/ 100 * 100 +
                currentPointSetting.bonba * currentSetting.bonbaPoint ~/ 3;
          }
        }
      });
      currentPointSetting.bonba = 0;
      currentPointSetting.riichibou = 0;
    }

    int calPoint(int han, int fu) {
      int point = pow(2, han + 2) * fu;
      if (point > 1920) {
        point = Constant.points[han];
      } else if (point == 1920 && this.currentSetting.kiriage) {
        point = 2000;
      }
      return point;
    }

    void saveTsumo(Position tsumoPlayer, int han, int fu) {
      int point = calPoint(han, fu);
      setState(() {
        updatePlayerPointTsumo(point, tsumoPlayer);
        if (tsumoPlayer ==
            Position.values[
                (firstOya.index + currentPointSetting.currentKyoku) % 4]) {
          currentPointSetting.bonba++;
        } else {
          currentPointSetting.bonba = 0;
          currentPointSetting.currentKyoku =
              (currentPointSetting.currentKyoku + 1) % 16;
        }
        setRiichiFalse();
        addHistory();
      });
    }

    void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
        Map<Position, int> hans, Map<Position, int> fus) {
      Position oya = Position
          .values[(firstOya.index + currentPointSetting.currentKyoku) % 4];
      setState(() {
        int nearIndex = 100;
        ronPlayers.forEach((key, value) {
          if (value) {
            int point = calPoint(hans[key], fus[key]);
            if (key == oya) {
              point = (point * 6 + 99) ~/ 100 * 100;
            } else {
              point = (point * 4 + 99) ~/ 100 * 100;
            }
            currentPointSetting.players[key].point += point;
            currentPointSetting.players[ronedPlayer].point -= point;
            nearIndex =
                min(nearIndex, ((key.index - ronedPlayer.index) + 4) % 4);
          }
        });
        nearIndex = (nearIndex + ronedPlayer.index) % 4;
        currentPointSetting.players[ronedPlayer].point -=
            currentPointSetting.bonba * currentSetting.bonbaPoint;
        currentPointSetting.players[Position.values[nearIndex]].point +=
            currentPointSetting.bonba * currentSetting.bonbaPoint +
                currentPointSetting.riichibou * currentSetting.riichibouPoint;
        currentPointSetting.riichibou = 0;
        if (ronPlayers[oya]) {
          currentPointSetting.bonba++;
        } else {
          currentPointSetting.bonba = 0;
          currentPointSetting.currentKyoku =
              (currentPointSetting.currentKyoku + 1) % 16;
        }
        setRiichiFalse();
        addHistory();
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
      Position oya = Position
          .values[(firstOya.index + currentPointSetting.currentKyoku) % 4];
      setState(() {
        if (numOfNagashimagan > 0) {
          int bonba = currentPointSetting.bonba;
          int riichibou = currentPointSetting.riichibou;
          currentPointSetting.bonba = 0;
          currentPointSetting.riichibou = 0;
          nagashimangan.forEach((key, value) {
            if (value) {
              updatePlayerPointTsumo(2000, key);
            }
          });
          currentPointSetting.bonba = bonba;
          currentPointSetting.riichibou = riichibou;
        } else {
          if (numOfTenpai != 0 && numOfTenpai != 4) {
            tenpai.forEach((key, value) {
              if (value) {
                currentPointSetting.players[key].point +=
                    currentSetting.ryukyokuPoint ~/ numOfTenpai;
              } else {
                currentPointSetting.players[key].point -=
                    currentSetting.ryukyokuPoint ~/ (4 - numOfTenpai);
              }
            });
          }
        }
        if (!tenpai[oya]) {
          currentPointSetting.currentKyoku =
              (currentPointSetting.currentKyoku + 1) % 16;
        }
        currentPointSetting.bonba++;
        setRiichiFalse();
        addHistory();
      });
    }

    Widget PointAndRiichiSwitch(Position position) {
      String sittingText = Constant.sittingTexts[(position.index -
              (firstOya.index + currentPointSetting.currentKyoku) +
              8) %
          4];
      return GestureDetector(
        child: Column(
          children: [
            Spacer(),
            Container(
              child: Image.asset(currentPointSetting.players[position].riichi
                  ? "assets/riichibou.png"
                  : "assets/no_riichibou.png"),
            ),
            Text(
              "$sittingText ${currentPointSetting.players[position].point}",
              style: TextStyle(
                color: firstOya == position ? firstOyaColor : nonFirstOyaColor,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        onTap: () {
          setState(() {
            if (!currentPointSetting.players[position].riichi) {
              currentPointSetting.riichibou++;
              currentPointSetting.players[position].point -= 1000;
              currentPointSetting.players[position].riichi = true;
            } else {
              currentPointSetting.riichibou--;
              currentPointSetting.players[position].point += 1000;
              currentPointSetting.players[position].riichi = false;
            }
          });
        },
      );
    }

    void calResult() {
      List<List<int>> cal = [];
      Position.values.forEach((position) {
        cal.add([
          currentPointSetting.players[position].point -
              currentSetting.startingPoint,
          (Position.values.indexOf(position) -
                  Position.values.indexOf(firstOya) +
                  4) %
              4
        ]);
      });
      cal.sort((List<int> a, List<int> b) {
        if (a[0] == b[0]) {
          return a[1] - b[1];
        } else {
          return b[0] - a[0];
        }
      });
      Map<Position, double> marks = Map();
      double topBonus = 4 *
          (currentSetting.startingPoint - currentSetting.givenStartingPoint) /
          1000;
      if (currentSetting.douten) {
        if (cal[0][0] == cal[1][0] &&
            cal[1][0] == cal[2][0] &&
            cal[2][0] == cal[3][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + topBonus / 4;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000 + topBonus / 4;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 + topBonus / 4;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 + topBonus / 4;
        } else if (cal[0][0] == cal[1][0] && cal[1][0] == cal[2][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + (topBonus + currentSetting.umaBig) / 3;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000 + (topBonus + currentSetting.umaBig) / 3;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 + (topBonus + currentSetting.umaBig) / 3;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 - currentSetting.umaBig;
        } else if (cal[1][0] == cal[2][0] && cal[2][0] == cal[3][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + topBonus + currentSetting.umaBig;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000 - currentSetting.umaBig / 3;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 - currentSetting.umaBig / 3;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 - currentSetting.umaBig / 3;
        } else if (cal[0][0] == cal[1][0] && cal[2][0] == cal[3][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] = cal[0][0] /
                  1000 +
              (topBonus + currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] = cal[1][0] /
                  1000 +
              (topBonus + currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 -
                  (currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 -
                  (currentSetting.umaBig + currentSetting.umaSmall) / 2;
        } else if (cal[0][0] == cal[1][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] = cal[0][0] /
                  1000 +
              (topBonus + currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] = cal[1][0] /
                  1000 +
              (topBonus + currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 - currentSetting.umaSmall;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 - currentSetting.umaBig;
        } else if (cal[1][0] == cal[2][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + topBonus + currentSetting.umaBig;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 - currentSetting.umaBig;
        } else if (cal[2][0] == cal[3][0]) {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + topBonus + currentSetting.umaBig;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000 + currentSetting.umaSmall;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 -
                  (currentSetting.umaBig + currentSetting.umaSmall) / 2;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 -
                  (currentSetting.umaBig + currentSetting.umaSmall) / 2;
        } else {
          marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
              cal[0][0] / 1000 + topBonus + currentSetting.umaBig;
          marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
              cal[1][0] / 1000 + currentSetting.umaSmall;
          marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
              cal[2][0] / 1000 - currentSetting.umaSmall;
          marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
              cal[3][0] / 1000 - currentSetting.umaBig;
        }
      } else {
        marks[Position.values[(firstOya.index + cal[0][1]) % 4]] =
            cal[0][0] / 1000 + topBonus + currentSetting.umaBig;
        marks[Position.values[(firstOya.index + cal[1][1]) % 4]] =
            cal[1][0] / 1000 + currentSetting.umaSmall;
        marks[Position.values[(firstOya.index + cal[2][1]) % 4]] =
            cal[2][0] / 1000 - currentSetting.umaSmall;
        marks[Position.values[(firstOya.index + cal[3][1]) % 4]] =
            cal[3][0] / 1000 - currentSetting.umaBig;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).result),
          content: Column(
            children: marks.entries
                .map((mark) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Constant.positionTexts[mark.key],
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

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: FittedBox(
            child: Text(AppLocalizations.of(context).appTitle),
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
                            currentPointSetting: currentPointSetting,
                            save: savePointSetting,
                          )),
                    );
                    break;
                  case "setting":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Setting(
                            currentSetting: currentSetting,
                            save: saveSetting,
                            firstOya: firstOya,
                          )),
                    );
                    break;
                  case "language":
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => LanguageDialog(
                        onValueChange: (String lang) {
                          setState(() {
                            language = lang;
                          });
                          widget.setAppLocaleDelegate
                              .setLocale(supportedLocales[language]);
                          Constant.languageChange(context);
                        },
                        initialValue: language,
                      ),
                    );
                    break;
                  case "history":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryPage(
                              histories: histories,
                              save: saveHistory,
                            )));
                    break;
                  case "about":
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                    break;
                }
              },
            ),
          ],
        ),
        body: Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              EmptyGrid(),
              Center(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: PointAndRiichiSwitch(Position.Top),
                ),
              ),
              EmptyGrid(),
              Center(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: PointAndRiichiSwitch(Position.Left),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      Constant.kyokus[currentPointSetting.currentKyoku],
                      style: TextStyle(
                        color: nonFirstOyaColor,
                      ),
                    ),
                    Text(
                      "${currentPointSetting.bonba} 本場",
                      style: TextStyle(
                        color: nonFirstOyaColor,
                      ),
                    ),
                    Text(
                      "供托: ${currentPointSetting.riichibou}",
                      style: TextStyle(
                        color: nonFirstOyaColor,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: PointAndRiichiSwitch(Position.Right),
                ),
              ),
              EmptyGrid(),
              Center(
                child: PointAndRiichiSwitch(Position.Bottom),
              ),
              FractionallySizedBox(
                heightFactor: 0.3,
                widthFactor: 0.6,
                child: RaisedButton(
                  child: Text(AppLocalizations.of(context).result),
                  onPressed: calResult,
                  elevation: 1.0,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton(AppLocalizations.of(context).ron, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ron(next: saveRon)));
              }),
              BaseBarButton(AppLocalizations.of(context).tsumo, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tsumo(save: saveTsumo)));
              }),
              BaseBarButton(AppLocalizations.of(context).ryukyoku, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ryukyoku(save: saveRyukyoku)));
              }),
              BaseBarButton(AppLocalizations.of(context).reset, () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context).confirm),
                    content: Text(AppLocalizations.of(context).confirmReset),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            reset();
                          });
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
          color: Colors.blue,
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: FittedBox(
            child: Text(AppLocalizations.of(context).appTitle),
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
                            currentPointSetting: currentPointSetting,
                            save: savePointSetting,
                          )),
                    );
                    break;
                  case "setting":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Setting(
                            currentSetting: currentSetting,
                            save: saveSetting,
                            firstOya: firstOya,
                          )),
                    );
                    break;
                  case "language":
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => LanguageDialog(
                        onValueChange: (String lang) {
                          setState(() {
                            language = lang;
                          });
                          widget.setAppLocaleDelegate
                              .setLocale(supportedLocales[language]);
                          Constant.languageChange(context);
                        },
                        initialValue: language,
                      ),
                    );
                    break;
                  case "history":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryPage(
                              histories: histories,
                              save: saveHistory,
                            )));
                    break;
                  case "about":
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                    break;
                }
              },
            ),
          ],
        ),
        body: Row(
          children: [
            Spacer(),
            Flexible(
              child: RotatedBox(
                quarterTurns: 1,
                child: PointAndRiichiSwitch(Position.Left),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: PointAndRiichiSwitch(Position.Top),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                Flexible(child: PointAndRiichiSwitch(Position.Bottom)),
              ],
            ),
            Flexible(
              child: RotatedBox(
                quarterTurns: 3,
                child: PointAndRiichiSwitch(Position.Right),
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
                    Constant.kyokus[currentPointSetting.currentKyoku],
                    style: TextStyle(
                      color: nonFirstOyaColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${currentPointSetting.bonba} 本場",
                    style: TextStyle(
                      color: nonFirstOyaColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "供托: ${currentPointSetting.riichibou}",
                    style: TextStyle(
                      color: nonFirstOyaColor,
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            Spacer(),
            RaisedButton(
              child: Text(AppLocalizations.of(context).result),
              onPressed: calResult,
              elevation: 1.0,
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton(AppLocalizations.of(context).ron, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ron(next: saveRon)));
              }),
              BaseBarButton(AppLocalizations.of(context).tsumo, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tsumo(save: saveTsumo)));
              }),
              BaseBarButton(AppLocalizations.of(context).ryukyoku, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ryukyoku(save: saveRyukyoku)));
              }),
              BaseBarButton(AppLocalizations.of(context).reset, () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context).confirm),
                    content: Text(AppLocalizations.of(context).confirmReset),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            reset();
                          });
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
          color: Colors.blue,
        ),
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
