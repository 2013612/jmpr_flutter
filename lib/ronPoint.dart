import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Text(Constant.positionTexts[position]),
          Spacer(),
          Container(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: Constant.hans
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
            child: Text(AppLocalizations.of(context).han),
          ),
          Spacer(),
          Container(
            width: 70,
            child: InputDecorator(
              decoration: _inputDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: Constant.fus
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
            child: Text(AppLocalizations.of(context).fu),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
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
              BaseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              BaseBarButton(AppLocalizations.of(context).save, () {
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
