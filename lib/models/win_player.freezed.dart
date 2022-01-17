// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'win_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WinPlayer _$WinPlayerFromJson(Map<String, dynamic> json) {
  return _WinPlayer.fromJson(json);
}

/// @nodoc
class _$WinPlayerTearOff {
  const _$WinPlayerTearOff();

  _WinPlayer call(
      {required Position position, required int han, required int fu}) {
    return _WinPlayer(
      position: position,
      han: han,
      fu: fu,
    );
  }

  WinPlayer fromJson(Map<String, Object?> json) {
    return WinPlayer.fromJson(json);
  }
}

/// @nodoc
const $WinPlayer = _$WinPlayerTearOff();

/// @nodoc
mixin _$WinPlayer {
  Position get position => throw _privateConstructorUsedError;
  int get han => throw _privateConstructorUsedError;
  int get fu => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WinPlayerCopyWith<WinPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WinPlayerCopyWith<$Res> {
  factory $WinPlayerCopyWith(WinPlayer value, $Res Function(WinPlayer) then) =
      _$WinPlayerCopyWithImpl<$Res>;
  $Res call({Position position, int han, int fu});
}

/// @nodoc
class _$WinPlayerCopyWithImpl<$Res> implements $WinPlayerCopyWith<$Res> {
  _$WinPlayerCopyWithImpl(this._value, this._then);

  final WinPlayer _value;
  // ignore: unused_field
  final $Res Function(WinPlayer) _then;

  @override
  $Res call({
    Object? position = freezed,
    Object? han = freezed,
    Object? fu = freezed,
  }) {
    return _then(_value.copyWith(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      han: han == freezed
          ? _value.han
          : han // ignore: cast_nullable_to_non_nullable
              as int,
      fu: fu == freezed
          ? _value.fu
          : fu // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$WinPlayerCopyWith<$Res> implements $WinPlayerCopyWith<$Res> {
  factory _$WinPlayerCopyWith(
          _WinPlayer value, $Res Function(_WinPlayer) then) =
      __$WinPlayerCopyWithImpl<$Res>;
  @override
  $Res call({Position position, int han, int fu});
}

/// @nodoc
class __$WinPlayerCopyWithImpl<$Res> extends _$WinPlayerCopyWithImpl<$Res>
    implements _$WinPlayerCopyWith<$Res> {
  __$WinPlayerCopyWithImpl(_WinPlayer _value, $Res Function(_WinPlayer) _then)
      : super(_value, (v) => _then(v as _WinPlayer));

  @override
  _WinPlayer get _value => super._value as _WinPlayer;

  @override
  $Res call({
    Object? position = freezed,
    Object? han = freezed,
    Object? fu = freezed,
  }) {
    return _then(_WinPlayer(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      han: han == freezed
          ? _value.han
          : han // ignore: cast_nullable_to_non_nullable
              as int,
      fu: fu == freezed
          ? _value.fu
          : fu // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WinPlayer with DiagnosticableTreeMixin implements _WinPlayer {
  const _$_WinPlayer(
      {required this.position, required this.han, required this.fu});

  factory _$_WinPlayer.fromJson(Map<String, dynamic> json) =>
      _$$_WinPlayerFromJson(json);

  @override
  final Position position;
  @override
  final int han;
  @override
  final int fu;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WinPlayer(position: $position, han: $han, fu: $fu)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WinPlayer'))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('han', han))
      ..add(DiagnosticsProperty('fu', fu));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WinPlayer &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.han, han) &&
            const DeepCollectionEquality().equals(other.fu, fu));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(han),
      const DeepCollectionEquality().hash(fu));

  @JsonKey(ignore: true)
  @override
  _$WinPlayerCopyWith<_WinPlayer> get copyWith =>
      __$WinPlayerCopyWithImpl<_WinPlayer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WinPlayerToJson(this);
  }
}

abstract class _WinPlayer implements WinPlayer {
  const factory _WinPlayer(
      {required Position position,
      required int han,
      required int fu}) = _$_WinPlayer;

  factory _WinPlayer.fromJson(Map<String, dynamic> json) =
      _$_WinPlayer.fromJson;

  @override
  Position get position;
  @override
  int get han;
  @override
  int get fu;
  @override
  @JsonKey(ignore: true)
  _$WinPlayerCopyWith<_WinPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
