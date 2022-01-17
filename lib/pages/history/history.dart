import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../providers/games.dart';
import '../../utility/constant.dart';
import '../../utility/iterable_methods.dart';

class HistoryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final games = ref.watch(gamesProvider);
    final List<Color> colors = [
      Colors.black26,
      Colors.black12,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.history),
      ),
      body: ListView(
        children: games.reversed
            .mapIndexed((game, gIndex) =>
                game.pointSettings.reversed.mapIndexed(
                  (pointSetting, pIndex) => ListTile(
                    leading: Text(
                        "${Constant.kyokus[pointSetting.currentKyoku]} - ${pointSetting.bonba}"),
                    title: FittedBox(
                      child: Text(
                        pointSetting.players.entries.fold(
                            "",
                            (previousValue, player) =>
                                "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
                      ),
                    ),
                    tileColor: colors[gIndex % colors.length],
                    dense: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(i18n.confirm),
                            content: Text(i18n.confirmHistory),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(i18n.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.watch(indexProvider.state).state = Tuple2(
                                      games.length - gIndex - 1,
                                      game.pointSettings.length - pIndex - 1);
                                  Navigator.of(context)
                                      .popUntil(ModalRoute.withName('/'));
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ))
            .fold<List<Widget>>(
                [], (previousValue, element) => [...previousValue, ...element]),
      ),
    );
  }
}
