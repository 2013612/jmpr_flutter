import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/games_provider.dart';
import 'package:jmpr_flutter/providers/indexes_provider.dart';
import 'package:jmpr_flutter/providers/point_setting.dart';
import 'package:jmpr_flutter/utility/indexes.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/custom_radio_tile.dart';
import '../../utility/constant.dart';
import '../../utility/enum/position.dart';

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
                  final indexes = ref.watch(indexesProvider);
                  final pointSetting = ref.watch(pointSettingProvider);

                  removeUnusedGameAndPointSetting(ref);

                  ref
                      .watch(gamesProvider)[indexes.gameIndex]
                      .saveTsumo(_tsumoPlayer, _han, _fu, pointSetting);
                  ref.watch(indexesProvider.state).state =
                      Indexes(indexes.gameIndex, indexes.pointSettingIndex + 1);

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
