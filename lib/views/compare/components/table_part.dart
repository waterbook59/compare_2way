import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:compare_2way/views/compare/components/sub/DemeritEvaluateDropdown.dart';
import 'package:compare_2way/views/compare/components/sub/MeritEvaluateDropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///Statefulへ変更:余裕あればSelector導入
class TablePart extends StatefulWidget {
   const TablePart({Key? key,
     required this.comparisonItemId,
     required this.way1Title,
     required this.way1MeritEvaluate,
     required this.way1DemeritEvaluate,
     required this.way2Title,
     required this.way2MeritEvaluate,
     required this.way2DemeritEvaluate,
  }) : super(key: key);

    final String comparisonItemId;
    final String way1Title;
    final int way1MeritEvaluate;
    final int way1DemeritEvaluate;
    final String way2Title;
    final int way2MeritEvaluate;
    final int way2DemeritEvaluate;


  @override
  State<TablePart> createState() => _TablePartState();
}

class _TablePartState extends State<TablePart> {
  ///evaluatePickerのリスト
  final List<Image> evaluates = <Image>[
    Image.asset('assets/images/blank.png'),
    Image.asset('assets/images/double_circle.png'),
    Image.asset('assets/images/round.png'),
    Image.asset('assets/images/triangle.png'),
    Image.asset('assets/images/cross.png'),
    Image.asset('assets/images/double_cross.png'),
  ];

  final List<Image> evaluatePositives = <Image>[
    Image.asset('assets/images/blank.png'),
    Image.asset('assets/images/double_circle.png'),
    Image.asset('assets/images/round.png'),
    Image.asset('assets/images/triangle.png'),
  ];

  final List<Image> evaluateNegatives = <Image>[
    Image.asset('assets/images/blank.png'),
    Image.asset('assets/images/triangle.png'),
    Image.asset('assets/images/cross.png'),
    Image.asset('assets/images/double_cross.png'),
  ];



  Image way1MeritDisplay = Image.asset('assets/images/blank.png');
  Image way1DemeritDisplay = Image.asset('assets/images/blank.png');
  Image way2MeritDisplay = Image.asset('assets/images/blank.png');
  Image way2DemeritDisplay = Image.asset('assets/images/blank.png');


  @override
  void initState() {
  //listpageからgetListで得られた値が渡ってきてセット
    way1MeritDisplay = evaluatePositives[widget.way1MeritEvaluate];
    way1DemeritDisplay = evaluateNegatives[widget.way1DemeritEvaluate];
    way2MeritDisplay = evaluatePositives[widget.way2MeritEvaluate];
    way2DemeritDisplay =
    evaluateNegatives[widget.way2DemeritEvaluate];
    super.initState();
  }
  @override
  void dispose() {
    /// //todo way1MeritDisplay,way1DemeritDisplay,way2MeritDisplay,
    // way2DemeritDisplayインスタンス破棄?
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//        columnWidths: const <int, TableColumnWidth>{
//          0: FixedColumnWidth(1),
//          1: FixedColumnWidth(1),
//          2: FixedColumnWidth(1),
//        },
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
          ],),

          ///way1行
          TableRow(children: [
            ///way1タイトル
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                widget.way1Title,
                style: const TextStyle(fontSize: 16),
              ),),
            ),
            ///way1MeritEvaluate
            //高さを設定しないと'!_debugDoingThisLayout': is not true.エラー
            SizedBox(
                height: 48,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child:
                Row(
                    children: [
                      const SizedBox(width: 16,),
                  Expanded(
                      flex: 2,
                      child: way1MeritDisplay,),

                  Expanded(
                      child:
                      MeritEvaluateDropdown(
                        initialValue:widget.way1MeritEvaluate,
                        onSelected: (newValue) {
                          setState(() {
                            way1MeritDisplay = evaluatePositives[newValue];
                            // CompareScreenへ渡さずに直接viewModel側に保存
                            viewModel.setWay1MeritNewValue(
                                widget.comparisonItemId,newValue,);
                          });
                        },
                      ),
                  ),
                      const SizedBox(width: 8,),
                ],)
            ,),
            ///way1DemeritEvaluate
            SizedBox(
                height: 48,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  const SizedBox(width: 16,),
                  Expanded(
                      flex: 2,
                      child:  way1DemeritDisplay,
                  ),
                  // EvaluateDropdownで選択したときもフォーカス外す(キーボード下げる)
                  Expanded(
                      child: DemeritEvaluateDropdown(
                        initialValue: widget.way1DemeritEvaluate,
                        onSelected: (newValue) {
                          setState(() {
                            way1DemeritDisplay = evaluateNegatives[newValue];
                            viewModel.setWay1DemeritNewValue(
                                widget.comparisonItemId,newValue,);
                          });
                        },
                      ),),
                  const SizedBox(width: 8,),
                ],),),
          ],),

          ///way2行
          TableRow(children: [
            ///way1タイトル
            SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                widget.way2Title,
                style: const TextStyle(fontSize: 16),
              ),),
            ),

            ///way2MeritEvaluate
            SizedBox(
                height: 48,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  const SizedBox(width: 16,),
                  Expanded(
                      flex: 2,
                      child: way2MeritDisplay,
                  ),
                  Expanded(
                      child: MeritEvaluateDropdown(
                        initialValue: widget.way2MeritEvaluate,
                        onSelected: (newValue) {
                          setState(() {
                            way2MeritDisplay = evaluatePositives[newValue];
                            viewModel.setWay2MeritNewValue(
                                widget.comparisonItemId,newValue,);
                          });
                        },
                      ),),
                  const SizedBox(width: 8,),
                ],),),

            ///way2DemeritEvaluate
            SizedBox(
                height: 48,
                //Tableの中でRowを幅に合わせるなら要素にExpandedかFlexible必要
                child: Row(children: [
                  const SizedBox(width: 16,),
                  Expanded(
                      flex: 2,
                      child:   way2DemeritDisplay,
                  ),
                  Expanded(
                      child: DemeritEvaluateDropdown(
                        initialValue: widget.way2DemeritEvaluate,
                        onSelected: (newValue) {
                          setState(() {
                            way2DemeritDisplay = evaluateNegatives[newValue];
                            viewModel.setWay2DemeritNewValue(
                                widget.comparisonItemId,newValue,);
                          });
                        },
                      ),),
                  const SizedBox(width: 8,),
                ],),),
          ],),
        ],
      ),
    );
  }
}
