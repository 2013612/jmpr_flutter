import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../utility/constant.dart';
import '../../utility/iterable_methods.dart';

class RonPoint extends StatefulWidget {
  final Map<Position, bool> isRonPlayers;
  final Function save;

  RonPoint({
    required this.isRonPlayers,
    required this.save,
  });

  @override
  State<RonPoint> createState() => _RonPointState();
}

class _RonPointState extends State<RonPoint> {
  final Map<Position, int> _hans = {}, _fus = {};

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final InputDecoration _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    Widget playerPoint(Position position) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Spacer(),
            Text(Constant.positionTexts[position]!),
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
                        _hans[position] = int.tryParse(val ?? "") ?? 1;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(i18n.han),
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
                        _fus[position] = int.tryParse(val ?? "") ?? 0;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(i18n.fu),
            ),
            Spacer(),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.point),
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
                .compact()
                .toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton(
                  name: i18n.cancel, onPress: () => Navigator.pop(context)),
              BaseBarButton(
                  name: i18n.save,
                  onPress: () {
                    widget.save(_hans, _fus);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (Position position in Position.values) {
      _hans[position] = 1;
      _fus[position] = 30;
    }
  }
}
