import 'package:flutter/material.dart';

class SetAppLocaleDelegate {
  final void Function(Locale) setLocale;

  SetAppLocaleDelegate(this.setLocale);
}

final Map<String, Locale> supportedLocales = {
  "ja": Locale("ja", ""),
  "zh": Locale.fromSubtags(
    languageCode: "zh",
    scriptCode: "Hant",
    countryCode: "HK",
  ),
  "en": Locale("en", ""),
};

final Map<String, String> languageText = {
  "ja": "日本語",
  "zh": "繁體中文",
  "en": "English",
};
