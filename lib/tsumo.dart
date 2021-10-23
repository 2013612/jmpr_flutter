import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class Tsumo extends StatefulWidget {
  final Function save;

  Tsumo({
    required this.save,
  });

  @override
  State<Tsumo> createState() => _TsumoState();
}

class _TsumoState extends State<Tsumo> {
  int? _han, _fu;
  Position? _tsumoPlayer;
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
    _han = 1;
    _fu = 30;
    _tsumoPlayer = Position.bottom;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    Widget tsumoPlayerRadioListTile(Position position) {
      return flexibleCustomRadioTile(
        position,
        _tsumoPlayer,
        Constant.positionTexts[position]!,
        (Position? val) {
          setState(() {
            _tsumoPlayer = val;
          });
        },
        Constant.arrows[position],
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.tsumo),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(i18n.tsumo),
              Row(
                children: [
                  tsumoPlayerRadioListTile(Position.bottom),
                  tsumoPlayerRadioListTile(Position.right),
                ],
              ),
              Row(
                children: [
                  tsumoPlayerRadioListTile(Position.top),
                  tsumoPlayerRadioListTile(Position.left),
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
                          items: Constant.hans
                              .map((han) => DropdownMenuItem(
                                    value: han.toString(),
                                    child: Text(han.toString()),
                                  ))
                              .toList(),
                          value: _han.toString(),
                          isDense: true,
                          onChanged: (val) {
                            setState(() {
                              _han = int.tryParse(val!);
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
                  Container(
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
                          value: _fu.toString(),
                          isDense: true,
                          onChanged: (val) {
                            setState(() {
                              _fu = int.tryParse(val!);
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
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              baseBarButton(i18n.cancel, () => Navigator.pop(context)),
              baseBarButton(i18n.save, () {
                widget.save(_tsumoPlayer, _han, _fu);
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
