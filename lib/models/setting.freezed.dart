// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
class _$SettingTearOff {
  const _$SettingTearOff();

  _Setting call(
      {@JsonKey(name: 'given_starting_point') int givenStartingPoint = 25000,
      @JsonKey(name: 'starting_point') int startingPoint = 30000,
      @JsonKey(name: 'riichibou_point') int riichibouPoint = 1000,
      @JsonKey(name: 'bonba_point') int bonbaPoint = 300,
      @JsonKey(name: 'ryukyoku_point') int ryukyokuPoint = 3000,
      @JsonKey(name: 'uma_small') int umaSmall = 10,
      @JsonKey(name: 'uma_big') int umaBig = 20,
      @JsonKey(name: 'is_kiriage') bool isKiriage = false,
      @JsonKey(name: 'is_douten') bool isDouten = false,
      @JsonKey(name: 'first_oya') Position firstOya = Position.bottom}) {
    return _Setting(
      givenStartingPoint: givenStartingPoint,
      startingPoint: startingPoint,
      riichibouPoint: riichibouPoint,
      bonbaPoint: bonbaPoint,
      ryukyokuPoint: ryukyokuPoint,
      umaSmall: umaSmall,
      umaBig: umaBig,
      isKiriage: isKiriage,
      isDouten: isDouten,
      firstOya: firstOya,
    );
  }

  Setting fromJson(Map<String, Object?> json) {
    return Setting.fromJson(json);
  }
}

/// @nodoc
const $Setting = _$SettingTearOff();

/// @nodoc
mixin _$Setting {
  @JsonKey(name: 'given_starting_point')
  int get givenStartingPoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'starting_point')
  int get startingPoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'riichibou_point')
  int get riichibouPoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'bonba_point')
  int get bonbaPoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'ryukyoku_point')
  int get ryukyokuPoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'uma_small')
  int get umaSmall => throw _privateConstructorUsedError;
  @JsonKey(name: 'uma_big')
  int get umaBig => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_kiriage')
  bool get isKiriage => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_douten')
  bool get isDouten => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_oya')
  Position get firstOya => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingCopyWith<Setting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'given_starting_point') int givenStartingPoint,
      @JsonKey(name: 'starting_point') int startingPoint,
      @JsonKey(name: 'riichibou_point') int riichibouPoint,
      @JsonKey(name: 'bonba_point') int bonbaPoint,
      @JsonKey(name: 'ryukyoku_point') int ryukyokuPoint,
      @JsonKey(name: 'uma_small') int umaSmall,
      @JsonKey(name: 'uma_big') int umaBig,
      @JsonKey(name: 'is_kiriage') bool isKiriage,
      @JsonKey(name: 'is_douten') bool isDouten,
      @JsonKey(name: 'first_oya') Position firstOya});
}

/// @nodoc
class _$SettingCopyWithImpl<$Res> implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._value, this._then);

  final Setting _value;
  // ignore: unused_field
  final $Res Function(Setting) _then;

  @override
  $Res call({
    Object? givenStartingPoint = freezed,
    Object? startingPoint = freezed,
    Object? riichibouPoint = freezed,
    Object? bonbaPoint = freezed,
    Object? ryukyokuPoint = freezed,
    Object? umaSmall = freezed,
    Object? umaBig = freezed,
    Object? isKiriage = freezed,
    Object? isDouten = freezed,
    Object? firstOya = freezed,
  }) {
    return _then(_value.copyWith(
      givenStartingPoint: givenStartingPoint == freezed
          ? _value.givenStartingPoint
          : givenStartingPoint // ignore: cast_nullable_to_non_nullable
              as int,
      startingPoint: startingPoint == freezed
          ? _value.startingPoint
          : startingPoint // ignore: cast_nullable_to_non_nullable
              as int,
      riichibouPoint: riichibouPoint == freezed
          ? _value.riichibouPoint
          : riichibouPoint // ignore: cast_nullable_to_non_nullable
              as int,
      bonbaPoint: bonbaPoint == freezed
          ? _value.bonbaPoint
          : bonbaPoint // ignore: cast_nullable_to_non_nullable
              as int,
      ryukyokuPoint: ryukyokuPoint == freezed
          ? _value.ryukyokuPoint
          : ryukyokuPoint // ignore: cast_nullable_to_non_nullable
              as int,
      umaSmall: umaSmall == freezed
          ? _value.umaSmall
          : umaSmall // ignore: cast_nullable_to_non_nullable
              as int,
      umaBig: umaBig == freezed
          ? _value.umaBig
          : umaBig // ignore: cast_nullable_to_non_nullable
              as int,
      isKiriage: isKiriage == freezed
          ? _value.isKiriage
          : isKiriage // ignore: cast_nullable_to_non_nullable
              as bool,
      isDouten: isDouten == freezed
          ? _value.isDouten
          : isDouten // ignore: cast_nullable_to_non_nullable
              as bool,
      firstOya: firstOya == freezed
          ? _value.firstOya
          : firstOya // ignore: cast_nullable_to_non_nullable
              as Position,
    ));
  }
}

