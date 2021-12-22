// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Setting _$$_SettingFromJson(Map<String, dynamic> json) => _$_Setting(
      givenStartingPoint: json['given_starting_point'] as int? ?? 25000,
      startingPoint: json['starting_point'] as int? ?? 30000,
      riichibouPoint: json['riichibou_point'] as int? ?? 1000,
      bonbaPoint: json['bonba_point'] as int? ?? 300,
      ryukyokuPoint: json['ryukyoku_point'] as int? ?? 3000,
      umaSmall: json['uma_small'] as int? ?? 10,
      umaBig: json['uma_big'] as int? ?? 20,
      isKiriage: json['is_kiriage'] as bool? ?? false,
      isDouten: json['is_douten'] as bool? ?? false,
      firstOya: $enumDecodeNullable(_$PositionEnumMap, json['first_oya']) ??
          Position.bottom,
    );

Map<String, dynamic> _$$_SettingToJson(_$_Setting instance) =>
    <String, dynamic>{
      'given_starting_point': instance.givenStartingPoint,
      'starting_point': instance.startingPoint,
      'riichibou_point': instance.riichibouPoint,
      'bonba_point': instance.bonbaPoint,
      'ryukyoku_point': instance.ryukyokuPoint,
      'uma_small': instance.umaSmall,
      'uma_big': instance.umaBig,
      'is_kiriage': instance.isKiriage,
      'is_douten': instance.isDouten,
      'first_oya': _$PositionEnumMap[instance.firstOya],
    };

const _$PositionEnumMap = {
  Position.bottom: 'BOTTOM',
  Position.right: 'RIGHT',
  Position.top: 'TOP',
  Position.left: 'LEFT',
};
