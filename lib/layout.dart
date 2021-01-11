import 'package:flutter/material.dart';
import 'package:jmpr_flutter/pointSetting.dart';
import 'package:jmpr_flutter/setting.dart';

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
  final List<String> kyokus = ["東一局", "東二局", "東三局", "東四局", "南一局", "南二局", "南三局", "南四局", "西一局", "西二局", "西三局", "西四局", "北一局", "北二局", "北三局", "北四局"];
  SettingParameter currentSetting;
  PointSettingParameter currentPointSetting;

  @override
  void initState() {
    super.initState();
    currentSetting = SettingParameter(startingPoint: 30000, givenStartingPoint: 25000, riichibouPoint: 1000, bonbaPoint: 300, umaBig: 20, umaSmall: 10, kiriage: false, douten: false);
    Map<Position, Player> players = Map();
    players[Position.Bottom] = Player(position: Position.Bottom, point: currentSetting.givenStartingPoint);
    players[Position.Right] = Player(position: Position.Right, point: currentSetting.givenStartingPoint);
    players[Position.Top] = Player(position: Position.Top, point: currentSetting.givenStartingPoint);
    players[Position.Left] = Player(position: Position.Left, point: currentSetting.givenStartingPoint);
    currentPointSetting = PointSettingParameter(players: players, currentKyoku: 0, bonba: 0, riichibou: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = ["場況設定", "設定", "上一步"];

    void reset() {
      setState(() {
        currentPointSetting.players[Position.Bottom].point = currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Right].point = currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Top].point = currentSetting.givenStartingPoint;
        currentPointSetting.players[Position.Left].point = currentSetting.givenStartingPoint;
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return choices.map(
                      (choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }
              ).toList();
            },
            icon: Icon(
              Icons.menu,
            ),
            onSelected: (string) {
              if (string == "場況設定") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PointSetting(currentPointSetting: currentPointSetting, save: savePointSetting)));
              } else if (string == "設定") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting(currentSetting: currentSetting, save: saveSetting)));
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
                    color: firstOya == Position.Top? firstOyaColor : nonFirstOyaColor,
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
                    color: firstOya == Position.Left? firstOyaColor : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(kyokus[currentPointSetting.currentKyoku]),
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
                    color: firstOya == Position.Right? firstOyaColor : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            EmptyGrid(),
            Center(
              child: Text(
                "${currentPointSetting.players[Position.Bottom].point}",
                style: TextStyle(
                  color: firstOya == Position.Bottom? firstOyaColor : nonFirstOyaColor,
                ),
              ),
            ),
            EmptyGrid(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text(
                "銃和",
              ),
              // TODO: fill function after finish page
              onPressed: null,
              //textColor: CustomColor.BROWN_DARK,
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            RaisedButton(
              child: Text(
                "自摸",
              ),
              // TODO: fill function after finish page
              onPressed: null,
              //textColor: CustomColor.BROWN_DARK,
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            RaisedButton(
              child: Text(
                "流局",
              ),
              // TODO: fill function after finish page
              onPressed: null,
              //textColor: CustomColor.BROWN_DARK,
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            RaisedButton(
              child: Text(
                "重置",
              ),
              // TODO: fill function after finish page
              onPressed: null,
              //textColor: CustomColor.BROWN_DARK,
              color: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
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