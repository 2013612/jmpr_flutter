import 'package:flutter/material.dart';
import 'layout.dart';

void main() {
  runApp(JMPRAPP());
}

class JMPRAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Layout(title: '日本麻將點數記錄器'),
    );
  }
}
