import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/conclusion_input_part.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';
import 'components/table_part.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen(
      {
//        this.comparisonItemId,
      this.itemEditMode,
      this.comparisonOverview});

  final ComparisonOverview comparisonOverview;
  final ItemEditMode itemEditMode;

//   final String comparisonItemId= updateOverview.comparisonItemId;

  static const IconData hand_thumbsup_fill = IconData(0xf6b8,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  static const IconData hand_thumbsdown_fill = IconData(0xf6b6,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  //todo itemsはList<Merit>に変更
  static List<String> items = [
    'Content 1',
    'Content 2',
    'Content 3',
  ];

  //最初は１つだけ、データが既に入っている場合は取得時に入っている数を出したい
  //データが既に入っている場合は、初期表示として表す
  //List.generate(初期の表示数,(i)=>TextEditingController());
  ///staticがないと、Text selection index was clamped (-1->0) to remain in boundsのエラーで入力がクリアされる
  static final List<TextEditingController> _controllers =
      List.generate(items.length, (i) => TextEditingController(text: items[i]));

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    final itemTitle = comparisonOverview.itemTitle;
    final way1Title = comparisonOverview.way1Title;
    final way2Title = comparisonOverview.way2Title;
    var way1MeritEvaluate = comparisonOverview.way1MeritEvaluate;
    var way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate;
    var way2MeritEvaluate = comparisonOverview.way2MeritEvaluate;
    var way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate;
    var way3MeritEvaluate = comparisonOverview.way3MeritEvaluate;
    var way3DemeritEvaluate = comparisonOverview.way3DemeritEvaluate;

    var conclusion = comparisonOverview.conclusion;


    ///ページ冒頭かFutureBuilderどちらかでいい
//    Future(() {
//      viewModel.getOverview(comparisonItemId);
//        },
//      );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
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
            onTap: () => _saveItem(
                context,
                comparisonOverview,
                itemTitle,
                way1Title,
                way1MeritEvaluate,
                way1DemeritEvaluate,
                way2Title,
                way2MeritEvaluate,
                way2DemeritEvaluate,
                conclusion,
            ),
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
          ///任意の場所をタップするだけでフォーカスを外すことができる
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                //todo FutureBuilderいらないかも(compareOverviewをそのまま表示)
                ///タイトル
//              FutureBuilder(
//                future: viewModel
//                    .getWaitOverview(comparisonOverview.comparisonItemId),
//                builder: (context,
//                    AsyncSnapshot<List<ComparisonOverview>> snapshot) {
//                  if (snapshot.hasData && snapshot.data.isEmpty) {
//                    print('EmptyView通った');
//                    return Container();
//                  } else {
//                    return
                Center(
                  child: Text(
                        itemTitle,
//                      viewModel.itemTitle,
                        style: itemTitleTextStyle,
                      )),
//                  }
//                },
//              ),
                const SizedBox(height: 8),

                ///メリットアイコン
                IconTitle(
                  title: 'メリット',
                  iconData: Icons.thumb_up,
                  iconColor: accentColor,
                ),

                ///way1 メリット
//              FutureBuilder(
//                  future: viewModel
//                      .getWaitOverview(comparisonOverview.comparisonItemId),
//                  builder: (context,
//                      AsyncSnapshot<List<ComparisonOverview>> snapshot) {
//                    if (snapshot.hasData && snapshot.data.isEmpty) {
//                      print('EmptyView通った');
//                      return Container();
//                    } else {
//                      return
                GFAccordion(
                          title: way1Title,
                          titleBorderRadius: accordionTopBorderRadius,
                          contentBorderRadius: accordionBottomBorderRadius,
                          showAccordion: true,
                          collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
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
                        ),
//                    }
//                  }),
                ///way2 メリット
//              FutureBuilder(
//                future: viewModel
//                    .getWaitOverview(comparisonOverview.comparisonItemId),
//                builder: (context,
//                    AsyncSnapshot<List<ComparisonOverview>> snapshot) {
//                  if (snapshot.hasData && snapshot.data.isEmpty) {
//                    print('EmptyView通った');
//                    return Container();
//                  } else {
//                    return
                GFAccordion(
                        title: way2Title,
                        titleBorderRadius: accordionTopBorderRadius,
                        contentBorderRadius: accordionBottomBorderRadius,
                        collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                        showAccordion: true,
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
                      ),
//                  }
//                },
//              ),
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
//              FutureBuilder(
//                future: viewModel
//                    .getWaitOverview(comparisonOverview.comparisonItemId),
//                builder: (context,
//                    AsyncSnapshot<List<ComparisonOverview>> snapshot) {
//                  if (snapshot.hasData && snapshot.data.isEmpty) {
//                    print('EmptyView通った');
//                    return Container();
//                  } else {
//                    return
                        GFAccordion(
                        title: way1Title,
                        titleBorderRadius: accordionTopBorderRadius,
                        contentBorderRadius: accordionBottomBorderRadius,
                        collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                        showAccordion: true,
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
                      ),
//                  }
//                },
//              ),
                ///way2 デメリット
//              FutureBuilder(
//                future: viewModel
//                    .getWaitOverview(comparisonOverview.comparisonItemId),
//                builder: (context,
//                    AsyncSnapshot<List<ComparisonOverview>> snapshot) {
//                  if (snapshot.hasData && snapshot.data.isEmpty) {
//                    print('EmptyView通った');
//                    return Container();
//                  } else {
//                    return
                        GFAccordion(
                        title: way2Title,
                        collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                        titleBorderRadius: accordionTopBorderRadius,
                        contentBorderRadius: accordionBottomBorderRadius,
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
                      ),
//                  }
//                },
//              ),
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
                  way1Title: way1Title,
                  way1MeritEvaluate: way1MeritEvaluate,
                  way1DemeritEvaluate: way1DemeritEvaluate,
                  way2Title: way2Title,
                  way2MeritEvaluate: way2MeritEvaluate,
                  way2DemeritEvaluate: way2DemeritEvaluate,
                  way1MeritChanged: (newValue) {
                    way1MeritEvaluate = newValue;
                  },
                  way1DemeritChanged: (newValue) {
                    way1DemeritEvaluate = newValue;
                  },
                  way2MeritChanged: (newValue) {
                    way2MeritEvaluate = newValue;
                  },
                  way2DemeritChanged: (newValue) {
                    way2DemeritEvaluate = newValue;
                  },
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

                ///結論TextArea
                //todo 既に入力してあるconclusionを渡す
                ConclusionInputPart(
                  conclusion: conclusion,
//                  conclusionController: conclusionController,
                  inputChanged: (newConclusion) {
                    conclusion = newConclusion;
                  },
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
                      child: Text('保存'),
                      color: accentColor,
                      //todo 表示されている値をComparisonOverviewに変換して保存
                      onPressed: () => _saveItem(
                          context,
                          comparisonOverview,
                          itemTitle,
                          way1Title,
                          way1MeritEvaluate,
                          way1DemeritEvaluate,
                          way2Title,
                          way2MeritEvaluate,
                          way2DemeritEvaluate,
                          conclusion,
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
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

  ///保存ボタンロジック
  //表示されている値をComparisonOverviewに変換して保存(TablePartの値保存)

  Future<void> _saveItem(
      BuildContext context,
      ComparisonOverview comparisonOverview,
      String itemTitle,
      String way1Title,
      int way1MeritEvaluate,
      int way1DemeritEvaluate,
      String way2Title,
      int way2MeritEvaluate,
      int way2DemeritEvaluate,
      String conclusion,
      ) async {
    //todo Merit/Demerit,tagの更新
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    final updateComparisonOverview = ComparisonOverview(
      dataId: comparisonOverview.dataId,
      comparisonItemId: comparisonOverview.comparisonItemId,
      itemTitle: itemTitle,
      way1Title: way1Title,
      way1MeritEvaluate: way1MeritEvaluate,
      way1DemeritEvaluate: way1DemeritEvaluate,
      way2Title: way2Title,
      way2MeritEvaluate: way2MeritEvaluate,
      way2DemeritEvaluate: way2DemeritEvaluate,
      conclusion: conclusion,
      favorite: comparisonOverview.favorite,
      createdAt: DateTime.now(),
    );


    ///表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
    await viewModel.saveComparisonItem(updateComparisonOverview);
    await Fluttertoast.showToast(
      msg: '保存完了',
    );
  }
}
