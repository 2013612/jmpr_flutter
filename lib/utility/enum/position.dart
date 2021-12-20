import 'package:freezed_annotation/freezed_annotation.dart';

enum Position {
  @JsonValue('BOTTOM')
  bottom,
  @JsonValue('RIGHT')
  right,
  @JsonValue('TOP')
  top,
  @JsonValue('LEFT')
  left,
}
