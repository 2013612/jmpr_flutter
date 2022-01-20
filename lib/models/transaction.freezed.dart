// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'ron':
      return TransactionRon.fromJson(json);
    case 'tsumo':
      return TransactionTsumo.fromJson(json);
    case 'ryukyoku':
      return TransactionRyukyoku.fromJson(json);
    case 'edit':
      return TransactionEdit.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Transaction',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  TransactionRon ron(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending = Ending.ron,
      @JsonKey(name: 'lose_player')
          required Position losePlayer,
      @JsonKey(name: 'win_players')
          required List<WinPlayer> winPlayers}) {
    return TransactionRon(
      playerPoints: playerPoints,
      ending: ending,
      losePlayer: losePlayer,
      winPlayers: winPlayers,
    );
  }

  TransactionTsumo tsumo(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending = Ending.tsumo,
      @JsonKey(name: 'win_player')
          required WinPlayer winPlayer}) {
    return TransactionTsumo(
      playerPoints: playerPoints,
      ending: ending,
      winPlayer: winPlayer,
    );
  }

  TransactionRyukyoku ryukyoku(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending = Ending.ryukyoku,
      required Map<Position, bool> tenpai,
      required Map<Position, bool> nagashimangan}) {
    return TransactionRyukyoku(
      playerPoints: playerPoints,
      ending: ending,
      tenpai: tenpai,
      nagashimangan: nagashimangan,
    );
  }

  TransactionEdit edit(
      {@JsonKey(name: 'point_setting') required PointSetting pointSetting,
      Ending ending = Ending.edit}) {
    return TransactionEdit(
      pointSetting: pointSetting,
      ending: ending,
    );
  }

  Transaction fromJson(Map<String, Object?> json) {
    return Transaction.fromJson(json);
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  Ending get ending => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)
        ron,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)
        tsumo,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)
        ryukyoku,
    required TResult Function(
            @JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)
        edit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionRon value) ron,
    required TResult Function(TransactionTsumo value) tsumo,
    required TResult Function(TransactionRyukyoku value) ryukyoku,
    required TResult Function(TransactionEdit value) edit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call({Ending ending});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? ending = freezed,
  }) {
    return _then(_value.copyWith(
      ending: ending == freezed
          ? _value.ending
          : ending // ignore: cast_nullable_to_non_nullable
              as Ending,
    ));
  }
}

/// @nodoc
abstract class $TransactionRonCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $TransactionRonCopyWith(
          TransactionRon value, $Res Function(TransactionRon) then) =
      _$TransactionRonCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
      Ending ending,
      @JsonKey(name: 'lose_player') Position losePlayer,
      @JsonKey(name: 'win_players') List<WinPlayer> winPlayers});
}

/// @nodoc
class _$TransactionRonCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements $TransactionRonCopyWith<$Res> {
  _$TransactionRonCopyWithImpl(
      TransactionRon _value, $Res Function(TransactionRon) _then)
      : super(_value, (v) => _then(v as TransactionRon));

  @override
  TransactionRon get _value => super._value as TransactionRon;

  @override
  $Res call({
    Object? playerPoints = freezed,
    Object? ending = freezed,
    Object? losePlayer = freezed,
    Object? winPlayers = freezed,
  }) {
    return _then(TransactionRon(
      playerPoints: playerPoints == freezed
          ? _value.playerPoints
          : playerPoints // ignore: cast_nullable_to_non_nullable
              as Map<Position, Player>,
      ending: ending == freezed
          ? _value.ending
          : ending // ignore: cast_nullable_to_non_nullable
              as Ending,
      losePlayer: losePlayer == freezed
          ? _value.losePlayer
          : losePlayer // ignore: cast_nullable_to_non_nullable
              as Position,
      winPlayers: winPlayers == freezed
          ? _value.winPlayers
          : winPlayers // ignore: cast_nullable_to_non_nullable
              as List<WinPlayer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionRon with DiagnosticableTreeMixin implements TransactionRon {
  const _$TransactionRon(
      {@JsonKey(name: 'player_points') required this.playerPoints,
      this.ending = Ending.ron,
      @JsonKey(name: 'lose_player') required this.losePlayer,
      @JsonKey(name: 'win_players') required this.winPlayers,
      String? $type})
      : $type = $type ?? 'ron';

  factory _$TransactionRon.fromJson(Map<String, dynamic> json) =>
      _$$TransactionRonFromJson(json);

  @override
  @JsonKey(name: 'player_points')
  final Map<Position, Player> playerPoints;
  @JsonKey()
  @override
  final Ending ending;
  @override
  @JsonKey(name: 'lose_player')
  final Position losePlayer;
  @override
  @JsonKey(name: 'win_players')
  final List<WinPlayer> winPlayers;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction.ron(playerPoints: $playerPoints, ending: $ending, losePlayer: $losePlayer, winPlayers: $winPlayers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction.ron'))
      ..add(DiagnosticsProperty('playerPoints', playerPoints))
      ..add(DiagnosticsProperty('ending', ending))
      ..add(DiagnosticsProperty('losePlayer', losePlayer))
      ..add(DiagnosticsProperty('winPlayers', winPlayers));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionRon &&
            const DeepCollectionEquality()
                .equals(other.playerPoints, playerPoints) &&
            const DeepCollectionEquality().equals(other.ending, ending) &&
            const DeepCollectionEquality()
                .equals(other.losePlayer, losePlayer) &&
            const DeepCollectionEquality()
                .equals(other.winPlayers, winPlayers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(playerPoints),
      const DeepCollectionEquality().hash(ending),
      const DeepCollectionEquality().hash(losePlayer),
      const DeepCollectionEquality().hash(winPlayers));

  @JsonKey(ignore: true)
  @override
  $TransactionRonCopyWith<TransactionRon> get copyWith =>
      _$TransactionRonCopyWithImpl<TransactionRon>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)
        ron,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)
        tsumo,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)
        ryukyoku,
    required TResult Function(
            @JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)
        edit,
  }) {
    return ron(playerPoints, ending, losePlayer, winPlayers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
  }) {
    return ron?.call(playerPoints, ending, losePlayer, winPlayers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
    required TResult orElse(),
  }) {
    if (ron != null) {
      return ron(playerPoints, ending, losePlayer, winPlayers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionRon value) ron,
    required TResult Function(TransactionTsumo value) tsumo,
    required TResult Function(TransactionRyukyoku value) ryukyoku,
    required TResult Function(TransactionEdit value) edit,
  }) {
    return ron(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
  }) {
    return ron?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
    required TResult orElse(),
  }) {
    if (ron != null) {
      return ron(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionRonToJson(this);
  }
}

abstract class TransactionRon implements Transaction {
  const factory TransactionRon(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending,
      @JsonKey(name: 'lose_player')
          required Position losePlayer,
      @JsonKey(name: 'win_players')
          required List<WinPlayer> winPlayers}) = _$TransactionRon;

  factory TransactionRon.fromJson(Map<String, dynamic> json) =
      _$TransactionRon.fromJson;

  @JsonKey(name: 'player_points')
  Map<Position, Player> get playerPoints;
  @override
  Ending get ending;
  @JsonKey(name: 'lose_player')
  Position get losePlayer;
  @JsonKey(name: 'win_players')
  List<WinPlayer> get winPlayers;
  @override
  @JsonKey(ignore: true)
  $TransactionRonCopyWith<TransactionRon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionTsumoCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $TransactionTsumoCopyWith(
          TransactionTsumo value, $Res Function(TransactionTsumo) then) =
      _$TransactionTsumoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
      Ending ending,
      @JsonKey(name: 'win_player') WinPlayer winPlayer});

  $WinPlayerCopyWith<$Res> get winPlayer;
}

/// @nodoc
class _$TransactionTsumoCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $TransactionTsumoCopyWith<$Res> {
  _$TransactionTsumoCopyWithImpl(
      TransactionTsumo _value, $Res Function(TransactionTsumo) _then)
      : super(_value, (v) => _then(v as TransactionTsumo));

  @override
  TransactionTsumo get _value => super._value as TransactionTsumo;

  @override
  $Res call({
    Object? playerPoints = freezed,
    Object? ending = freezed,
    Object? winPlayer = freezed,
  }) {
    return _then(TransactionTsumo(
      playerPoints: playerPoints == freezed
          ? _value.playerPoints
          : playerPoints // ignore: cast_nullable_to_non_nullable
              as Map<Position, Player>,
      ending: ending == freezed
          ? _value.ending
          : ending // ignore: cast_nullable_to_non_nullable
              as Ending,
      winPlayer: winPlayer == freezed
          ? _value.winPlayer
          : winPlayer // ignore: cast_nullable_to_non_nullable
              as WinPlayer,
    ));
  }

