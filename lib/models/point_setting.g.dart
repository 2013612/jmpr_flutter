// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PointSetting _$$_PointSettingFromJson(Map<String, dynamic> json) =>
    _$_PointSetting(
      players: (json['players'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PositionEnumMap, k),
            Player.fromJson(e as Map<String, dynamic>)),
      ),
      currentKyoku: json['current_kyoku'] as int? ?? 0,
      bonba: json['bonba'] as int? ?? 0,
      riichibou: json['riichibou'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PointSettingToJson(_$_PointSetting instance) =>
    <String, dynamic>{
      'players': instance.players
          .map((k, e) => MapEntry(_$PositionEnumMap[k], e.toJson())),
      'current_kyoku': instance.currentKyoku,
      'bonba': instance.bonba,
      'riichibou': instance.riichibou,
    };

const _$PositionEnumMap = {
  Position.bottom: 'BOTTOM',
  Position.right: 'RIGHT',
  Position.top: 'TOP',
  Position.left: 'LEFT',
};
