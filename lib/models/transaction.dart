import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/player.dart';
import '../utility/enum/ending.dart';
import '../utility/enum/position.dart';
import 'point_setting.dart';
import 'win_player.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction.ron({
    @JsonKey(name: 'player_points') required Map<Position, Player> playerPoints,
    @Default(Ending.ron) Ending ending,
    @JsonKey(name: 'lose_player') required Position losePlayer,
    @JsonKey(name: 'win_players') required List<WinPlayer> winPlayers,
  }) = TransactionRon;

  const factory Transaction.tsumo({
    @JsonKey(name: 'player_points') required Map<Position, Player> playerPoints,
    @Default(Ending.tsumo) Ending ending,
    @JsonKey(name: 'win_player') required WinPlayer winPlayer,
  }) = TransactionTsumo;

  const factory Transaction.ryukyoku({
    @JsonKey(name: 'player_points') required Map<Position, Player> playerPoints,
    @Default(Ending.ryukyoku) Ending ending,
    required Map<Position, bool> tenpai,
    required Map<Position, bool> nagashimangan,
  }) = TransactionRyukyoku;

  const factory Transaction.edit({
    @JsonKey(name: 'point_setting') required PointSetting pointSetting,
    @Default(Ending.edit) Ending ending,
  }) = TransactionEdit;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
