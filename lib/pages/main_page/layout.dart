import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utility/constant.dart';
import 'local_widgets/main_landscape.dart';
import 'local_widgets/main_portrait.dart';
import 'local_widgets/my_app_bar.dart';
import 'local_widgets/my_bottom_app_bar.dart';

class Layout extends ConsumerStatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  @override
  Widget build(BuildContext context) {
    Constant.languageChange(context);

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: MyAppBar(),
        body: MainPortrait(),
        bottomNavigationBar: MyBottomAppBar(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: MyAppBar(),
        body: MainLandscape(),
        bottomNavigationBar: MyBottomAppBar(),
      );
    }
  }
}
