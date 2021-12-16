// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return _GamePlayer.fromJson(json);
}

/// @nodoc
class _$GamePlayerTearOff {
  const _$GamePlayerTearOff();

  _GamePlayer call(
      {required String uid,
      @JsonKey(name: 'display_name') required String displayName}) {
    return _GamePlayer(
      uid: uid,
      displayName: displayName,
    );
  }

  GamePlayer fromJson(Map<String, Object?> json) {
    return GamePlayer.fromJson(json);
  }
}

/// @nodoc
const $GamePlayer = _$GamePlayerTearOff();

/// @nodoc
mixin _$GamePlayer {
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePlayerCopyWith<GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlayerCopyWith<$Res> {
  factory $GamePlayerCopyWith(
          GamePlayer value, $Res Function(GamePlayer) then) =
      _$GamePlayerCopyWithImpl<$Res>;
  $Res call({String uid, @JsonKey(name: 'display_name') String displayName});
}

/// @nodoc
class _$GamePlayerCopyWithImpl<$Res> implements $GamePlayerCopyWith<$Res> {
  _$GamePlayerCopyWithImpl(this._value, this._then);

  final GamePlayer _value;
  // ignore: unused_field
  final $Res Function(GamePlayer) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$GamePlayerCopyWith<$Res> implements $GamePlayerCopyWith<$Res> {
  factory _$GamePlayerCopyWith(
          _GamePlayer value, $Res Function(_GamePlayer) then) =
      __$GamePlayerCopyWithImpl<$Res>;
  @override
  $Res call({String uid, @JsonKey(name: 'display_name') String displayName});
}

/// @nodoc
class __$GamePlayerCopyWithImpl<$Res> extends _$GamePlayerCopyWithImpl<$Res>
    implements _$GamePlayerCopyWith<$Res> {
  __$GamePlayerCopyWithImpl(
      _GamePlayer _value, $Res Function(_GamePlayer) _then)
      : super(_value, (v) => _then(v as _GamePlayer));

  @override
  _GamePlayer get _value => super._value as _GamePlayer;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_GamePlayer(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GamePlayer implements _GamePlayer {
  const _$_GamePlayer(
      {required this.uid,
      @JsonKey(name: 'display_name') required this.displayName});

  factory _$_GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$$_GamePlayerFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;

  @override
  String toString() {
    return 'GamePlayer(uid: $uid, displayName: $displayName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GamePlayer &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(displayName));

  @JsonKey(ignore: true)
  @override
  _$GamePlayerCopyWith<_GamePlayer> get copyWith =>
      __$GamePlayerCopyWithImpl<_GamePlayer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GamePlayerToJson(this);
  }
}

abstract class _GamePlayer implements GamePlayer {
  const factory _GamePlayer(
          {required String uid,
          @JsonKey(name: 'display_name') required String displayName}) =
      _$_GamePlayer;

  factory _GamePlayer.fromJson(Map<String, dynamic> json) =
      _$_GamePlayer.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(ignore: true)
  _$GamePlayerCopyWith<_GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
