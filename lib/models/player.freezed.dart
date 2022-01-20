// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
class _$PlayerTearOff {
  const _$PlayerTearOff();

  _Player call({required int point, required bool isRiichi}) {
    return _Player(
      point: point,
      isRiichi: isRiichi,
    );
  }

  Player fromJson(Map<String, Object?> json) {
    return Player.fromJson(json);
  }
}

/// @nodoc
const $Player = _$PlayerTearOff();

/// @nodoc
mixin _$Player {
  int get point => throw _privateConstructorUsedError;
  bool get isRiichi => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res>;
  $Res call({int point, bool isRiichi});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res> implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  final Player _value;
  // ignore: unused_field
  final $Res Function(Player) _then;

  @override
  $Res call({
    Object? point = freezed,
    Object? isRiichi = freezed,
  }) {
    return _then(_value.copyWith(
      point: point == freezed
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
      isRiichi: isRiichi == freezed
          ? _value.isRiichi
          : isRiichi // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) then) =
      __$PlayerCopyWithImpl<$Res>;
  @override
  $Res call({int point, bool isRiichi});
}

/// @nodoc
class __$PlayerCopyWithImpl<$Res> extends _$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(_Player _value, $Res Function(_Player) _then)
      : super(_value, (v) => _then(v as _Player));

  @override
  _Player get _value => super._value as _Player;

  @override
  $Res call({
    Object? point = freezed,
    Object? isRiichi = freezed,
  }) {
    return _then(_Player(
      point: point == freezed
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
      isRiichi: isRiichi == freezed
          ? _value.isRiichi
          : isRiichi // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Player with DiagnosticableTreeMixin implements _Player {
  const _$_Player({required this.point, required this.isRiichi});

  factory _$_Player.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerFromJson(json);

  @override
  final int point;
  @override
  final bool isRiichi;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Player(point: $point, isRiichi: $isRiichi)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Player'))
      ..add(DiagnosticsProperty('point', point))
      ..add(DiagnosticsProperty('isRiichi', isRiichi));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Player &&
            const DeepCollectionEquality().equals(other.point, point) &&
            const DeepCollectionEquality().equals(other.isRiichi, isRiichi));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(point),
      const DeepCollectionEquality().hash(isRiichi));

  @JsonKey(ignore: true)
  @override
  _$PlayerCopyWith<_Player> get copyWith =>
      __$PlayerCopyWithImpl<_Player>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerToJson(this);
  }
}

abstract class _Player implements Player {
  const factory _Player({required int point, required bool isRiichi}) =
      _$_Player;

  factory _Player.fromJson(Map<String, dynamic> json) = _$_Player.fromJson;

  @override
  int get point;
  @override
  bool get isRiichi;
  @override
  @JsonKey(ignore: true)
  _$PlayerCopyWith<_Player> get copyWith => throw _privateConstructorUsedError;
}
