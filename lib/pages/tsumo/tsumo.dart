import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/custom_radio_tile.dart';
import '../../providers/histories.dart';
import '../../utility/constant.dart';

class Tsumo extends ConsumerStatefulWidget {
  @override
  ConsumerState<Tsumo> createState() => _TsumoState();
}

class _TsumoState extends ConsumerState<Tsumo> {
  int _han = 1, _fu = 30;
  Position _tsumoPlayer = Position.bottom;

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

    Widget tsumoPlayerRadioListTile(Position position) {
      return Flexible(
        child: CustomRadioTile(
          value: position,
          cur: _tsumoPlayer,
          title: Constant.positionTexts[position]!,
          onChanged: (Position? val) {
            setState(() {
              _tsumoPlayer = val ?? Position.bottom;
            });
          },
          icon: Constant.arrows[position]!,
        ),
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
                              _han = int.tryParse(val!) ?? 1;
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
                              _fu = int.tryParse(val!) ?? 30;
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
              BaseBarButton(
                name: i18n.cancel,
                onPress: () => Navigator.pop(context),
              ),
              BaseBarButton(
                name: i18n.save,
                onPress: () {
                  final histories = ref.watch(historiesProvider);
                  final index = ref.watch(historyIndexProvider);

                  if (index + 1 < histories.length) {
                    histories.removeRange(index + 1, histories.length);
                  }
                  histories.add(histories[index].clone());
                  ref.watch(historyIndexProvider.state).state++;

                  histories[index + 1].saveTsumo(_tsumoPlayer, _han, _fu);
                  histories[index + 1].setRiichiFalse();

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
