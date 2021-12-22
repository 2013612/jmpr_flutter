import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/setting.dart';

import 'enum/position.dart';

// ignore: avoid_classes_with_only_static_members
class Constant {
  static late Map<Position, String> positionTexts;

  static late List<String> sittingTexts;

  static final List<String> kyokus = [
    "東一局",
    "東二局",
    "東三局",
    "東四局",
    "南一局",
    "南二局",
    "南三局",
    "南四局",
    "西一局",
    "西二局",
    "西三局",
    "西四局",
    "北一局",
    "北二局",
    "北三局",
    "北四局"
  ];

  static final List<int> hans = [
    ...List.generate(13, (index) => index + 1),
    26,
    39
  ];

  static final List<int> fus = [
    20,
    25,
    ...List.generate(9, (index) => (index + 3) * 10)
  ];

  static final Map<int, int> points = {
    2: 2000,
    3: 2000,
    4: 2000,
    5: 2000,
    6: 3000,
    7: 3000,
    8: 4000,
    9: 4000,
    10: 4000,
    11: 6000,
    12: 6000,
    13: 8000,
    26: 16000,
    39: 24000
  };

  static final Map<Position, IconData> arrows = {
    Position.bottom: Icons.arrow_downward,
    Position.right: Icons.arrow_forward,
    Position.top: Icons.arrow_upward,
    Position.left: Icons.arrow_back
  };

  static final Setting bRuleSetting = Setting(
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

  static final Setting tenhouSetting = Setting(
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

  static void changeLanguage(BuildContext context) {
    positionTexts = {
      Position.bottom: AppLocalizations.of(context)!.bottom,
      Position.right: AppLocalizations.of(context)!.right,
      Position.top: AppLocalizations.of(context)!.top,
      Position.left: AppLocalizations.of(context)!.left,
    };
    sittingTexts = [
      AppLocalizations.of(context)!.east,
      AppLocalizations.of(context)!.south,
      AppLocalizations.of(context)!.west,
      AppLocalizations.of(context)!.north
    ];
  }
}
