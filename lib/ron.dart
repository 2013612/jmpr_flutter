import 'package:flutter/material.dart';
import 'package:jmpr_flutter/ronPoint.dart';

import 'common.dart';

class Ron extends StatefulWidget {
  Function next;

  Ron({this.next});

  @override
  State<Ron> createState() => _RonState();
}

class _RonState extends State<Ron> {
  Position _ronedPlayer;
  Map<Position, bool> _ronPlayers;

  @override
  void initState() {
    super.initState();
    _ronedPlayer = Position.Bottom;
    _ronPlayers = Map();
    Position.values.forEach((element) {
      _ronPlayers[element] = false;
    });
  }

  Widget RonedPlayerRadioListTile(Position position) {
    return FlexibleCustomRadioTile(
      position,
      _ronedPlayer,
      constant.positionTexts[position],
      (val) {
        setState(() {
          _ronedPlayer = val;
        });
      },
    );
  }

  Widget RonCheckboxListTile(Position position) {
    return FlexibleCustomCheckBoxTile(
      _ronPlayers[position],
      constant.positionTexts[position],
      (val) {
        setState(() {
          _ronPlayers[position] = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("銃和"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text("放銃"),
              Row(
                children: [
                  RonedPlayerRadioListTile(Position.Bottom),
                  RonedPlayerRadioListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  RonedPlayerRadioListTile(Position.Top),
                  RonedPlayerRadioListTile(Position.Left),
                ],
              ),
              Text("和了"),
              Row(
                children: [
                  RonCheckboxListTile(Position.Bottom),
                  RonCheckboxListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  RonCheckboxListTile(Position.Top),
                  RonCheckboxListTile(Position.Left),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("下一步", () {
                if (!_ronPlayers.values
                    .reduce((value, element) => value || element)) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("錯誤"),
                          content: Text("至少選擇一名玩家和了"),
                        );
                      });
                  return;
                } else if (_ronPlayers[_ronedPlayer]) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("錯誤"),
                          content: Text("同一名玩家不可同時和了和放銃"),
                        );
                      });
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RonPoint(
                      ronPlayers: _ronPlayers,
                      save: (Map<Position, int> hans, Map<Position, int> fus) {
                        widget.next(_ronedPlayer, _ronPlayers, hans, fus);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
