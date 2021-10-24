import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_widgets/base_bar_button.dart';
import '../common_widgets/custom_check_box_tile.dart';
import '../utility/constant.dart';

class Ryukyoku extends StatefulWidget {
  final Function save;

  Ryukyoku({
    required this.save,
  });

  @override
  State<Ryukyoku> createState() => _RyokyokuState();
}

class _RyokyokuState extends State<Ryukyoku> {
  late Map<Position, bool> _tenpai, _nagashimangan;

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
      return Flexible(
        child: CustomCheckBoxTile(
          checkBoxValue: _tenpai[position] ?? false,
          title: Constant.positionTexts[position]!,
          onChanged: (bool? isTenpai) {
            setState(() {
              _tenpai[position] = isTenpai ?? false;
            });
          },
          icon: Constant.arrows[position],
        ),
      );
    }

    Widget nagashimanganCheckboxListTile(Position position) {
      return Flexible(
        child: CustomCheckBoxTile(
          checkBoxValue: _nagashimangan[position] ?? false,
          title: Constant.positionTexts[position]!,
          onChanged: (bool? isNagashimangan) {
            setState(() {
              _nagashimangan[position] = isNagashimangan ?? false;
            });
          },
          icon: Constant.arrows[position],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.ryukyoku),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(AppLocalizations.of(context)!.tenpai),
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
              Text(AppLocalizations.of(context)!.nagashimangan),
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
              BaseBarButton(
                name: AppLocalizations.of(context)!.abortiveDraw,
                onPress: () {
                  setState(() {
                    _tenpai.updateAll((key, value) => _tenpai[key] = true);
                  });
                },
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.cancel,
                onPress: () => Navigator.pop(context),
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.save,
                onPress: () {
                  widget.save(_tenpai, _nagashimangan);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
