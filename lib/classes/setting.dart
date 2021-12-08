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
