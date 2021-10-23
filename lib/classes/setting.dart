import '../common.dart';

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
    required this.givenStartingPoint,
    required this.startingPoint,
    required this.riichibouPoint,
    required this.bonbaPoint,
    required this.ryukyokuPoint,
    required this.umaBig,
    required this.umaSmall,
    required this.isKiriage,
    required this.isDouten,
    required this.firstOya,
  });

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
}
