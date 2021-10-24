import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  static late final BuildContext context;

  static String? empty(String? input) {
    return input != null && input != "" ? null : "";
  }

  static String? integer(String? input) {
    if (int.tryParse(input!) == null || int.tryParse(input)! % 100 != 0) {
      return AppLocalizations.of(context)!.errorDivideByHundred;
    }
    return null;
  }

  static String? nonNegativeInteger(String? input) {
    if (int.tryParse(input!) == null || int.tryParse(input)! < 0) {
      return AppLocalizations.of(context)!.errorNonnegative;
    }
    return null;
  }
}