import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/conclusion_input_part.dart';
import 'package:compare_2way/views/compare/components/desc_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';

import 'components/icon_title.dart';
import 'components/table_part.dart';

///Table=>conclusionの順で編集するとTableリセットされる問題を解決
class CompareScreen extends StatelessWidget {
  const CompareScreen({this.itemEditMode, this.comparisonOverview});

  final ComparisonOverview comparisonOverview;
  final ItemEditMode itemEditMode;

  //todo itemsはList<Merit>に変更
  static List<String> items = [
    'Content 1',
    'Content 2',
    'Content 3',
  ];

  static final List<TextEditingController> _controllers =
      List.generate(items.length, (i) => TextEditingController(text: items[i]));

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    //initState的に他の画面から写ってきた時のみ読み込み
    if (viewModel.compareScreenStatus == CompareScreenStatus.set) {
      print('compareScreenのFuture通過');
      Future(() {
//        viewModel.getDesc(comparisonOverview.comparisonItemId);
//        print('DB=>veiwのway1List：'
//            '${(viewModel.way1MeritList).map((way1MeritSingle)
//        => way1MeritSingle.comparisonItemId).toList()}');
//        print('viewModel.controllers.length:${viewModel.way1MeritList.length}');
        return viewModel.setOverview(comparisonOverview);
      });
      viewModel.compareScreenStatus = CompareScreenStatus.update;
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
//        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios),
//    onTap: ()=> _backListPage(context)),

        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          ///保存完了ボタン
          GestureDetector(
            child: const Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
            ),
            onTap: () {
              return _saveItem(context, comparisonOverview);
            },
          ),
          const SizedBox(
            width: 16,
          ),