  @override
  $WinPlayerCopyWith<$Res> get winPlayer {
    return $WinPlayerCopyWith<$Res>(_value.winPlayer, (value) {
      return _then(_value.copyWith(winPlayer: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionTsumo
    with DiagnosticableTreeMixin
    implements TransactionTsumo {
  const _$TransactionTsumo(
      {@JsonKey(name: 'player_points') required this.playerPoints,
      this.ending = Ending.tsumo,
      @JsonKey(name: 'win_player') required this.winPlayer,
      String? $type})
      : $type = $type ?? 'tsumo';

  factory _$TransactionTsumo.fromJson(Map<String, dynamic> json) =>
      _$$TransactionTsumoFromJson(json);

  @override
  @JsonKey(name: 'player_points')
  final Map<Position, Player> playerPoints;
  @JsonKey()
  @override
  final Ending ending;
  @override
  @JsonKey(name: 'win_player')
  final WinPlayer winPlayer;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction.tsumo(playerPoints: $playerPoints, ending: $ending, winPlayer: $winPlayer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction.tsumo'))
      ..add(DiagnosticsProperty('playerPoints', playerPoints))
      ..add(DiagnosticsProperty('ending', ending))
      ..add(DiagnosticsProperty('winPlayer', winPlayer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionTsumo &&
            const DeepCollectionEquality()
                .equals(other.playerPoints, playerPoints) &&
            const DeepCollectionEquality().equals(other.ending, ending) &&
            const DeepCollectionEquality().equals(other.winPlayer, winPlayer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(playerPoints),
      const DeepCollectionEquality().hash(ending),
      const DeepCollectionEquality().hash(winPlayer));

  @JsonKey(ignore: true)
  @override
  $TransactionTsumoCopyWith<TransactionTsumo> get copyWith =>
      _$TransactionTsumoCopyWithImpl<TransactionTsumo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)
        ron,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)
        tsumo,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)
        ryukyoku,
    required TResult Function(
            @JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)
        edit,
  }) {
    return tsumo(playerPoints, ending, winPlayer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
  }) {
    return tsumo?.call(playerPoints, ending, winPlayer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
    required TResult orElse(),
  }) {
    if (tsumo != null) {
      return tsumo(playerPoints, ending, winPlayer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionRon value) ron,
    required TResult Function(TransactionTsumo value) tsumo,
    required TResult Function(TransactionRyukyoku value) ryukyoku,
    required TResult Function(TransactionEdit value) edit,
  }) {
    return tsumo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
  }) {
    return tsumo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
    required TResult orElse(),
  }) {
    if (tsumo != null) {
      return tsumo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionTsumoToJson(this);
  }
}

abstract class TransactionTsumo implements Transaction {
  const factory TransactionTsumo(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending,
      @JsonKey(name: 'win_player')
          required WinPlayer winPlayer}) = _$TransactionTsumo;

  factory TransactionTsumo.fromJson(Map<String, dynamic> json) =
      _$TransactionTsumo.fromJson;

  @JsonKey(name: 'player_points')
  Map<Position, Player> get playerPoints;
  @override
  Ending get ending;
  @JsonKey(name: 'win_player')
  WinPlayer get winPlayer;
  @override
  @JsonKey(ignore: true)
  $TransactionTsumoCopyWith<TransactionTsumo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionRyukyokuCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $TransactionRyukyokuCopyWith(
          TransactionRyukyoku value, $Res Function(TransactionRyukyoku) then) =
      _$TransactionRyukyokuCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
      Ending ending,
      Map<Position, bool> tenpai,
      Map<Position, bool> nagashimangan});
}

/// @nodoc
class _$TransactionRyukyokuCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $TransactionRyukyokuCopyWith<$Res> {
  _$TransactionRyukyokuCopyWithImpl(
      TransactionRyukyoku _value, $Res Function(TransactionRyukyoku) _then)
      : super(_value, (v) => _then(v as TransactionRyukyoku));

  @override
  TransactionRyukyoku get _value => super._value as TransactionRyukyoku;

