import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'common.dart';

class Ryukyoku extends StatefulWidget {
  final Function save;

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
    _tenpai = {};
    _nagashimangan = {};
    for (Position position in Position.values) {
      _tenpai[position] = false;
      _nagashimangan[position] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget tenpaiCheckboxListTile(Position position) {
      return flexibleCustomCheckBoxTile(
        _tenpai[position],
        Constant.positionTexts[position],
        (bool isTenpai) {
          setState(() {
            _tenpai[position] = isTenpai;
          });
        },
        Constant.arrows[position],
      );
    }

    Widget nagashimanganCheckboxListTile(Position position) {
      return flexibleCustomCheckBoxTile(
        _nagashimangan[position],
        Constant.positionTexts[position],
        (bool isNagashimangan) {
          setState(() {
            _nagashimangan[position] = isNagashimangan;
          });
        },
        Constant.arrows[position],
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).ryukyoku),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(AppLocalizations.of(context).tenpai),
              Row(
                children: [
                  tenpaiCheckboxListTile(Position.bottom),
                  tenpaiCheckboxListTile(Position.right),
                ],
              ),
              Row(
                children: [
                  tenpaiCheckboxListTile(Position.top),
                  tenpaiCheckboxListTile(Position.left),
                ],
              ),
              Text(AppLocalizations.of(context).nagashimangan),
              Row(
                children: [
                  nagashimanganCheckboxListTile(Position.bottom),
                  nagashimanganCheckboxListTile(Position.right),
                ],
              ),
              Row(
                children: [
                  nagashimanganCheckboxListTile(Position.top),
                  nagashimanganCheckboxListTile(Position.left),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              baseBarButton(AppLocalizations.of(context).abortiveDraw, () {
                setState(() {
                  _tenpai.updateAll((key, value) => _tenpai[key] = true);
                });
              }),
              baseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              baseBarButton(AppLocalizations.of(context).save, () {
                widget.save(_tenpai, _nagashimangan);
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
