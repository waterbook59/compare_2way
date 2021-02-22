import 'package:compare_2way/views/compare/components/evaluate_dropdown.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePart extends StatelessWidget {
  TablePart(
      {this.way1Title,
      this.way1MeritEvaluate,
      this.way1DemeritEvaluate,
      this.way2Title,
      this.way2MeritEvaluate,
      this.way2DemeritEvaluate});

  final String way1Title;
  final int way1MeritEvaluate;
  final int way1DemeritEvaluate;
  final String way2Title;
  final int way2MeritEvaluate;
  final int way2DemeritEvaluate;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Container(
              //figmaでは24
              height: 30,
            ),
            Center(
              child: IconTitle(
                title: 'メリット',
                iconData: Icons.thumb_up,
                iconColor: accentColor,
              ),
            ),
            IconTitle(
              title: 'デメリット',
              iconData: Icons.thumb_down,
              iconColor: accentColor,
            ),
          ]),

          ///way1行
          TableRow(children: [
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                way1Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),

          ///way1MeritEvaluate
            ///高さを設定しないと'!_debugDoingThisLayout': is not true.エラー
            SizedBox(
                height: 50,
                //todo popupMenuで選んだ値は外で別のWidgetで受けるのかも(RowにしてText()とか)
                ///Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(flex: 2, child: Center(child: Text('◎'))),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                       initialValue: way1MeritEvaluate,
                        onSelected: (newValue) {
                         //todo compareScreenへnewValueを戻す
                          print(newValue);
                        },
                      )),
                ])),
            SizedBox(height: 50, child: EvaluateDropdown()),
          ]),

          ///way2行
          TableRow(children: [
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                way2Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),
            SizedBox(height: 50, child: EvaluateDropdown()),
            SizedBox(height: 50, child: EvaluateDropdown()),
          ]),
        ],
      ),
    );
  }
}
