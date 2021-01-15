import 'package:flutter/material.dart';

import 'common.dart';

class Tsumo extends StatefulWidget {
  Function save;
  Tsumo({
    @required this.save,
  });

  @override
  State<Tsumo> createState() => _TsumoState();
}

class _TsumoState extends State<Tsumo> {
  int han, fu;
  Position _tsumoPlayer;
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    han = 1;
    fu = 30;
    _tsumoPlayer = Position.Bottom;
  }

  Widget TsumoPlayerRadioListTile(Position position) {
    return FlexibleCustomRadioTile(
      position,
      _tsumoPlayer,
      constant.positionTexts[position],
      (val) {
        setState(() {
          _tsumoPlayer = val;
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
          title: Text("自摸"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text("自摸"),
              Row(
                children: [
                  TsumoPlayerRadioListTile(Position.Bottom),
                  TsumoPlayerRadioListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  TsumoPlayerRadioListTile(Position.Top),
                  TsumoPlayerRadioListTile(Position.Left),
                ],
              ),
              Row(
                children: [
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
                          value: han.toString(),
                          isDense: true,
                          onChanged: (val) {
                            setState(() {
                              han = int.tryParse(val);
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
                          value: fu.toString(),
                          isDense: true,
                          onChanged: (val) {
                            setState(() {
                              fu = int.tryParse(val);
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
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("儲存", () {
                widget.save(_tsumoPlayer, han, fu);
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
