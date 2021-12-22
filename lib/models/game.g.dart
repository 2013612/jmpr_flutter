// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      gamePlayers: (json['game_players'] as List<dynamic>)
          .map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      histories: (json['histories'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'game_players': instance.gamePlayers.map((e) => e.toJson()).toList(),
      'histories': instance.histories.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
      'setting': instance.setting.toJson(),
    };
