import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';
import 'components/table_part.dart';

class CompareScreenStateful extends StatelessWidget {
  const CompareScreenStateful(
      {
      this.itemEditMode,
      this.comparisonOverview});

  final ComparisonOverview comparisonOverview;
  final ItemEditMode itemEditMode;

//
//  static const IconData hand_thumbsup_fill = IconData(0xf6b8,
//      fontFamily: CupertinoIcons.iconFont,
//      fontPackage: CupertinoIcons.iconFontPackage);
//
//  static const IconData hand_thumbsdown_fill = IconData(0xf6b6,
//      fontFamily: CupertinoIcons.iconFont,
//      fontPackage: CupertinoIcons.iconFontPackage);

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
    ///Statelessの場合はGlobalObjectKeyを使う
    const conclusionFormKey = GlobalObjectKey<FormState>('__KEY1__');


    ///initStateで渡ってきた値をセットする
    final itemTitle = comparisonOverview.itemTitle;
    final way1Title = comparisonOverview.way1Title;
    final way2Title = comparisonOverview.way2Title;

    final way1MeritEvaluate = comparisonOverview.way1MeritEvaluate;
    final way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate;
    final way2MeritEvaluate = comparisonOverview.way2MeritEvaluate;
    final way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate;
    final way3MeritEvaluate = comparisonOverview.way3MeritEvaluate;
    final way3DemeritEvaluate = comparisonOverview.way3DemeritEvaluate;
    /// はじめにviewModelへのセット(しないと前回の値がviewModel側に残る)
    viewModel..setWay1MeritNewValue(way1MeritEvaluate)
      ..setWay1DemeritNewValue(way1DemeritEvaluate)
      ..setWay2MeritNewValue(way2MeritEvaluate)
      ..setWay2DemeritNewValue(way2DemeritEvaluate);
    print('viewModel/way1MeritEvaluate:${viewModel.way1MeritEvaluate}');

    var conclusion = comparisonOverview.conclusion;


    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios),
        onTap: ()=> _backListPage(context)),

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
              conclusionFormKey.currentState.save();
              return _saveItem(
                context,
                comparisonOverview,
                itemTitle,
                way1Title,
                way2Title,
                conclusion,
            );
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
          ///任意の場所をタップするだけでフォーカス外せる(キーボード閉じれる)
          onTap: (){
            print('GestureDetectorをonTap!');
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // FutureBuilderいらない(compareOverviewをそのまま表示)
                ///タイトル
                Center(
                  child: Text(
                        itemTitle,
                        style: itemTitleTextStyle,
                      )),
                const SizedBox(height: 8),
                ///メリットアイコン
                IconTitle(
                  title: 'メリット',
                  iconData: Icons.thumb_up,
                  iconColor: accentColor,
                ),
                ///way1 メリット
                GFAccordion(
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
//              textItems.add(new TextEditingController());
                                return CupertinoTextField(
                                  placeholder: 'メリットを入力してください',
                                  controller: _controllers[index],
                                  style: const TextStyle(color: Colors.black),
                                );
                              }),
                        ),
                ///way2 メリット
                GFAccordion(
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
                        GFAccordion(
                        title: way1Title,
                        titleBorderRadius: accordionTopBorderRadius,
                        contentBorderRadius: accordionBottomBorderRadius,
                        collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
                        showAccordion: false,
                        contentChild: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _controllers.length,
                            itemBuilder: (context, index) {
                              //textItems.add(new TextEditingController());
                              return CupertinoTextField(
                                placeholder: 'メリットを入力してください',
                                controller: _controllers[index],
                                style: const TextStyle(color: Colors.black),
                              );
                            }),
                      ),
                ///way2 デメリット
                        GFAccordion(
                        title: way2Title,
                        collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
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
                //todo onChangedだと、テーブル=>結論入力=>保存にすると保存できない
                TablePart(
                  way1Title: way1Title,
                  way1MeritEvaluate: way1MeritEvaluate,
                  way1DemeritEvaluate: way1DemeritEvaluate,
                  way2Title: way2Title,
                  way2MeritEvaluate: way2MeritEvaluate,
                  way2DemeritEvaluate: way2DemeritEvaluate,
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
//                MyCustomForm(
//                  conclusion: conclusion,
//                ),
                ///Statelessの場合はFormのkeyはGlobalObjectKey
                ///GlobalKeyはキーボードが開いてすぐ閉じる
                //todo Formだけを修正して次開くとTabelが別の表示が現れる
                //=>TextFormFieldを押すとaddListenersでcompareScreenが再ビルドされるので、
                //そのときにtablePartに渡ってきた初期値がまた設定されてしまう
                Form(
              key: conclusionFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                  //initialValueとcontrollerの両方は使用できない
                  initialValue:conclusion,
                  onSaved: (newConclusion){
                    conclusion = newConclusion;
                  },
                  ///onSaved+key設定でFormの内容保存できる？
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),//Padding
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
                      //表示されている値をComparisonOverviewに変換して保存
                      onPressed: () {
                        conclusionFormKey.currentState.save();
                        return _saveItem(
                          context,
                          comparisonOverview,
                          itemTitle,
                          way1Title,
                          way2Title,
                          conclusion,
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
      String way2Title,
      String conclusion,
      ) async {
    //保存ボタン押したらキーボード閉じる
    FocusScope.of(context).unfocus();
    //todo Merit/Demerit,tagの更新
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    final updateComparisonOverview = ComparisonOverview(
      dataId: comparisonOverview.dataId,
      comparisonItemId: comparisonOverview.comparisonItemId,
      itemTitle: itemTitle,
      way1Title: way1Title,
      way1MeritEvaluate: viewModel.way1MeritEvaluate,
      way1DemeritEvaluate: viewModel.way1DemeritEvaluate,
      way2Title: way2Title,
      way2MeritEvaluate: viewModel.way2MeritEvaluate,
      way2DemeritEvaluate: viewModel.way2DemeritEvaluate,
      conclusion: conclusion,
      favorite: comparisonOverview.favorite,
      createdAt: DateTime.now(),
    );

    //前回の保存した値が残ったまま=>画面開くときに値をviewModelへセット
    print('保存ボタン押した時のway1MeritEvaluate:${updateComparisonOverview.way1MeritEvaluate}');
    ///表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
    await viewModel.saveComparisonItem(updateComparisonOverview);
    await Fluttertoast.showToast(
      msg: '保存完了',
    );

  }

  Future<void> _backListPage(BuildContext context) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.backListPage();
     Navigator.pop(context);

  }
}