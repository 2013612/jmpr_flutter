import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../utility/enum/position.dart';

part 'win_player.freezed.dart';
part 'win_player.g.dart';

@freezed
class WinPlayer with _$WinPlayer {
  const factory WinPlayer({
    required Position position,
    required int han,
    required int fu,
  }) = _WinPlayer;

  factory WinPlayer.fromJson(Map<String, dynamic> json) =>
      _$WinPlayerFromJson(json);
}
