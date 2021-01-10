import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '日本麻將點數記錄器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            Text(""),
            Center(
              child: RotatedBox(
                quarterTurns: 2,
                child: Text("25000"),
              ),
            ),
            Text(""),
            Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: Text("25000"),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("東一局"),
                  Text("0 本場"),
                  Text("供托: 0"),
                ],
              ),
            ),
            Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text("25000"),
              ),
            ),
            Text(""),
            Center(
              child: Text("25000"),
            ),
            Text(""),
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
              //onPressed: () => Navigator.pop(context),
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
              //onPressed: () => Navigator.pop(context),
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
              //onPressed: () => Navigator.pop(context),
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
              //onPressed: () => Navigator.pop(context),
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
