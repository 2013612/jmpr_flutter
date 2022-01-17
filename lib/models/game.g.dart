// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      gamePlayers: (json['game_players'] as List<dynamic>)
          .map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
      pointSettings: (json['pointSettings'] as List<dynamic>)
          .map((e) => PointSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'game_players': instance.gamePlayers.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
      'setting': instance.setting.toJson(),
      'pointSettings': instance.pointSettings.map((e) => e.toJson()).toList(),
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };
