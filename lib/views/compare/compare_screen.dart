import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/conclusion_input_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({this.itemEditMode, this.comparisonOverview});

  final ComparisonOverview comparisonOverview;
  final ItemEditMode itemEditMode;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final accentColor = Theme
        .of(context)
        .accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //todo AddViewModelもCompareViewModelに統一
    //compareOverview渡しでsetではなく、AddScreenで設定したものを読み込む形に
//    if(viewModel.comparisonOverviews.isEmpty){
    ///Table=>conclusionの順で編集すると結局Tableリセットされる？？？
    ///enum で他の画面から渡ってきたときのみセットする形にすればできるかも
    ///初回はstatus.set,それ以外はnotifyListeners(status.update)するとか
    if (viewModel.compareScreenStatus == CompareScreenStatus.set) {
      Future(() => viewModel.setOverview(comparisonOverview));
      viewModel.compareScreenStatus = CompareScreenStatus.update;
      print('compareScreenでのupdateOverview.conclusion:${comparisonOverview
          .conclusion}');
      print('compareScreenでのviewModel.conclusion:${viewModel.conclusion}');
      print('compareScreen.status:${viewModel.compareScreenStatus}');
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
//    conclusionFormKey.currentState.save();
              return _saveItem(context,comparisonOverview);
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
          onTap: () {
            print('GestureDetectorをonTap!');
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
//                IconTitle(
//                  title: 'メリット',
//                  iconData: Icons.thumb_up,
//                  iconColor: accentColor,
//                ),
                ///way1 メリット
//                GFAccordion(
//                  title: way1Title,
//                  titleBorderRadius: accordionTopBorderRadius,
//                  contentBorderRadius: accordionBottomBorderRadius,
//                  showAccordion: false,
//                  collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
//                  contentChild: ListView.builder(
//                      shrinkWrap: true,
//                      physics: const NeverScrollableScrollPhysics(),
//                      itemCount: _controllers.length,
//                      itemBuilder: (context, index) {
////              textItems.add(new TextEditingController());
//                        return CupertinoTextField(
//                          placeholder: 'メリットを入力してください',
//                          controller: _controllers[index],
//                          style: const TextStyle(color: Colors.black),
//                        );
//                      }),
//                ),
                ///way2 メリット
//                GFAccordion(
//                  title: way2Title,
//                  titleBorderRadius: accordionTopBorderRadius,
//                  contentBorderRadius: accordionBottomBorderRadius,
//                  collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
//                  showAccordion: false,
//                  contentChild: ListView.builder(
//                      shrinkWrap: true,
//                      physics: const NeverScrollableScrollPhysics(),
//                      itemCount: _controllers.length,
//                      itemBuilder: (context, index) {
////              textItems.add(new TextEditingController());
//                        return CupertinoTextField(
//                          placeholder: 'メリットを入力してください',
//                          controller: _controllers[index],
//                          style: const TextStyle(color: Colors.black),
//                        );
//                      }),
//                ),
                const SizedBox(
                  height: 8,
                ),

                ///デメリットアイコン
//                IconTitle(
//                  title: 'デメリット',
//                  iconData: Icons.thumb_down,
//                  iconColor: accentColor,
//                ),
                ///way1 デメリット
//                GFAccordion(
//                  title: way1Title,
//                  titleBorderRadius: accordionTopBorderRadius,
//                  contentBorderRadius: accordionBottomBorderRadius,
//                  collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
//                  showAccordion: false,
//                  contentChild: ListView.builder(
//                      shrinkWrap: true,
//                      physics: const NeverScrollableScrollPhysics(),
//                      itemCount: _controllers.length,
//                      itemBuilder: (context, index) {
//                        //textItems.add(new TextEditingController());
//                        return CupertinoTextField(
//                          placeholder: 'メリットを入力してください',
//                          controller: _controllers[index],
//                          style: const TextStyle(color: Colors.black),
//                        );
//                      }),
//                ),
                ///way2 デメリット
//                GFAccordion(
//                  title: way2Title,
//                  collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
//                  titleBorderRadius: accordionTopBorderRadius,
//                  contentBorderRadius: accordionBottomBorderRadius,
//                  showAccordion: false,
//                  contentChild: ListView.builder(
//                      shrinkWrap: true,
//                      physics: const NeverScrollableScrollPhysics(),
//                      itemCount: _controllers.length,
//                      itemBuilder: (context, index) {
////              textItems.add(new TextEditingController());
//                        return CupertinoTextField(
//                          placeholder: 'メリットを入力してください',
//                          controller: _controllers[index],
//                          style: const TextStyle(color: Colors.black),
//                        );
//                      }),
//                ),
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
//                TablePart(
//                  way1Title: way1Title,
//                  way1MeritEvaluate: way1MeritEvaluate,
//                  way1DemeritEvaluate: way1DemeritEvaluate,
//                  way2Title: way2Title,
//                  way2MeritEvaluate: way2MeritEvaluate,
//                  way2DemeritEvaluate: way2DemeritEvaluate,
//                ),
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
                ///Statelessの場合はFormのkeyはGlobalObjectKey
                ///GlobalKeyはキーボードが開いてすぐ閉じる
                //todo Formだけを修正して次開くとTabelが別の表示が現れる
                //=>TextFormFieldを押すとaddListenersでcompareScreenが再ビルドされるので、
                //そのときにtablePartに渡ってきた初期値がまた設定されてしまう
                //todo focusしたらstatusをset=>updateに
                ConclusionInputPart(
                  conclusion: comparisonOverview.conclusion,
                  ///非同期でviewModelへ設定しにいかないと値保存できない
                  inputChanged: (newConclusion) =>
                      _conclusionInputChanged(context, newConclusion),
//                      (newConclusion) {
//                    viewModel.conclusion = newConclusion;
//                  },
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
//                        conclusionFormKey.currentState.save();
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

  Future<void> _saveItem(BuildContext context,
      ComparisonOverview comparisonOverview) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    viewModel.compareScreenStatus = CompareScreenStatus.update;

    //ComparisonOverviewをviewModel側から保存
//    final updateComparisonOverview = ComparisonOverview(
//      dataId: comparisonOverview.dataId,
//      comparisonItemId: comparisonOverview.comparisonItemId,
//      itemTitle: viewModel.itemTitle,
//      way1Title: viewModel.way1Title,
//      way1MeritEvaluate: viewModel.way1MeritEvaluate,
//      way1DemeritEvaluate: viewModel.way1DemeritEvaluate,
//      way2Title: viewModel.way2Title,
//      way2MeritEvaluate: viewModel.way2MeritEvaluate,
//      way2DemeritEvaluate: viewModel.way2DemeritEvaluate,
//      conclusion: viewModel.conclusion,
//      favorite: comparisonOverview.favorite,
//      createdAt: DateTime.now(),
//    );
//    print('保存ボタン押した時のconclusion:${updateComparisonOverview.conclusion}');

    FocusScope.of(context).unfocus();

    ///表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
    //notifyListenersはなし
    await viewModel.saveComparisonItem(comparisonOverview);
    await Fluttertoast.showToast(
      msg: '保存完了',
    );
  }

  //conclusion変更されたらset
  Future<void> _conclusionInputChanged(BuildContext context,
      String newConclusion) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setConclusion(newConclusion);

  }


}
