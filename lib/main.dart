import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jmpr_flutter/locale.dart';
import 'layout.dart';

void main() {
  runApp(JMPRAPP());
}

class JMPRAPP extends StatefulWidget {
  @override
  _JMPRAPPState createState() => _JMPRAPPState();
}

class _JMPRAPPState extends State<JMPRAPP> {
  Locale locale;

  @override
  void initState() {
    super.initState();
    locale = supportedLocales.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Layout(locale, SetAppLocaleDelegate((Locale locale) {
        setState(() {
          this.locale = locale;
        });
      })),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales.values,
    );
  }
}
