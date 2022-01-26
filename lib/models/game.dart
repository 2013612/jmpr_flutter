import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tuple/tuple.dart';

import '../utility/constant.dart';
import '../utility/enum/position.dart';
import 'game_player.dart';
import 'player.dart';
import 'point_setting.dart';
import 'setting.dart';
import 'transaction.dart';
import 'win_player.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    @JsonKey(name: 'game_players') required List<GamePlayer> gamePlayers,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required Setting setting,
    required List<PointSetting> pointSettings,
    required List<Transaction> transactions,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  void saveRon(Position losePlayer, Map<Position, Tuple2<int, int>> hanfus,
      PointSetting pointSetting) {
    Tuple2<PointSetting, Map<Position, Player>> changes = pointSetting.saveRon(
      losePlayer,
      hanfus.map((position, value) =>
          MapEntry(position, _calPoint(value.item1, value.item2))),
      setting,
    );

    transactions.add(TransactionRon(
      playerPoints: changes.item2,
      losePlayer: losePlayer,
      winPlayers: hanfus
          .map((position, value) => MapEntry(position,
              WinPlayer(position: position, han: value.item1, fu: value.item2)))
          .values
          .toList(),
    ));

    pointSettings.add(changes.item1);
  }

  void saveTsumo(
      Position tsumoPlayer, int han, int fu, PointSetting pointSetting) {
    Tuple2<PointSetting, Map<Position, Player>> changes =
        pointSetting.saveTsumo(tsumoPlayer, _calPoint(han, fu), setting);

    transactions.add(TransactionTsumo(
      winPlayer: WinPlayer(
        position: tsumoPlayer,
        han: han,
        fu: fu,
      ),
      playerPoints: changes.item2,
    ));

    pointSettings.add(changes.item1);
  }

  void saveRyukyoku(Map<Position, bool> tenpai,
      Map<Position, bool> nagashimangan, PointSetting pointSetting) {
    Tuple2<PointSetting, Map<Position, Player>> changes =
        pointSetting.saveRyukyoku(tenpai, nagashimangan, setting);

    transactions.add(TransactionRyukyoku(
      playerPoints: changes.item2,
      tenpai: tenpai,
      nagashimangan: nagashimangan,
    ));

    pointSettings.add(changes.item1);
  }

  void saveEdit(PointSetting pointSetting) {
    final changes = pointSetting.players.map(
      (position, player) => MapEntry(
        position,
        Player(
          isRiichi: false,
          point: player.point - pointSettings.last.players[position]!.point,
        ),
      ),
    );
    pointSettings.add(pointSetting);
    transactions.add(TransactionEdit(playerPoints: changes));
  }

  int _calPoint(int han, int fu) {
    int point = (pow(2, han + 2) * fu).toInt();
    if (point > 1920) {
      point = Constant.points[han]!;
    } else if (point == 1920 && setting.isKiriage) {
      point = 2000;
    }
    return point;
  }

  Map<Position, double> calResult(int index) {
    return pointSettings[index].calResult(setting);
  }
}
