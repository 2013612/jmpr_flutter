import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/main_page/main_page.dart';
import 'utility/constant.dart';
import 'utility/providers.dart';
import 'utility/validators.dart';

void main() {
  runApp(ProviderScope(child: JMPRAPP()));
}

class JMPRAPP extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Validators.context = context;
    Constant.context = context;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomAppBarColor: Colors.blue,
      ),
      home: MainPage(),
      locale: ref.watch(localeProvider).state,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
