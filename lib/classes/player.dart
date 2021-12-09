import '../utility/enum/position.dart';

class Player {
  Position position;
  int point;
  bool riichi;

  Player({required this.position, required this.point, required this.riichi});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      position: Position.values[json["position"] as int],
      point: json["point"] as int,
      riichi: json["riichi"] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "position": Position.values.indexOf(position),
      "point": point,
      "riichi": riichi,
    };
  }

  Player clone() {
    return Player(
      position: position,
      point: point,
      riichi: riichi,
    );
  }

  @override
  String toString() {
    return '''
    {
      position: $position,
      point: $point,
      riichi: $riichi,
    }
    ''';
  }
}
