import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'locale.dart';

class LanguageDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String) changeLanguageTo;

  LanguageDialog({this.changeLanguageTo, this.initialValue});

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Widget LanguageRadioListTile(String lang) {
      return RadioListTile<String>(
        value: lang,
        title: Text(languageText[lang]),
        onChanged: (val) {
          setState(() {
            _selectedLanguage = val;
          });
        },
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        groupValue: _selectedLanguage,
      );
    }

    return AlertDialog(
      title: Text(AppLocalizations.of(context).chooseALanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: languageText.keys
            .map((lang) => LanguageRadioListTile(lang))
            .toList(),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        FlatButton(
          onPressed: () {
            widget.changeLanguageTo(_selectedLanguage);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
      scrollable: true,
    );
  }
}