  @override
  $Res call({
    Object? playerPoints = freezed,
    Object? ending = freezed,
    Object? tenpai = freezed,
    Object? nagashimangan = freezed,
  }) {
    return _then(TransactionRyukyoku(
      playerPoints: playerPoints == freezed
          ? _value.playerPoints
          : playerPoints // ignore: cast_nullable_to_non_nullable
              as Map<Position, Player>,
      ending: ending == freezed
          ? _value.ending
          : ending // ignore: cast_nullable_to_non_nullable
              as Ending,
      tenpai: tenpai == freezed
          ? _value.tenpai
          : tenpai // ignore: cast_nullable_to_non_nullable
              as Map<Position, bool>,
      nagashimangan: nagashimangan == freezed
          ? _value.nagashimangan
          : nagashimangan // ignore: cast_nullable_to_non_nullable
              as Map<Position, bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionRyukyoku
    with DiagnosticableTreeMixin
    implements TransactionRyukyoku {
  const _$TransactionRyukyoku(
      {@JsonKey(name: 'player_points') required this.playerPoints,
      this.ending = Ending.ryukyoku,
      required this.tenpai,
      required this.nagashimangan,
      String? $type})
      : $type = $type ?? 'ryukyoku';

  factory _$TransactionRyukyoku.fromJson(Map<String, dynamic> json) =>
      _$$TransactionRyukyokuFromJson(json);

  @override
  @JsonKey(name: 'player_points')
  final Map<Position, Player> playerPoints;
  @JsonKey()
  @override
  final Ending ending;
  @override
  final Map<Position, bool> tenpai;
  @override
  final Map<Position, bool> nagashimangan;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction.ryukyoku(playerPoints: $playerPoints, ending: $ending, tenpai: $tenpai, nagashimangan: $nagashimangan)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction.ryukyoku'))
      ..add(DiagnosticsProperty('playerPoints', playerPoints))
      ..add(DiagnosticsProperty('ending', ending))
      ..add(DiagnosticsProperty('tenpai', tenpai))
      ..add(DiagnosticsProperty('nagashimangan', nagashimangan));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionRyukyoku &&
            const DeepCollectionEquality()
                .equals(other.playerPoints, playerPoints) &&
            const DeepCollectionEquality().equals(other.ending, ending) &&
            const DeepCollectionEquality().equals(other.tenpai, tenpai) &&
            const DeepCollectionEquality()
                .equals(other.nagashimangan, nagashimangan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(playerPoints),
      const DeepCollectionEquality().hash(ending),
      const DeepCollectionEquality().hash(tenpai),
      const DeepCollectionEquality().hash(nagashimangan));

  @JsonKey(ignore: true)
  @override
  $TransactionRyukyokuCopyWith<TransactionRyukyoku> get copyWith =>
      _$TransactionRyukyokuCopyWithImpl<TransactionRyukyoku>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)
        ron,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)
        tsumo,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)
        ryukyoku,
    required TResult Function(
            @JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)
        edit,
  }) {
    return ryukyoku(playerPoints, ending, tenpai, nagashimangan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
  }) {
    return ryukyoku?.call(playerPoints, ending, tenpai, nagashimangan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
    required TResult orElse(),
  }) {
    if (ryukyoku != null) {
      return ryukyoku(playerPoints, ending, tenpai, nagashimangan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionRon value) ron,
    required TResult Function(TransactionTsumo value) tsumo,
    required TResult Function(TransactionRyukyoku value) ryukyoku,
    required TResult Function(TransactionEdit value) edit,
  }) {
    return ryukyoku(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
  }) {
    return ryukyoku?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
    required TResult orElse(),
  }) {
    if (ryukyoku != null) {
      return ryukyoku(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionRyukyokuToJson(this);
  }
}

abstract class TransactionRyukyoku implements Transaction {
  const factory TransactionRyukyoku(
      {@JsonKey(name: 'player_points')
          required Map<Position, Player> playerPoints,
      Ending ending,
      required Map<Position, bool> tenpai,
      required Map<Position, bool> nagashimangan}) = _$TransactionRyukyoku;

  factory TransactionRyukyoku.fromJson(Map<String, dynamic> json) =
      _$TransactionRyukyoku.fromJson;

  @JsonKey(name: 'player_points')
  Map<Position, Player> get playerPoints;
  @override
  Ending get ending;
  Map<Position, bool> get tenpai;
  Map<Position, bool> get nagashimangan;
  @override
  @JsonKey(ignore: true)
  $TransactionRyukyokuCopyWith<TransactionRyukyoku> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEditCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $TransactionEditCopyWith(
          TransactionEdit value, $Res Function(TransactionEdit) then) =
      _$TransactionEditCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'point_setting') PointSetting pointSetting,
      Ending ending});
}

