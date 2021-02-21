import 'package:compare_2way/views/compare/components/evaluate_dropdown.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'evaluate_picker.dart';

class TablePart extends StatelessWidget {
  TablePart({this.way1Title, this.way2Title});

  final String way1Title;
  final String way2Title;

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
          TableRow(children: [
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                way1Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),
             ///高さを設定しないと'!_debugDoingThisLayout': is not true.エラー
             SizedBox(
                 height:50,
                 child: EvaluateDropdown()),
             SizedBox(
              height:50,
              child: EvaluateDropdown()),
          ]),
          TableRow(children: [
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                way2Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),
            SizedBox(
                height:50,
                child: EvaluateDropdown()),
            SizedBox(
                height:50,
                child: EvaluateDropdown()),
          ]),
        ],
      ),
    );
  }
}
