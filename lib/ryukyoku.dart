import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    _nagashimangan = Map();
    Position.values.forEach((element) {
      _tenpai[element] = false;
      _nagashimangan[element] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget TenpaiCheckboxListTile(Position position) {
      return FlexibleCustomCheckBoxTile(
        _tenpai[position],
        Constant.positionTexts[position],
        (val) {
          setState(() {
            _tenpai[position] = val;
          });
        },
        Constant.arrows[position],
      );
    }

    Widget NagashimanganCheckboxListTile(Position position) {
      return FlexibleCustomCheckBoxTile(
        _nagashimangan[position],
        Constant.positionTexts[position],
        (val) {
          setState(() {
            _nagashimangan[position] = val;
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
              Text(AppLocalizations.of(context).nagashimangan),
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
              BaseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              BaseBarButton(AppLocalizations.of(context).save, () {
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
