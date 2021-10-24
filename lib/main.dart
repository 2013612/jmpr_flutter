import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jmpr_flutter/utility/validators.dart';

import 'layout.dart';
import 'utility/locale.dart';

void main() {
  runApp(JMPRAPP());
}

class JMPRAPP extends StatefulWidget {
  @override
  _JMPRAPPState createState() => _JMPRAPPState();
}

class _JMPRAPPState extends State<JMPRAPP> {
  late Locale locale;

  @override
  void initState() {
    super.initState();
    locale = supportedLocales.values.first;
  }

  @override
  Widget build(BuildContext context) {
    Validators.context = context;
    return MaterialApp(
      locale: locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomAppBarColor: Colors.blue,
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
