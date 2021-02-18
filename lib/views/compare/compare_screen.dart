import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';

class CompareScreen extends StatelessWidget {
  CompareScreen({this.comparisonItemId});

  final String comparisonItemId;

  //todo itemsはList<Merit>に変更
  static List<String> items = [
    'Content 1',
    'Content 2',
    'Content 3',
  ];

  //最初は１つだけ、データが既に入っている場合は取得時に入っている数を出したい
  //データが既に入っている場合は、初期表示として表す
  //List.generate(初期の表示数,(i)=>TextEditingController());
  final List<TextEditingController> _controllers =
      List.generate(items.length, (i) => TextEditingController(text: items[i]));

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

//    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//    Future(() {
//      viewModel.getOverview(comparisonItemId);
//    });

    return CupertinoPageScaffold(
      //todo trailing修正時はconst削除
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height: 8),
            const Text('メリット'),
            const SizedBox(
              height: 8,
            ),
            Consumer<CompareViewModel>(
              builder: (context, compareViewModel, child)
            //データ取得前にリストを取りに行くので[0]のデータがなく、
            // RangeError (index): Invalid value: Valid value range is empty: 0
            // のエラー表示
                  {
                return FutureBuilder(
                  future: compareViewModel.getOverview(comparisonItemId),
                  builder: (context,
                      AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      print('EmptyView通った');
                      return Container();
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              compareViewModel.comparisonOverviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              compareViewModel
                                  .comparisonOverviews[index].way1Title,
                              style: TextStyle(color: Colors.black),
                            );
                          });
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Consumer<CompareViewModel>(
              builder: (context, compareViewModel, child) {
                return FutureBuilder(
                  future: compareViewModel.getOverview(comparisonItemId),
                  builder: (context,
                      AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      print('EmptyView通った');
                      return Container();
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                          compareViewModel.comparisonOverviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              compareViewModel
                                  .comparisonOverviews[index].way2Title,
                              style: TextStyle(color: Colors.black),
                            );
                          });
                    }
                  },
                );
              },
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());

                  return CupertinoTextField(
                    placeholder: 'メリットを入力してください',
                    controller: _controllers[index],
                    style: const TextStyle(color: Colors.black),
                  );
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addList(context),
        ),
      ),
    );
  }

  void addList(BuildContext context) {
    //todo viewModelでメソッド実行してnotifyListener
    _controllers.add(TextEditingController());
  }
}
