import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class RonPoint extends StatefulWidget {
  final Map<Position, bool> isRonPlayers;
  final Function save;

  RonPoint({
    @required this.isRonPlayers,
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
  Map<Position, int> _hans, _fus;

  @override
  void initState() {
    super.initState();
    _hans = {};
    _fus = {};
    for (Position position in Position.values) {
      _hans[position] = 1;
      _fus[position] = 30;
    }
  }

  Widget playerPoint(Position position) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Spacer(),
          Text(Constant.positionTexts[position]),
          Spacer(),
          SizedBox(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: Constant.hans
                      .map((han) => DropdownMenuItem(
                    value: han.toString(),
                            child: Text(han.toString()),
                          ))
                      .toList(),
                  value: _hans[position].toString(),
                  isDense: true,
                  onChanged: (val) {
                    setState(() {
                      _hans[position] = int.tryParse(val);
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).han),
          ),
          Spacer(),
          SizedBox(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: Constant.fus
                      .map((fu) => DropdownMenuItem(
                    value: fu.toString(),
                            child: Text(fu.toString()),
                          ))
                      .toList(),
                  value: _fus[position].toString(),
                  isDense: true,
                  onChanged: (val) {
                    setState(() {
                      _fus[position] = int.tryParse(val);
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).fu),
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
          title: Text(AppLocalizations.of(context).point),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.isRonPlayers.entries
                .map((isRonPlayer) {
                  if (isRonPlayer.value) {
                    return playerPoint(isRonPlayer.key);
                  }
                })
                .toList()
                .where((widget) => widget != null)
                .toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              baseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              baseBarButton(AppLocalizations.of(context).save, () {
                widget.save(_hans, _fus);
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
