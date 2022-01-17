// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionRon _$$TransactionRonFromJson(Map<String, dynamic> json) =>
    _$TransactionRon(
      playerPoints: (json['player_points'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k),
            Player.fromJson(e as Map<String, dynamic>)),
      ),
      ending:
          $enumDecodeNullable(_$EndingEnumMap, json['ending']) ?? Ending.ron,
      losePlayer: $enumDecode(_$PositionEnumMap, json['lose_player']),
      winPlayers: (json['win_players'] as List<dynamic>)
          .map((e) => WinPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TransactionRonToJson(_$TransactionRon instance) =>
    <String, dynamic>{
      'player_points': instance.playerPoints
          .map((k, e) => MapEntry(_$PositionEnumMap[k], e.toJson())),
      'ending': _$EndingEnumMap[instance.ending],
      'lose_player': _$PositionEnumMap[instance.losePlayer],
      'win_players': instance.winPlayers.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

const _$PositionEnumMap = {
  Position.bottom: 'BOTTOM',
  Position.right: 'RIGHT',
  Position.top: 'TOP',
  Position.left: 'LEFT',
};

const _$EndingEnumMap = {
  Ending.start: 'START',
  Ending.edit: 'EDIT',
  Ending.ron: 'RON',
  Ending.tsumo: 'TSUMO',
  Ending.ryukyoku: 'RYUKYOKU',
};

_$TransactionTsumo _$$TransactionTsumoFromJson(Map<String, dynamic> json) =>
    _$TransactionTsumo(
      playerPoints: (json['player_points'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k),
            Player.fromJson(e as Map<String, dynamic>)),
      ),
      ending:
          $enumDecodeNullable(_$EndingEnumMap, json['ending']) ?? Ending.tsumo,
      winPlayer: WinPlayer.fromJson(json['win_player'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TransactionTsumoToJson(_$TransactionTsumo instance) =>
    <String, dynamic>{
      'player_points': instance.playerPoints
          .map((k, e) => MapEntry(_$PositionEnumMap[k], e.toJson())),
      'ending': _$EndingEnumMap[instance.ending],
      'win_player': instance.winPlayer.toJson(),
      'runtimeType': instance.$type,
    };

_$TransactionRyukyoku _$$TransactionRyukyokuFromJson(
        Map<String, dynamic> json) =>
    _$TransactionRyukyoku(
      playerPoints: (json['player_points'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k),
            Player.fromJson(e as Map<String, dynamic>)),
      ),
      ending: $enumDecodeNullable(_$EndingEnumMap, json['ending']) ??
          Ending.ryukyoku,
      tenpai: (json['tenpai'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k), e as bool),
      ),
      nagashimangan: (json['nagashimangan'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k), e as bool),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TransactionRyukyokuToJson(
        _$TransactionRyukyoku instance) =>
    <String, dynamic>{
      'player_points': instance.playerPoints
          .map((k, e) => MapEntry(_$PositionEnumMap[k], e.toJson())),
      'ending': _$EndingEnumMap[instance.ending],
      'tenpai':
          instance.tenpai.map((k, e) => MapEntry(_$PositionEnumMap[k], e)),
      'nagashimangan': instance.nagashimangan
          .map((k, e) => MapEntry(_$PositionEnumMap[k], e)),
      'runtimeType': instance.$type,
    };

_$TransactionEdit _$$TransactionEditFromJson(Map<String, dynamic> json) =>
    _$TransactionEdit(
      pointSetting:
          PointSetting.fromJson(json['point_setting'] as Map<String, dynamic>),
      ending:
          $enumDecodeNullable(_$EndingEnumMap, json['ending']) ?? Ending.edit,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TransactionEditToJson(_$TransactionEdit instance) =>
    <String, dynamic>{
      'point_setting': instance.pointSetting.toJson(),
      'ending': _$EndingEnumMap[instance.ending],
      'runtimeType': instance.$type,
    };