/// @nodoc
abstract class _$SettingCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$SettingCopyWith(_Setting value, $Res Function(_Setting) then) =
      __$SettingCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'given_starting_point') int givenStartingPoint,
      @JsonKey(name: 'starting_point') int startingPoint,
      @JsonKey(name: 'riichibou_point') int riichibouPoint,
      @JsonKey(name: 'bonba_point') int bonbaPoint,
      @JsonKey(name: 'ryukyoku_point') int ryukyokuPoint,
      @JsonKey(name: 'uma_small') int umaSmall,
      @JsonKey(name: 'uma_big') int umaBig,
      @JsonKey(name: 'is_kiriage') bool isKiriage,
      @JsonKey(name: 'is_douten') bool isDouten,
      @JsonKey(name: 'first_oya') Position firstOya});
}

/// @nodoc
class __$SettingCopyWithImpl<$Res> extends _$SettingCopyWithImpl<$Res>
    implements _$SettingCopyWith<$Res> {
  __$SettingCopyWithImpl(_Setting _value, $Res Function(_Setting) _then)
      : super(_value, (v) => _then(v as _Setting));

  @override
  _Setting get _value => super._value as _Setting;

  @override
  $Res call({
    Object? givenStartingPoint = freezed,
    Object? startingPoint = freezed,
    Object? riichibouPoint = freezed,
    Object? bonbaPoint = freezed,
    Object? ryukyokuPoint = freezed,
    Object? umaSmall = freezed,
    Object? umaBig = freezed,
    Object? isKiriage = freezed,
    Object? isDouten = freezed,
    Object? firstOya = freezed,
  }) {
    return _then(_Setting(
      givenStartingPoint: givenStartingPoint == freezed
          ? _value.givenStartingPoint
          : givenStartingPoint // ignore: cast_nullable_to_non_nullable
              as int,
      startingPoint: startingPoint == freezed
          ? _value.startingPoint
          : startingPoint // ignore: cast_nullable_to_non_nullable
              as int,
      riichibouPoint: riichibouPoint == freezed
          ? _value.riichibouPoint
          : riichibouPoint // ignore: cast_nullable_to_non_nullable
              as int,
      bonbaPoint: bonbaPoint == freezed
          ? _value.bonbaPoint
          : bonbaPoint // ignore: cast_nullable_to_non_nullable
              as int,
      ryukyokuPoint: ryukyokuPoint == freezed
          ? _value.ryukyokuPoint
          : ryukyokuPoint // ignore: cast_nullable_to_non_nullable
              as int,
      umaSmall: umaSmall == freezed
          ? _value.umaSmall
          : umaSmall // ignore: cast_nullable_to_non_nullable
              as int,
      umaBig: umaBig == freezed
          ? _value.umaBig
          : umaBig // ignore: cast_nullable_to_non_nullable
              as int,
      isKiriage: isKiriage == freezed
          ? _value.isKiriage
          : isKiriage // ignore: cast_nullable_to_non_nullable
              as bool,
      isDouten: isDouten == freezed
          ? _value.isDouten
          : isDouten // ignore: cast_nullable_to_non_nullable
              as bool,
      firstOya: firstOya == freezed
          ? _value.firstOya
          : firstOya // ignore: cast_nullable_to_non_nullable
              as Position,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Setting with DiagnosticableTreeMixin implements _Setting {
  const _$_Setting(
      {@JsonKey(name: 'given_starting_point') this.givenStartingPoint = 25000,
      @JsonKey(name: 'starting_point') this.startingPoint = 30000,
      @JsonKey(name: 'riichibou_point') this.riichibouPoint = 1000,
      @JsonKey(name: 'bonba_point') this.bonbaPoint = 300,
      @JsonKey(name: 'ryukyoku_point') this.ryukyokuPoint = 3000,
      @JsonKey(name: 'uma_small') this.umaSmall = 10,
      @JsonKey(name: 'uma_big') this.umaBig = 20,
      @JsonKey(name: 'is_kiriage') this.isKiriage = false,
      @JsonKey(name: 'is_douten') this.isDouten = false,
      @JsonKey(name: 'first_oya') this.firstOya = Position.bottom});

  factory _$_Setting.fromJson(Map<String, dynamic> json) =>
      _$$_SettingFromJson(json);

  @override
  @JsonKey(name: 'given_starting_point')
  final int givenStartingPoint;
  @override
  @JsonKey(name: 'starting_point')
  final int startingPoint;
  @override
  @JsonKey(name: 'riichibou_point')
  final int riichibouPoint;
  @override
  @JsonKey(name: 'bonba_point')
  final int bonbaPoint;
  @override
  @JsonKey(name: 'ryukyoku_point')
  final int ryukyokuPoint;
  @override
  @JsonKey(name: 'uma_small')
  final int umaSmall;
  @override
  @JsonKey(name: 'uma_big')
  final int umaBig;
  @override
  @JsonKey(name: 'is_kiriage')
  final bool isKiriage;
  @override
  @JsonKey(name: 'is_douten')
  final bool isDouten;
  @override
  @JsonKey(name: 'first_oya')
  final Position firstOya;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Setting(givenStartingPoint: $givenStartingPoint, startingPoint: $startingPoint, riichibouPoint: $riichibouPoint, bonbaPoint: $bonbaPoint, ryukyokuPoint: $ryukyokuPoint, umaSmall: $umaSmall, umaBig: $umaBig, isKiriage: $isKiriage, isDouten: $isDouten, firstOya: $firstOya)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Setting'))
      ..add(DiagnosticsProperty('givenStartingPoint', givenStartingPoint))
      ..add(DiagnosticsProperty('startingPoint', startingPoint))
      ..add(DiagnosticsProperty('riichibouPoint', riichibouPoint))
      ..add(DiagnosticsProperty('bonbaPoint', bonbaPoint))
      ..add(DiagnosticsProperty('ryukyokuPoint', ryukyokuPoint))
      ..add(DiagnosticsProperty('umaSmall', umaSmall))
      ..add(DiagnosticsProperty('umaBig', umaBig))
      ..add(DiagnosticsProperty('isKiriage', isKiriage))
      ..add(DiagnosticsProperty('isDouten', isDouten))
      ..add(DiagnosticsProperty('firstOya', firstOya));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Setting &&
            const DeepCollectionEquality()
                .equals(other.givenStartingPoint, givenStartingPoint) &&
            const DeepCollectionEquality()
                .equals(other.startingPoint, startingPoint) &&
            const DeepCollectionEquality()
                .equals(other.riichibouPoint, riichibouPoint) &&
            const DeepCollectionEquality()
                .equals(other.bonbaPoint, bonbaPoint) &&
            const DeepCollectionEquality()
                .equals(other.ryukyokuPoint, ryukyokuPoint) &&
            const DeepCollectionEquality().equals(other.umaSmall, umaSmall) &&
            const DeepCollectionEquality().equals(other.umaBig, umaBig) &&
            const DeepCollectionEquality().equals(other.isKiriage, isKiriage) &&
            const DeepCollectionEquality().equals(other.isDouten, isDouten) &&
            const DeepCollectionEquality().equals(other.firstOya, firstOya));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(givenStartingPoint),
      const DeepCollectionEquality().hash(startingPoint),
      const DeepCollectionEquality().hash(riichibouPoint),
      const DeepCollectionEquality().hash(bonbaPoint),
      const DeepCollectionEquality().hash(ryukyokuPoint),
      const DeepCollectionEquality().hash(umaSmall),
      const DeepCollectionEquality().hash(umaBig),
      const DeepCollectionEquality().hash(isKiriage),
      const DeepCollectionEquality().hash(isDouten),
      const DeepCollectionEquality().hash(firstOya));

  @JsonKey(ignore: true)
  @override
  _$SettingCopyWith<_Setting> get copyWith =>
      __$SettingCopyWithImpl<_Setting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingToJson(this);
  }
}

abstract class _Setting implements Setting {
  const factory _Setting(
      {@JsonKey(name: 'given_starting_point') int givenStartingPoint,
      @JsonKey(name: 'starting_point') int startingPoint,
      @JsonKey(name: 'riichibou_point') int riichibouPoint,
      @JsonKey(name: 'bonba_point') int bonbaPoint,
      @JsonKey(name: 'ryukyoku_point') int ryukyokuPoint,
      @JsonKey(name: 'uma_small') int umaSmall,
      @JsonKey(name: 'uma_big') int umaBig,
      @JsonKey(name: 'is_kiriage') bool isKiriage,
      @JsonKey(name: 'is_douten') bool isDouten,
      @JsonKey(name: 'first_oya') Position firstOya}) = _$_Setting;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$_Setting.fromJson;

  @override
  @JsonKey(name: 'given_starting_point')
  int get givenStartingPoint;
  @override
  @JsonKey(name: 'starting_point')
  int get startingPoint;
  @override
  @JsonKey(name: 'riichibou_point')
  int get riichibouPoint;
  @override
  @JsonKey(name: 'bonba_point')
  int get bonbaPoint;
  @override
  @JsonKey(name: 'ryukyoku_point')
  int get ryukyokuPoint;
  @override
  @JsonKey(name: 'uma_small')
  int get umaSmall;
  @override
  @JsonKey(name: 'uma_big')
  int get umaBig;
  @override
  @JsonKey(name: 'is_kiriage')
  bool get isKiriage;
  @override
  @JsonKey(name: 'is_douten')
  bool get isDouten;
  @override
  @JsonKey(name: 'first_oya')
  Position get firstOya;
  @override
  @JsonKey(ignore: true)
  _$SettingCopyWith<_Setting> get copyWith =>
      throw _privateConstructorUsedError;
}
