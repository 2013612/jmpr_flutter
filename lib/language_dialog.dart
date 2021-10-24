import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utility/locale.dart';

class LanguageDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String) changeLanguageTo;

  LanguageDialog({required this.changeLanguageTo, required this.initialValue});

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    Widget languageRadioListTile(String lang) {
      return RadioListTile<String>(
        value: lang,
        title: Text(languageText[lang]!),
        onChanged: (val) {
          setState(() {
            _selectedLanguage = val ?? "ja";
          });
        },
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        groupValue: _selectedLanguage,
      );
    }

    return AlertDialog(
      title: Text(i18n.chooseALanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: languageText.keys.map(languageRadioListTile).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(i18n.cancel),
        ),
        TextButton(
          onPressed: () {
            widget.changeLanguageTo(_selectedLanguage);
            Navigator.pop(context);
          },
          child: Text(i18n.save),
        ),
      ],
      scrollable: true,
    );
  }
}
