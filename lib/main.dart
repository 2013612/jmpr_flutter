import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/utility/providers.dart';

import 'pages/main_page/layout.dart';
import 'utility/validators.dart';

void main() {
  runApp(ProviderScope(child: JMPRAPP()));
}

class JMPRAPP extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Validators.context = context;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomAppBarColor: Colors.blue,
      ),
      home: Layout(),
      locale: ref.watch(localeProvider).state,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
