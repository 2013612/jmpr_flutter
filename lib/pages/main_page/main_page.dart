import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmpr_flutter/utility/constant.dart';
import 'package:jmpr_flutter/utility/validators.dart';

import 'local_widgets/main_landscape.dart';
import 'local_widgets/main_portrait.dart';
import 'local_widgets/my_app_bar.dart';
import 'local_widgets/my_bottom_app_bar.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Validators.context = context;
    Constant.changeLanguage(context);
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
