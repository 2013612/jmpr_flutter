import 'package:flutter/material.dart';
import 'package:jmpr_flutter/pointSetting.dart';

class Layout extends StatefulWidget {
  Layout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Map<Position, Player> players = Map();
  int initPoint = 25000;
  Position firstOya = Position.Bottom;
  Color firstOyaColor = Colors.red;
  Color nonFirstOyaColor = Colors.black;
  static const List<String> kyokus = ["東一局", "東二局", "東三局", "東四局", "南一局", "南二局", "南三局", "南四局", "西一局", "西二局", "西三局", "西四局", "北一局", "北二局", "北三局", "北四局"];
  int currentKyoku = 0;
  int bomBa = 0;
  int riichibou = 0;
  int bonbaPoint = 300;
  int umaSmall = 10;
  int umaBig = 20;
  bool kiriage = false;

  @override
  void initState() {
    super.initState();
    players[Position.Bottom] = Player(position: Position.Bottom, point: initPoint);
    players[Position.Right] = Player(position: Position.Right, point: initPoint);
    players[Position.Top] = Player(position: Position.Top, point: initPoint);
    players[Position.Left] = Player(position: Position.Left, point: initPoint);
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = ["場況設定", "設定", "上一步"];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => PointSetting()));
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
                  players[Position.Top].point.toString(),
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
                  players[Position.Left].point.toString(),
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
                  Text(kyokus[currentKyoku]),
                  Text("$bomBa 本場"),
                  Text("供托: $riichibou"),
                ],
              ),
            ),
            Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  players[Position.Right].point.toString(),
                  style: TextStyle(
                    color: firstOya == Position.Right? firstOyaColor : nonFirstOyaColor,
                  ),
                ),
              ),
            ),
            EmptyGrid(),
            Center(
              child: Text(
                players[Position.Bottom].point.toString(),
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

enum Position {
  Bottom,
  Right,
  Top,
  Left,
}

class Player {
  Position position;
  int point;

  Player({this.position, this.point});
}

class EmptyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}