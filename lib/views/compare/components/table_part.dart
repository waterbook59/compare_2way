import 'package:compare_2way/views/compare/components/evaluate_dropdown.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///Statefulへ変更:余裕あればSelector導入
class TablePart extends StatefulWidget {
   const TablePart({
     this.way1Title,
     this.way1MeritEvaluate,
     this.way1DemeritEvaluate,
     this.way1MeritChanged,
     this.way1DemeritChanged,
     this.way2Title,
     this.way2MeritEvaluate,
     this.way2DemeritEvaluate,
     this.way2MeritChanged,
     this.way2DemeritChanged,

  });

    final String way1Title;
    final int way1MeritEvaluate;
    final int way1DemeritEvaluate;
    final String way2Title;
    final int way2MeritEvaluate;
    final int way2DemeritEvaluate;


  /// CompareScreenへ値を渡して保存
   final Function(int) way1MeritChanged;
   final Function(int) way1DemeritChanged;
   final Function(int) way2MeritChanged;
   final Function(int) way2DemeritChanged;

  @override
  _TablePartState createState() => _TablePartState();
}

class _TablePartState extends State<TablePart> {
  ///evaluatePickerのリスト
  final List<String> evaluates = <String>[
    '',
    '◎',
    '○',
    '△',
    '×',
  ];

  String way1MeritDisplay = '';
  String way1DemeritDisplay = '';
  String way2MeritDisplay = '';
  String way2DemeritDisplay = '';

  @override
  void initState() {
//    print('listPageから渡ってきたway1MeritEvaluateの値:${widget.way1MeritEvaluate}');
    way1MeritDisplay = evaluates[widget.way1MeritEvaluate];
    way1DemeritDisplay = evaluates[widget.way1DemeritEvaluate];
    way2MeritDisplay = evaluates[widget.way2MeritEvaluate];
    way2DemeritDisplay =
        evaluates[widget.way2DemeritEvaluate];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(),
        children: [
          ///タイトル行
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
            ///way1タイトル
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                widget.way1Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),

            ///way1MeritEvaluate
            //高さを設定しないと'!_debugDoingThisLayout': is not true.エラー
            SizedBox(
                height: 50,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        way1MeritDisplay,
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.right,
                      )),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                        initialValue:
                            widget.way1MeritEvaluate,
                        onSelected: (newValue) {
                          print('newValueをsetState:$newValue');
                          setState(() {
                            way1MeritDisplay = evaluates[newValue];
                            widget.way1MeritChanged(newValue);
                          });
                        },
                      )),
                ])),

            ///way1DemeritEvaluate
            SizedBox(
                height: 50,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        way1DemeritDisplay,
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.right,
                      )),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                        initialValue: widget.way1DemeritEvaluate,
                        onSelected: (newValue) {
                          print(newValue);
                          setState(() {
                            way1DemeritDisplay = evaluates[newValue];
                            widget.way1DemeritChanged(newValue);
                          });
                        },
                      )),
                ])),
          ]),

          ///way2行
          TableRow(children: [
            ///way1タイトル
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                widget.way2Title,
                style: const TextStyle(fontSize: 16),
              )),
            ),

            ///way2MeritEvaluate
            SizedBox(
                height: 50,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        way2MeritDisplay,
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.right,
                      )),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                        initialValue: widget.way2MeritEvaluate,
                        onSelected: (newValue) {
                          print(newValue);
                          setState(() {
                            way2MeritDisplay = evaluates[newValue];
                            widget.way2MeritChanged(newValue);
                          });
                        },
                      )),
                ])),

            ///way2DemeritEvaluate
            SizedBox(
                height: 50,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        way2DemeritDisplay,
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.right,
                      )),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                        initialValue: widget.way2DemeritEvaluate,
                        onSelected: (newValue) {
                          print(newValue);
                          setState(() {
                            way2DemeritDisplay = evaluates[newValue];
                            widget.way2DemeritChanged(newValue);
                          });
                        },
                      )),
                ])),
          ]),
        ],
      ),
    );
  }
}
