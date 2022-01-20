// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'point_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PointSetting _$PointSettingFromJson(Map<String, dynamic> json) {
  return _PointSetting.fromJson(json);
}

/// @nodoc
class _$PointSettingTearOff {
  const _$PointSettingTearOff();

  _PointSetting call(
      {required Map<Position, Player> players,
      @JsonKey(name: 'current_kyoku') int currentKyoku = 0,
      int bonba = 0,
      int riichibou = 0}) {
    return _PointSetting(
      players: players,
      currentKyoku: currentKyoku,
      bonba: bonba,
      riichibou: riichibou,
    );
  }

  PointSetting fromJson(Map<String, Object?> json) {
    return PointSetting.fromJson(json);
  }
}

/// @nodoc
const $PointSetting = _$PointSettingTearOff();

/// @nodoc
mixin _$PointSetting {
  Map<Position, Player> get players => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_kyoku')
  int get currentKyoku => throw _privateConstructorUsedError;
  int get bonba => throw _privateConstructorUsedError;
  int get riichibou => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointSettingCopyWith<PointSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointSettingCopyWith<$Res> {
  factory $PointSettingCopyWith(
          PointSetting value, $Res Function(PointSetting) then) =
      _$PointSettingCopyWithImpl<$Res>;
  $Res call(
      {Map<Position, Player> players,
      @JsonKey(name: 'current_kyoku') int currentKyoku,
      int bonba,
      int riichibou});
}

/// @nodoc
class _$PointSettingCopyWithImpl<$Res> implements $PointSettingCopyWith<$Res> {
  _$PointSettingCopyWithImpl(this._value, this._then);

  final PointSetting _value;
  // ignore: unused_field
  final $Res Function(PointSetting) _then;

  @override
  $Res call({
    Object? players = freezed,
    Object? currentKyoku = freezed,
    Object? bonba = freezed,
    Object? riichibou = freezed,
  }) {
    return _then(_value.copyWith(
      players: players == freezed
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as Map<Position, Player>,
      currentKyoku: currentKyoku == freezed
          ? _value.currentKyoku
          : currentKyoku // ignore: cast_nullable_to_non_nullable
              as int,
      bonba: bonba == freezed
          ? _value.bonba
          : bonba // ignore: cast_nullable_to_non_nullable
              as int,
      riichibou: riichibou == freezed
          ? _value.riichibou
          : riichibou // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PointSettingCopyWith<$Res>
    implements $PointSettingCopyWith<$Res> {
  factory _$PointSettingCopyWith(
          _PointSetting value, $Res Function(_PointSetting) then) =
      __$PointSettingCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<Position, Player> players,
      @JsonKey(name: 'current_kyoku') int currentKyoku,
      int bonba,
      int riichibou});
}

/// @nodoc
class __$PointSettingCopyWithImpl<$Res> extends _$PointSettingCopyWithImpl<$Res>
    implements _$PointSettingCopyWith<$Res> {
  __$PointSettingCopyWithImpl(
      _PointSetting _value, $Res Function(_PointSetting) _then)
      : super(_value, (v) => _then(v as _PointSetting));

  @override
  _PointSetting get _value => super._value as _PointSetting;

  @override
  $Res call({
    Object? players = freezed,
    Object? currentKyoku = freezed,
    Object? bonba = freezed,
    Object? riichibou = freezed,
  }) {
    return _then(_PointSetting(
      players: players == freezed
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as Map<Position, Player>,
      currentKyoku: currentKyoku == freezed
          ? _value.currentKyoku
          : currentKyoku // ignore: cast_nullable_to_non_nullable
              as int,
      bonba: bonba == freezed
          ? _value.bonba
          : bonba // ignore: cast_nullable_to_non_nullable
              as int,
      riichibou: riichibou == freezed
          ? _value.riichibou
          : riichibou // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PointSetting extends _PointSetting with DiagnosticableTreeMixin {
  const _$_PointSetting(
      {required this.players,
      @JsonKey(name: 'current_kyoku') this.currentKyoku = 0,
      this.bonba = 0,
      this.riichibou = 0})
      : super._();

  factory _$_PointSetting.fromJson(Map<String, dynamic> json) =>
      _$$_PointSettingFromJson(json);

  @override
  final Map<Position, Player> players;
  @override
  @JsonKey(name: 'current_kyoku')
  final int currentKyoku;
  @JsonKey()
  @override
  final int bonba;
  @JsonKey()
  @override
  final int riichibou;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PointSetting(players: $players, currentKyoku: $currentKyoku, bonba: $bonba, riichibou: $riichibou)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PointSetting'))
      ..add(DiagnosticsProperty('players', players))
      ..add(DiagnosticsProperty('currentKyoku', currentKyoku))
      ..add(DiagnosticsProperty('bonba', bonba))
      ..add(DiagnosticsProperty('riichibou', riichibou));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PointSetting &&
            const DeepCollectionEquality().equals(other.players, players) &&
            const DeepCollectionEquality()
                .equals(other.currentKyoku, currentKyoku) &&
            const DeepCollectionEquality().equals(other.bonba, bonba) &&
            const DeepCollectionEquality().equals(other.riichibou, riichibou));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(players),
      const DeepCollectionEquality().hash(currentKyoku),
      const DeepCollectionEquality().hash(bonba),
      const DeepCollectionEquality().hash(riichibou));

  @JsonKey(ignore: true)
  @override
  _$PointSettingCopyWith<_PointSetting> get copyWith =>
      __$PointSettingCopyWithImpl<_PointSetting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PointSettingToJson(this);
  }
}

abstract class _PointSetting extends PointSetting {
  const factory _PointSetting(
      {required Map<Position, Player> players,
      @JsonKey(name: 'current_kyoku') int currentKyoku,
      int bonba,
      int riichibou}) = _$_PointSetting;
  const _PointSetting._() : super._();

  factory _PointSetting.fromJson(Map<String, dynamic> json) =
      _$_PointSetting.fromJson;

  @override
  Map<Position, Player> get players;
  @override
  @JsonKey(name: 'current_kyoku')
  int get currentKyoku;
  @override
  int get bonba;
  @override
  int get riichibou;
  @override
  @JsonKey(ignore: true)
  _$PointSettingCopyWith<_PointSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
