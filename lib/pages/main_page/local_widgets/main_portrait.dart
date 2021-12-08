import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../providers/histories.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';
import 'point_riichi_display.dart';

class MainPortrait extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final histories = ref.watch(historiesProvider);
    final index = ref.watch(historyIndexProvider);
    final pointSetting = histories[index].pointSetting;
    final middleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    void showResult() {
      Map<Position, double> marks = histories[index].calResult();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(i18n.result),
          content: Column(
            children: marks.entries
                .map((mark) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Constant.positionTexts[mark.key]!,
                          ),
                        ),
                        Text(
                          mark.value.toStringAsFixed(2),
                        ),
                      ],
                    ))
                .toList(),
          ),
          scrollable: true,
        ),
      );
    }

    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: [
          nil,
          Center(
            child: RotatedBox(
              quarterTurns: 2,
              child: PointRiichiDisplay(Position.top),
            ),
          ),
          nil,
          Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: PointRiichiDisplay(Position.left),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  Constant.kyokus[pointSetting.currentKyoku],
                  style: middleTextStyle,
                ),
                Text(
                  "${pointSetting.bonba} 本場",
                  style: middleTextStyle,
                ),
                Text(
                  "供托: ${pointSetting.riichibou}",
                  style: middleTextStyle,
                ),
              ],
            ),
          ),
          Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: PointRiichiDisplay(Position.right),
            ),
          ),
          nil,
          // ElevatedButton(
          //     onPressed: () => Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => Test())),
          //     child: Text("firebase")),
          Center(
            child: PointRiichiDisplay(Position.bottom),
          ),
          FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 0.6,
            child: ElevatedButton(
              onPressed: showResult,
              child: Text(i18n.result),
            ),
          ),
        ],
      ),
    );
  }
}
//
// StreamBuilder<QuerySnapshot> testFirebase() {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('test').snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (!snapshot.hasData) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       final int commentCount = snapshot.data!.docs.length;
//       if (commentCount > 0) {
//         return ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: commentCount,
//           itemBuilder: (_, int index) {
//             final DocumentSnapshot document = snapshot.data!.docs[index];
//             snapshot.data!.docs[0].data();
//             print(document.data());
//             return Text(document["name"]?.toString() ?? "");
//           },
//         );
//       } else {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 10.0),
//           alignment: Alignment.center,
//           child: Text(
//             'no comments...',
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }
//     },
//   );
// }
//
// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: testFirebase(),
//     );
//   }
// }
