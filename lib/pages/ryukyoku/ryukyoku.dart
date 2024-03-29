import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../providers/histories.dart';
import '../../utility/enum/position.dart';
import 'local_widgets/flexible_custom_check_box_tile.dart';

class Ryukyoku extends ConsumerStatefulWidget {
  @override
  ConsumerState<Ryukyoku> createState() => _RyokyokuState();
}

class _RyokyokuState extends ConsumerState<Ryukyoku> {
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
    final i18n = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.ryukyoku),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(i18n.tenpai),
              Row(
                children: [
                  FlexibleCustomCheckBoxTile(
                    position: Position.bottom,
                    map: _tenpai,
                  ),
                  FlexibleCustomCheckBoxTile(
                    position: Position.right,
                    map: _tenpai,
                  ),
                ],
              ),
              Row(
                children: [
                  FlexibleCustomCheckBoxTile(
                    position: Position.top,
                    map: _tenpai,
                  ),
                  FlexibleCustomCheckBoxTile(
                    position: Position.left,
                    map: _tenpai,
                  ),
                ],
              ),
              Text(i18n.nagashimangan),
              Row(
                children: [
                  FlexibleCustomCheckBoxTile(
                    position: Position.bottom,
                    map: _nagashimangan,
                  ),
                  FlexibleCustomCheckBoxTile(
                    position: Position.right,
                    map: _nagashimangan,
                  ),
                ],
              ),
              Row(
                children: [
                  FlexibleCustomCheckBoxTile(
                    position: Position.top,
                    map: _nagashimangan,
                  ),
                  FlexibleCustomCheckBoxTile(
                    position: Position.left,
                    map: _nagashimangan,
                  ),
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
                name: i18n.abortiveDraw,
                onPress: () {
                  setState(() {
                    _tenpai.updateAll((key, value) => _tenpai[key] = true);
                  });
                },
              ),
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

                  histories[index + 1].saveRyukyoku(_tenpai, _nagashimangan);
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