          ///編集ボタン
          //todo タイトル、比較項目編集
          const Text(
            '編集',
            style: trailingTextStyle,
          ),
        ]),
      ),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            print('GestureDetectorをonTap!');

            ///任意の場所をタップするだけでフォーカス外せる(キーボード閉じれる)
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // FutureBuilderいらない(compareOverviewをそのまま表示)
                ///タイトル:itemTitleに変更があったときだけrebuildされるはず
                Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.itemTitle,
                  builder: (context, itemTitle, child) {
                    return Center(
                        child: Text(
                      itemTitle,
                      style: itemTitleTextStyle,
                    ));
                  },
                ),
                const SizedBox(height: 8),
                ///メリットアイコン
                IconTitle(
                  title: 'メリット',
                  iconData: Icons.thumb_up,
                  iconColor: accentColor,
                ),
                ///way1 メリット
                Selector<CompareViewModel, String>(
                    selector: (context, viewModel) => viewModel.way1Title,
                    builder: (context, way1Title, child) {
                      return FutureBuilder(
                        //material
                        future: viewModel
                            .getDesc(comparisonOverview.comparisonItemId),
                        builder:
                            (context, AsyncSnapshot<List<Way1Merit>> snapshot) {
                          if (snapshot.hasData && snapshot.data.isNotEmpty) {
                            return GFAccordion(
                                title: way1Title,
                                titleBorderRadius: accordionTopBorderRadius,
                                contentBorderRadius:
                                    accordionBottomBorderRadius,
                                showAccordion: true,
                                collapsedTitleBackgroundColor:
                                    const Color(0xFFE0E0E0),
                                //todo DescFormを変更してもAccordion閉じると入力消える
                      /// DescFromの完了ボタンを押すとFutureBuilderが回ってDBからデータ取ってしまう
                      /// 入力後viewModelへのsetでは不十分でDB保存まで必要
                                contentChild: DescForm(
                                  items: viewModel.way1MeritList,
                                  inputChanged: (newDesc, index) =>
                                      _way1MeritInputChange(
                                          context, newDesc, index),
                                )
//        ListView.builder(
//            shrinkWrap: true,
//            physics: const NeverScrollableScrollPhysics(),
//            itemCount: snapshot.data.length,
//            itemBuilder: (context, index) {
////               List<TextEditingController> _way1MeritControllers;
////              _way1MeritControllers =
////                  List.generate(snapshot.data.length, (i) =>
////                 TextEditingController(text: snapshot.data[i].way1MeritDesc));
//              return DescForm(items: snapshot.data,);
//            }),
                                );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }),

                ///way2 メリット
                Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.way2Title,
                  builder: (context, way2Title, child) {
                    return GFAccordion(
                      title: way2Title,
                      titleBorderRadius: accordionTopBorderRadius,
                      contentBorderRadius: accordionBottomBorderRadius,
                      collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
                      showAccordion: false,
                      contentChild: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _controllers.length,
                          itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());
                            return CupertinoTextField(
                              placeholder: 'メリットを入力してください',
                              controller: _controllers[index],
                              style: const TextStyle(color: Colors.black),
                            );
                          }),
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),

                ///デメリットアイコン
                IconTitle(
                  title: 'デメリット',
                  iconData: Icons.thumb_down,
                  iconColor: accentColor,
                ),

                ///way1 デメリット
                Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.way1Title,
                  builder: (context, way1Title, child) {
                    return GFAccordion(
                      title: way1Title,
                      titleBorderRadius: accordionTopBorderRadius,
                      contentBorderRadius: accordionBottomBorderRadius,
                      showAccordion: false,
                      collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
                      contentChild: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _controllers.length,
                          itemBuilder: (context, index) {
                            return CupertinoTextField(
                              placeholder: 'メリットを入力してください',
                              controller: _controllers[index],
                              style: const TextStyle(color: Colors.black),
                            );
                          }),
                    );
                  },
                ),

                ///way2 デメリット
                Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.way2Title,
                  builder: (context, way2Title, child) {
                    return GFAccordion(
                      title: way2Title,
                      titleBorderRadius: accordionTopBorderRadius,
                      contentBorderRadius: accordionBottomBorderRadius,
                      collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
                      showAccordion: false,
                      contentChild: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _controllers.length,
                          itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());
                            return CupertinoTextField(
                              placeholder: 'メリットを入力してください',
                              controller: _controllers[index],
                              style: const TextStyle(color: Colors.black),
                            );
                          }),
                    );
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '自己評価',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),

                ///テーブル
                TablePart(
                  way1Title: comparisonOverview.way1Title,
                  way1MeritChanged: (newValue) =>
                      _setWay1Merit(context, newValue),
                  way1MeritEvaluate: comparisonOverview.way1MeritEvaluate,
                  way1DemeritEvaluate: comparisonOverview.way1DemeritEvaluate,
                  way2Title: comparisonOverview.way2Title,
                  way2MeritEvaluate: comparisonOverview.way2MeritEvaluate,
                  way2DemeritEvaluate: comparisonOverview.way2DemeritEvaluate,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '結論',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),

                ///結論TextArea:MaterialForm
                ConclusionInputPart(
                  conclusion: comparisonOverview.conclusion,
                  //非同期でviewModelへ設定しにいかないと値保存できない
                  inputChanged: (newConclusion) =>
                      _conclusionInputChanged(context, newConclusion),
                ),
                const SizedBox(
                  height: 16,
                ),

                ///タグエリア
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'タグ',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const IconButton(
                  icon: Icon(Icons.add),
                  onPressed: null,
                ),

                ///保存ボタン
                Center(
                  child: RaisedButton(
                      child: const Text('保存'),
                      color: accentColor,
                      onPressed: () {
                        return _saveItem(
                          context,
                          comparisonOverview,
                        );
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () => addList(context),
//        ),
      ),
      //TablePartでは変更が会った瞬間にDB保存が必要かも
    );
  }

  Future<void> _saveItem(
      BuildContext context, ComparisonOverview comparisonOverview) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    viewModel.compareScreenStatus = CompareScreenStatus.update;

    FocusScope.of(context).unfocus();

    //ComparisonOverviewをviewModel側から保存に変更
    ///表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
    await viewModel.saveComparisonItem(comparisonOverview);
    await Fluttertoast.showToast(
      msg: '保存完了',
    );
  }

  //conclusion変更されたらset
  Future<void> _conclusionInputChanged(
      BuildContext context, String newConclusion) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setConclusion(newConclusion);
  }

  //way1Merit変更されたらset
  Future<void> _setWay1Merit(BuildContext context, int newValue) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setWay1MeritNewValue(newValue);
  }

  //way1Meritの詳細が変更されたらset
  Future<void> _way1MeritInputChange
      (BuildContext context, String newDesc, int index) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setWay1MeritDesc(newDesc,index);
  }
}
