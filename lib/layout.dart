import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jmpr_flutter/pointSetting.dart';
import 'package:jmpr_flutter/ron.dart';
import 'package:jmpr_flutter/ryukyoku.dart';
import 'package:jmpr_flutter/setting.dart';
import 'package:jmpr_flutter/common.dart';
import 'package:jmpr_flutter/tsumo.dart';

class Layout extends StatefulWidget {
  Layout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Position firstOya = Position.Bottom;
  final Color firstOyaColor = Colors.red;
  final Color nonFirstOyaColor = Colors.black;
  SettingParameter currentSetting;
  PointSettingParameter currentPointSetting;

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
        douten: false);
    Map<Position, Player> players = Map();
    players[Position.Bottom] = Player(
        position: Position.Bottom, point: currentSetting.givenStartingPoint);
    players[Position.Right] = Player(
        position: Position.Right, point: currentSetting.givenStartingPoint);
    players[Position.Top] = Player(
        position: Position.Top, point: currentSetting.givenStartingPoint);
    players[Position.Left] = Player(
        position: Position.Left, point: currentSetting.givenStartingPoint);
    currentPointSetting = PointSettingParameter(
        players: players, currentKyoku: 0, bonba: 0, riichibou: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = ["場況設定", "設定", "上一步"];

    void reset() {
      setState(() {
        currentPointSetting.players[Position.Bottom].point =
            currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Right].point =
            currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Top].point =
            currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Left].point =
            currentSetting.givenStartingPoint;
        currentPointSetting.currentKyoku = 0;
        currentPointSetting.bonba = 0;
        currentPointSetting.riichibou = 0;
      });
    }

    void saveSetting(SettingParameter setting) {
      setState(() {
        currentSetting = setting;
        reset();
      });
    }

    void savePointSetting(PointSettingParameter pointSetting) {
      setState(() {
        currentPointSetting = pointSetting;
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
        point = constant.points[han];
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
      });
    }

    void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
        Map<Position, int> hans, Map<Position, int> fus) {
      Position oya = Position
          .values[(firstOya.index + currentPointSetting.currentKyoku) % 4];
      setState(() {
        int nearIndex = 100;
        ronPlayers.forEach((key, value) {
          //print("$key ${currentPointSetting.players[key].point}");
          //print("$ronedPlayer ${currentPointSetting.players[ronedPlayer].point}");
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
      });
    }

    void calRyukyoku(
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
          nagashimangan.forEach((key, value) {
            if (value) {
              updatePlayerPointTsumo(2000, key);
            }
          });
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
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return choices.map((choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(
              Icons.menu,
            ),
            onSelected: (string) {
              if (string == "場況設定") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PointSetting(
                            currentPointSetting: currentPointSetting,
                            save: savePointSetting)));
              } else if (string == "設定") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Setting(
                            currentSetting: currentSetting,
                            save: saveSetting)));
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
                child: Text(
                  "${currentPointSetting.players[Position.Top].point}",
                  style: TextStyle(
                    color: firstOya == Position.Top
                        ? firstOyaColor
                        : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            EmptyGrid(),
            Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  "${currentPointSetting.players[Position.Left].point}",
                  style: TextStyle(
                    color: firstOya == Position.Left
                        ? firstOyaColor
                        : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(constant.kyokus[currentPointSetting.currentKyoku]),
                  Text("${currentPointSetting.bonba} 本場"),
                  Text("供托: ${currentPointSetting.riichibou}"),
                ],
              ),
            ),
            Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "${currentPointSetting.players[Position.Right].point}",
                  style: TextStyle(
                    color: firstOya == Position.Right
                        ? firstOyaColor
                        : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            EmptyGrid(),
            Center(
              child: Text(
                "${currentPointSetting.players[Position.Bottom].point}",
                style: TextStyle(
                  color: firstOya == Position.Bottom
                      ? firstOyaColor
                      : nonFirstOyaColor,
                ),
              ),
            ),
            EmptyGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TODO: fill function after finish page
            BaseBarButton("銃和", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Ron(next: saveRon)));
            }),
            BaseBarButton("自摸", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tsumo(save: saveTsumo)));
            }),
            BaseBarButton("流局", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ryukyoku(save: calRyukyoku)));
            }),
            BaseBarButton("重置", reset),
          ],
        ),
        color: Colors.blue,
      ),
    );
  }
}

class EmptyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
