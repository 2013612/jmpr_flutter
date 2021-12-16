import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_player.dart';
import 'history.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const factory Game({
    @JsonKey(name: 'game_players') required List<GamePlayer> gamePlayers,
    required List<History> histories,
  }) = _Game;
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
