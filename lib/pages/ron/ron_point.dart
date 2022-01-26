import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../providers/games_provider.dart';
import '../../providers/indexes_provider.dart';
import '../../providers/point_setting.dart';
import '../../utility/constant.dart';
import '../../utility/enum/position.dart';
import '../../utility/indexes.dart';
import '../../utility/iterable_methods.dart';

class RonPoint extends ConsumerStatefulWidget {
  final Map<Position, bool> isRonPlayers;
  final Position losePlayer;

  RonPoint({
    required this.isRonPlayers,
    required this.losePlayer,
  });

  @override
  ConsumerState<RonPoint> createState() => _RonPointState();
}

class _RonPointState extends ConsumerState<RonPoint> {
  final Map<Position, Tuple2<int, int>> _hanfus = {};

  @override
  void initState() {
    super.initState();
    for (Position position in Position.values) {
      if (widget.isRonPlayers[position] ?? false) {
        _hanfus[position] = Tuple2(1, 30);
      } else {
        _hanfus[position] = Tuple2(0, 0);
      }
    }
  }

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
                    value: _hanfus[position]?.item1.toString(),
                    isDense: true,
                    onChanged: (val) {
                      setState(() {
                        _hanfus[position] = _hanfus[position]!
                            .withItem1(int.tryParse(val ?? "") ?? 1);
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
                    value: _hanfus[position]!.item2.toString(),
                    isDense: true,
                    onChanged: (val) {
                      setState(() {
                        _hanfus[position] = _hanfus[position]!
                            .withItem2(int.tryParse(val ?? "") ?? 30);
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
                      .saveRon(widget.losePlayer, _hanfus, pointSetting);
                  ref.watch(indexesProvider.state).state =
                      Indexes(indexes.gameIndex, indexes.pointSettingIndex + 1);

                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
