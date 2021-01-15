import 'package:flutter/material.dart';
import 'common.dart';

class Ryukyoku extends StatefulWidget {
  Function save;
  Ryukyoku({
    @required this.save,
  });

  @override
  State<Ryukyoku> createState() => _RyokyokuState();
}

class _RyokyokuState extends State<Ryukyoku> {
  Map<Position, bool> _tenpai, _nagashimangan;

  @override
  void initState() {
    super.initState();
    _tenpai = Map();
    _tenpai[Position.Bottom] = false;
    _tenpai[Position.Right] = false;
    _tenpai[Position.Top] = false;
    _tenpai[Position.Left] = false;
    _nagashimangan = Map();
    _nagashimangan[Position.Bottom] = false;
    _nagashimangan[Position.Right] = false;
    _nagashimangan[Position.Top] = false;
    _nagashimangan[Position.Left] = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget TenpaiCheckboxListTile(Position position) {
      return FlexibleCustomCheckBoxTile(
        _tenpai[position],
        constant.positionTexts[position],
        (val) {
          setState(() {
            _tenpai[position] = val;
          });
        },
      );
    }

    Widget NagashimanganCheckboxListTile(Position position) {
      return FlexibleCustomCheckBoxTile(
        _nagashimangan[position],
        constant.positionTexts[position],
        (val) {
          setState(() {
            _nagashimangan[position] = val;
          });
        },
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("流局"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text("聴牌"),
              Row(
                children: [
                  TenpaiCheckboxListTile(Position.Bottom),
                  TenpaiCheckboxListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  TenpaiCheckboxListTile(Position.Top),
                  TenpaiCheckboxListTile(Position.Left),
                ],
              ),
              Text("流局滿貫"),
              Row(
                children: [
                  NagashimanganCheckboxListTile(Position.Bottom),
                  NagashimanganCheckboxListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  NagashimanganCheckboxListTile(Position.Top),
                  NagashimanganCheckboxListTile(Position.Left),
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
              BaseBarButton("儲存", () {
                widget.save(_tenpai, _nagashimangan);
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
