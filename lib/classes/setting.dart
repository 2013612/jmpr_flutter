import '../utility/enum/position.dart';

class Setting {
  int givenStartingPoint;
  int startingPoint;
  int riichibouPoint;
  int bonbaPoint;
  int ryukyokuPoint;
  int umaSmall;
  int umaBig;
  bool isKiriage;
  bool isDouten;
  Position firstOya;

  Setting({
    this.givenStartingPoint = 25000,
    this.startingPoint = 30000,
    this.riichibouPoint = 1000,
    this.bonbaPoint = 300,
    this.ryukyokuPoint = 3000,
    this.umaBig = 20,
    this.umaSmall = 10,
    this.isKiriage = false,
    this.isDouten = false,
    this.firstOya = Position.bottom,
  });

  factory Setting.RMU() {
    return Setting(
      startingPoint: 30000,
      givenStartingPoint: 30000,
      riichibouPoint: 1000,
      bonbaPoint: 300,
      ryukyokuPoint: 3000,
      umaBig: 30,
      umaSmall: 10,
      isKiriage: true,
      isDouten: true,
      firstOya: Position.bottom,
    );
  }

  factory Setting.tenhou() {
    return Setting(
      startingPoint: 30000,
      givenStartingPoint: 25000,
      riichibouPoint: 1000,
      bonbaPoint: 300,
      ryukyokuPoint: 3000,
      umaBig: 20,
      umaSmall: 10,
      isKiriage: false,
      isDouten: false,
      firstOya: Position.bottom,
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      startingPoint: json["starting_point"] as int,
      givenStartingPoint: json["given_starting_point"] as int,
      riichibouPoint: json["riichibou_point"] as int,
      bonbaPoint: json["bonba_point"] as int,
      ryukyokuPoint: json["ryukyoku_point"] as int,
      umaBig: json["uma_big"] as int,
      umaSmall: json["uma_small"] as int,
      isKiriage: json["is_kiriage"] as bool,
      isDouten: json["is_douten"] as bool,
      firstOya: Position.values[json["first_oya"] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "given_starting_point": givenStartingPoint,
      "starting_point": startingPoint,
      "riichibou_point": riichibouPoint,
      "bonba_point": bonbaPoint,
      "ryukyoku_point": ryukyokuPoint,
      "uma_big": umaBig,
      "uma_small": umaSmall,
      "is_kiriage": isKiriage,
      "is_douten": isDouten,
      "first_oya": firstOya,
    };
  }

  Setting clone() {
    return Setting(
      givenStartingPoint: givenStartingPoint,
      startingPoint: startingPoint,
      riichibouPoint: riichibouPoint,
      bonbaPoint: bonbaPoint,
      ryukyokuPoint: ryukyokuPoint,
      umaBig: umaBig,
      umaSmall: umaSmall,
      isKiriage: isKiriage,
      isDouten: isDouten,
      firstOya: firstOya,
    );
  }

  bool equal(Setting other) {
    return givenStartingPoint == other.givenStartingPoint &&
        startingPoint == other.startingPoint &&
        riichibouPoint == other.riichibouPoint &&
        bonbaPoint == other.bonbaPoint &&
        ryukyokuPoint == other.ryukyokuPoint &&
        umaBig == other.umaBig &&
        umaSmall == other.umaSmall &&
        isKiriage == other.isKiriage &&
        isDouten == other.isDouten &&
        firstOya == other.firstOya;
  }

  @override
  String toString() {
    return '''
    {
      givenStartingPoint: $givenStartingPoint,
      startingPoint: $startingPoint,
      riichibouPoint: $riichibouPoint,
      bonbaPoint: $bonbaPoint,
      ryukyokuPoint: $ryukyokuPoint,
      umaBig: $umaBig,
      umaSmall: $umaSmall,
      isKiriage: $isKiriage,
      isDouten: $isDouten,
      firstOya: $firstOya,
    }''';
  }
}
