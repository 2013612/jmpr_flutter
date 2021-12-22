// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
class _$GameTearOff {
  const _$GameTearOff();

  _Game call(
      {@JsonKey(name: 'game_players') required List<GamePlayer> gamePlayers,
      required List<History> histories,
      @JsonKey(name: 'created_at') required DateTime createdAt,
      required Setting setting}) {
    return _Game(
      gamePlayers: gamePlayers,
      histories: histories,
      createdAt: createdAt,
      setting: setting,
    );
  }

  Game fromJson(Map<String, Object?> json) {
    return Game.fromJson(json);
  }
}

/// @nodoc
const $Game = _$GameTearOff();

/// @nodoc
mixin _$Game {
  @JsonKey(name: 'game_players')
  List<GamePlayer> get gamePlayers => throw _privateConstructorUsedError;
  List<History> get histories => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  Setting get setting => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'game_players') List<GamePlayer> gamePlayers,
      List<History> histories,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Setting setting});

  $SettingCopyWith<$Res> get setting;
}

/// @nodoc
class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  final Game _value;
  // ignore: unused_field
  final $Res Function(Game) _then;

  @override
  $Res call({
    Object? gamePlayers = freezed,
    Object? histories = freezed,
    Object? createdAt = freezed,
    Object? setting = freezed,
  }) {
    return _then(_value.copyWith(
      gamePlayers: gamePlayers == freezed
          ? _value.gamePlayers
          : gamePlayers // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
      histories: histories == freezed
          ? _value.histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      setting: setting == freezed
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting,
    ));
  }

  @override
  $SettingCopyWith<$Res> get setting {
    return $SettingCopyWith<$Res>(_value.setting, (value) {
      return _then(_value.copyWith(setting: value));
    });
  }
}

/// @nodoc
abstract class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) then) =
      __$GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'game_players') List<GamePlayer> gamePlayers,
      List<History> histories,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Setting setting});

  @override
  $SettingCopyWith<$Res> get setting;
}

/// @nodoc
class __$GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(_Game _value, $Res Function(_Game) _then)
      : super(_value, (v) => _then(v as _Game));

  @override
  _Game get _value => super._value as _Game;

  @override
  $Res call({
    Object? gamePlayers = freezed,
    Object? histories = freezed,
    Object? createdAt = freezed,
    Object? setting = freezed,
  }) {
    return _then(_Game(
      gamePlayers: gamePlayers == freezed
          ? _value.gamePlayers
          : gamePlayers // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
      histories: histories == freezed
          ? _value.histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      setting: setting == freezed
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Game with DiagnosticableTreeMixin implements _Game {
  const _$_Game(
      {@JsonKey(name: 'game_players') required this.gamePlayers,
      required this.histories,
      @JsonKey(name: 'created_at') required this.createdAt,
      required this.setting});

  factory _$_Game.fromJson(Map<String, dynamic> json) => _$$_GameFromJson(json);

  @override
  @JsonKey(name: 'game_players')
  final List<GamePlayer> gamePlayers;
  @override
  final List<History> histories;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final Setting setting;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Game(gamePlayers: $gamePlayers, histories: $histories, createdAt: $createdAt, setting: $setting)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Game'))
      ..add(DiagnosticsProperty('gamePlayers', gamePlayers))
      ..add(DiagnosticsProperty('histories', histories))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('setting', setting));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Game &&
            const DeepCollectionEquality()
                .equals(other.gamePlayers, gamePlayers) &&
            const DeepCollectionEquality().equals(other.histories, histories) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.setting, setting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gamePlayers),
      const DeepCollectionEquality().hash(histories),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(setting));

  @JsonKey(ignore: true)
  @override
  _$GameCopyWith<_Game> get copyWith =>
      __$GameCopyWithImpl<_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameToJson(this);
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {@JsonKey(name: 'game_players') required List<GamePlayer> gamePlayers,
      required List<History> histories,
      @JsonKey(name: 'created_at') required DateTime createdAt,
      required Setting setting}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  @JsonKey(name: 'game_players')
  List<GamePlayer> get gamePlayers;
  @override
  List<History> get histories;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  Setting get setting;
  @override
  @JsonKey(ignore: true)
  _$GameCopyWith<_Game> get copyWith => throw _privateConstructorUsedError;
}
