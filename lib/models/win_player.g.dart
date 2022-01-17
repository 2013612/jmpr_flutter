// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'win_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WinPlayer _$$_WinPlayerFromJson(Map<String, dynamic> json) => _$_WinPlayer(
      position: $enumDecode(_$PositionEnumMap, json['position']),
      han: json['han'] as int,
      fu: json['fu'] as int,
    );

Map<String, dynamic> _$$_WinPlayerToJson(_$_WinPlayer instance) =>
    <String, dynamic>{
      'position': _$PositionEnumMap[instance.position],
      'han': instance.han,
      'fu': instance.fu,
    };

const _$PositionEnumMap = {
  Position.bottom: 'BOTTOM',
  Position.right: 'RIGHT',
  Position.top: 'TOP',
  Position.left: 'LEFT',
};
