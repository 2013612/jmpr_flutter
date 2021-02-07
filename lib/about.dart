import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).about),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).appTitle),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).version(1.1)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).develop + ": 2013612"),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text("github: https://github.com/2013612/jmpr_flutter"),
          ),
        ],
      ),
    );
  }
}
