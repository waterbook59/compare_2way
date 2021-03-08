import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/evaluate_dropdown.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Statefulへ変更:余裕あればSelector導入
class TablePart extends StatefulWidget {
  TablePart({
    this.comparisonOverview,
  });

  final ComparisonOverview comparisonOverview;
  //todo CompareScreenへ値を渡して保存


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

  int way1MeritEvaluate = 0;
  String way1MeritDisplay = '';
  int way1DemeritEvaluate = 0;
  String way1DemeritDisplay = '';
  int way2MeritEvaluate = 0;
  String way2MeritDisplay = '';
  int way2DemeritEvaluate = 0;
  String way2DemeritDisplay = '';


  @override
  void initState() {
    print('listPageから渡ってきたway1MeritEvaluateの値:${widget.comparisonOverview.way1MeritEvaluate}');
    way1MeritDisplay = evaluates[widget.comparisonOverview.way1MeritEvaluate];
    way1DemeritDisplay =
    evaluates[widget.comparisonOverview.way1DemeritEvaluate];
    way2MeritDisplay = evaluates[widget.comparisonOverview.way1MeritEvaluate];
    way2DemeritDisplay =
    evaluates[widget.comparisonOverview.way1DemeritEvaluate];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme
        .of(context)
        .accentColor;

//    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

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
                    widget.comparisonOverview.way1Title,
                    style: const TextStyle(fontSize: 16),
                  )),
            ),

            ///way1MeritEvaluate
            //高さを設定しないと'!_debugDoingThisLayout': is not true.エラー
//            Consumer<CompareViewModel>(
//                builder: (context, compareViewModel, child) {
//              return
            SizedBox(
                height: 50,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(way1MeritDisplay,
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.right,
                      )),
                  Expanded(
                      flex: 1,
                      child: EvaluateDropdown(
                        initialValue: widget.comparisonOverview
                            .way1MeritEvaluate,
                        onSelected: (newValue) {
                          print('newValueをsetState:$newValue');
//
                          setState(() {
                            way1MeritEvaluate = newValue;
                            way1MeritDisplay = evaluates[newValue];
                          });
                          // compareScreenへnewValueを戻す
//                        await compareViewModel.setWay1MeritNewValue(newValue);
                        },
                      )),
                ])),
//            }),
            ///way1DemeritEvaluate
//            Consumer<CompareViewModel>(
//                builder: (context, compareViewModel, child) {
//                  return
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
                        initialValue: way1DemeritEvaluate,
                        onSelected: (newValue) {
                          print(newValue);
                          setState(() {
                            way1DemeritDisplay = evaluates[newValue];
                          });
                        },
                      )),
                ])),
//                }),
          ]),

          ///way2行
          TableRow(children: [

            ///way1タイトル
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                    widget.comparisonOverview.way2Title,
                    style: const TextStyle(fontSize: 16),
                  )),
            ),

            ///way2MeritEvaluate
//            Consumer<CompareViewModel>(
//                builder: (context, compareViewModel, child) {
//                  return
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
                              initialValue: way2MeritEvaluate,
                              onSelected: (newValue) {
                                print(newValue);
                              setState(() {
                                way2MeritDisplay = evaluates[newValue];
                              });
                              },
                            )),
                      ])),
//                }),

            ///way2DemeritEvaluate
//            Consumer<CompareViewModel>(
//                builder: (context, compareViewModel, child) {
//                  return
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
                              initialValue: way2DemeritEvaluate,
                              onSelected: (newValue)  {
                                print(newValue);
                                setState(() {
                                  way2DemeritDisplay = evaluates[newValue];
                                });
                              },
                            )),
                      ])),
//                }),
          ]),
        ],
      ),
    );
  }
}
