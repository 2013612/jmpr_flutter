import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_player.freezed.dart';
part 'game_player.g.dart';

@freezed
class GamePlayer with _$GamePlayer {
  const factory GamePlayer({
    required String uid,
    @JsonKey(name: 'display_name') required String displayName,
  }) = _GamePlayer;
  factory GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerFromJson(json);
}
