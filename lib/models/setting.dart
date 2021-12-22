import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utility/enum/position.dart';

part 'setting.freezed.dart';
part 'setting.g.dart';

@freezed
class Setting with _$Setting {
  const factory Setting({
    @JsonKey(name: 'given_starting_point')
    @Default(25000)
        int givenStartingPoint,
    @JsonKey(name: 'starting_point') @Default(30000) int startingPoint,
    @JsonKey(name: 'riichibou_point') @Default(1000) int riichibouPoint,
    @JsonKey(name: 'bonba_point') @Default(300) int bonbaPoint,
    @JsonKey(name: 'ryukyoku_point') @Default(3000) int ryukyokuPoint,
    @JsonKey(name: 'uma_small') @Default(10) int umaSmall,
    @JsonKey(name: 'uma_big') @Default(20) int umaBig,
    @JsonKey(name: 'is_kiriage') @Default(false) bool isKiriage,
    @JsonKey(name: 'is_douten') @Default(false) bool isDouten,
    @JsonKey(name: 'first_oya') @Default(Position.bottom) Position firstOya,
  }) = _Setting;
  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
}
