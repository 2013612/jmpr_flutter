import '../utility/constant.dart';

class Player {
  Position position;
  int point;
  bool riichi;

  Player({required this.position, required this.point, required this.riichi});

  Player clone() {
    return Player(
      position: position,
      point: point,
      riichi: riichi,
    );
  }
}
