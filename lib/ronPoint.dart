import 'package:flutter/material.dart';

import 'common.dart';

class RonPoint extends StatefulWidget {
  Map<Position, bool> ronPlayers;
  Function save;

  RonPoint({
    @required this.ronPlayers,
    @required this.save,
  });

  @override
  State<RonPoint> createState() => _RonPointState();
}

class _RonPointState extends State<RonPoint> {
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  Map<Position, int> hans, fus;

  @override
  void initState() {
    super.initState();
    hans = Map();
    fus = Map();
    Position.values.forEach((element) {
      hans[element] = 1;
      fus[element] = 30;
    });
  }

  Widget PlayerPoint(Position position) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Spacer(),
          Text(constant.positionTexts[position]),
          Spacer(),
          Container(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: constant.hans
                      .map((e) => DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e.toString(),
                          ))
                      .toList(),
                  value: hans[position].toString(),
                  isDense: true,
                  onChanged: (val) {
                    setState(() {
                      hans[position] = int.tryParse(val);
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text("番"),
          ),
          Spacer(),
          Container(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: constant.fus
                      .map((e) => DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e.toString(),
                          ))
                      .toList(),
                  value: fus[position].toString(),
                  isDense: true,
                  onChanged: (val) {
                    setState(() {
                      fus[position] = int.tryParse(val);
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text("符"),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text("和了點數"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.ronPlayers.entries
                .map((e) {
                  if (e.value) {
                    return PlayerPoint(e.key);
                  }
                })
                .toList()
                .where((item) => item != null)
                .toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("儲存", () {
                widget.save(hans, fus);
                Navigator.pop(context);
              }),
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