/// @nodoc
class _$TransactionEditCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $TransactionEditCopyWith<$Res> {
  _$TransactionEditCopyWithImpl(
      TransactionEdit _value, $Res Function(TransactionEdit) _then)
      : super(_value, (v) => _then(v as TransactionEdit));

  @override
  TransactionEdit get _value => super._value as TransactionEdit;

  @override
  $Res call({
    Object? pointSetting = freezed,
    Object? ending = freezed,
  }) {
    return _then(TransactionEdit(
      pointSetting: pointSetting == freezed
          ? _value.pointSetting
          : pointSetting // ignore: cast_nullable_to_non_nullable
              as PointSetting,
      ending: ending == freezed
          ? _value.ending
          : ending // ignore: cast_nullable_to_non_nullable
              as Ending,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionEdit
    with DiagnosticableTreeMixin
    implements TransactionEdit {
  const _$TransactionEdit(
      {@JsonKey(name: 'point_setting') required this.pointSetting,
      this.ending = Ending.edit,
      String? $type})
      : $type = $type ?? 'edit';

  factory _$TransactionEdit.fromJson(Map<String, dynamic> json) =>
      _$$TransactionEditFromJson(json);

  @override
  @JsonKey(name: 'point_setting')
  final PointSetting pointSetting;
  @JsonKey()
  @override
  final Ending ending;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction.edit(pointSetting: $pointSetting, ending: $ending)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction.edit'))
      ..add(DiagnosticsProperty('pointSetting', pointSetting))
      ..add(DiagnosticsProperty('ending', ending));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionEdit &&
            const DeepCollectionEquality()
                .equals(other.pointSetting, pointSetting) &&
            const DeepCollectionEquality().equals(other.ending, ending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pointSetting),
      const DeepCollectionEquality().hash(ending));

  @JsonKey(ignore: true)
  @override
  $TransactionEditCopyWith<TransactionEdit> get copyWith =>
      _$TransactionEditCopyWithImpl<TransactionEdit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)
        ron,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)
        tsumo,
    required TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)
        ryukyoku,
    required TResult Function(
            @JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)
        edit,
  }) {
    return edit(pointSetting, ending);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
  }) {
    return edit?.call(pointSetting, ending);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'lose_player') Position losePlayer,
            @JsonKey(name: 'win_players') List<WinPlayer> winPlayers)?
        ron,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            @JsonKey(name: 'win_player') WinPlayer winPlayer)?
        tsumo,
    TResult Function(
            @JsonKey(name: 'player_points') Map<Position, Player> playerPoints,
            Ending ending,
            Map<Position, bool> tenpai,
            Map<Position, bool> nagashimangan)?
        ryukyoku,
    TResult Function(@JsonKey(name: 'point_setting') PointSetting pointSetting,
            Ending ending)?
        edit,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(pointSetting, ending);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionRon value) ron,
    required TResult Function(TransactionTsumo value) tsumo,
    required TResult Function(TransactionRyukyoku value) ryukyoku,
    required TResult Function(TransactionEdit value) edit,
  }) {
    return edit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
  }) {
    return edit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionRon value)? ron,
    TResult Function(TransactionTsumo value)? tsumo,
    TResult Function(TransactionRyukyoku value)? ryukyoku,
    TResult Function(TransactionEdit value)? edit,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionEditToJson(this);
  }
}

abstract class TransactionEdit implements Transaction {
  const factory TransactionEdit(
      {@JsonKey(name: 'point_setting') required PointSetting pointSetting,
      Ending ending}) = _$TransactionEdit;

  factory TransactionEdit.fromJson(Map<String, dynamic> json) =
      _$TransactionEdit.fromJson;

  @JsonKey(name: 'point_setting')
  PointSetting get pointSetting;
  @override
  Ending get ending;
  @override
  @JsonKey(ignore: true)
  $TransactionEditCopyWith<TransactionEdit> get copyWith =>
      throw _privateConstructorUsedError;
}
