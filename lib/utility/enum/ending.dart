import 'package:freezed_annotation/freezed_annotation.dart';

enum Ending {
  @JsonValue('START')
  start,
  @JsonValue('EDIT')
  edit,
  @JsonValue('RON')
  ron,
  @JsonValue('TSUMO')
  tsumo,
  @JsonValue('RYUKYOKU')
  ryukyoku,
}
