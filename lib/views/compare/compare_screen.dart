import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/accordion_part.dart';
import 'package:compare_2way/views/compare/components/tag_chip_part.dart';
import 'package:compare_2way/views/compare/components/conclusion_input_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';
import 'components/sub/edit_bottom_action.dart';
import 'components/icon_title.dart';
import 'components/table_part.dart';

///Table=>conclusionの順で編集するとTableリセットされる問題を解決
class CompareScreen extends StatelessWidget {
  const CompareScreen({
    this.comparisonOverview});

  final ComparisonOverview comparisonOverview;


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

    //initState的に他の画面から写ってきた時のみ読込
    if (viewModel.compareScreenStatus == CompareScreenStatus.set) {
      print('compareScreenのFuture通過');
      Future(() async {
        await viewModel.setOverview(comparisonOverview);
        //viewModelで全てのAccordion中のリストとる
        await viewModel.getAccordionList(comparisonOverview.comparisonItemId);
        //viewModelにcomparisonIdを元に取って来たtagListを格納
        await viewModel.getTagList(comparisonOverview.comparisonItemId);
      });
      viewModel.compareScreenStatus = CompareScreenStatus.update;
    }
///リストの中身を見るのにtoSet使うと良いかも（map((e)=>print).toListが確実）

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
          ///保存完了ボタン //todo 保存完了ボタンWidget分割
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
            width: 8,
          ),
          ///編集ボタン
          EditBottomAction(
            comparisonOverview: comparisonOverview,
          ),
        ]),
      ),
      ///Fab使わないけどScaffold必須
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
              ///way1 メリット way1Titleこの画面で変えないのでSelectorいらんかも
                Selector<CompareViewModel, String>(
                    selector: (context, viewModel) => viewModel.way1Title,
                    builder: (context, way1Title, child) {
                      return FutureBuilder( //material
                        future: viewModel
                        .getWay1MeritDesc(comparisonOverview.comparisonItemId),
                        builder:
                            (context, AsyncSnapshot<List<Way1Merit>> snapshot) {
                          if (snapshot.hasData && snapshot.data.isNotEmpty) {
                            //todo 変更時、createdAtを更新
//                          print('CompareScreen/Way1MeritSelector/FutureBuilder/AccordionPart描画');
                            return AccordionPart(
                              title: way1Title,
                              displayList: DisplayList.way1Merit,
                              inputChanged: (newDesc, index) =>
                                  _accordionInputChange(
                                  context,DisplayList.way1Merit,
                                      newDesc, index,comparisonOverview),
                              way1MeritList: snapshot.data,
                              addList: () =>
                                  _accordionAddList(context,
                                    DisplayList.way1Merit, comparisonOverview),
                              deleteList: (way1MeritIdIndex)=>
                                  _accordionDeleteList(context,
                                        DisplayList.way1Merit,
                                        way1MeritIdIndex,comparisonOverview),
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
                    return FutureBuilder(
                      future: viewModel
                        .getWay2MeritDesc(comparisonOverview.comparisonItemId),
                      builder:
                          (context, AsyncSnapshot<List<Way2Merit>> snapshot) {
                        return snapshot.hasData && snapshot.data.isNotEmpty
                        ?
                          AccordionPart(
                            title: way2Title,
                            displayList: DisplayList.way2Merit,
                            inputChanged: (newDesc, index) =>
                                _accordionInputChange(
                                    context,DisplayList.way2Merit,
                                    newDesc, index,comparisonOverview),
                            way2MeritList: snapshot.data,
                            addList: () =>
                                _accordionAddList(context,
                                    DisplayList.way2Merit,comparisonOverview),
                            deleteList: (way2MeritIdIndex)=>
                                _accordionDeleteList(context,
                                    DisplayList.way2Merit,
                                    way2MeritIdIndex,comparisonOverview),
                          )
                          : Container();
                      },
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
                //todo 自己評価&TablePart widget分割
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
                  //way1Merit以外はTablePart内でviewModelへsetしている
                  way1MeritChanged: (newValue) =>
                      _setWay1Merit(context, newValue),
                  way1MeritEvaluate: comparisonOverview.way1MeritEvaluate,
                  way1DemeritEvaluate: comparisonOverview.way1DemeritEvaluate,
                  way2Title: comparisonOverview.way2Title,
                  way2MeritEvaluate: comparisonOverview.way2MeritEvaluate,
                  way2DemeritEvaluate: comparisonOverview.way2DemeritEvaluate,
                ),
                //todo 結論&ConclusionInputPart widget分割
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
                 // SelectorでDBから取って来たtagList=>displayList渡す
                 Selector<CompareViewModel,List<Chip>>(
                   selector: (context, viewModel) => viewModel.displayChipList,
                     builder: (context, displayChipList, child) {
                       return TagChipPart(
                         comparisonOverview: comparisonOverview,
                         displayChipList:displayChipList,);
                     }
                 ),
              ///保存ボタン
                //todo ConstrainedBoxでボタンサイズ可変
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
      ),
      //TablePartでは変更が会った瞬間にDB保存が必要かも
    );
  }

  Future<void> _saveItem(
      BuildContext context, ComparisonOverview comparisonOverview) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    ..compareScreenStatus = CompareScreenStatus.update;

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

  //TablePartのway1Merit変更されたらset
  Future<void> _setWay1Merit(BuildContext context, int newValue) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setWay1MeritNewValue(newValue);
  }

  ///Accordion中の選択したリストの詳細が変更されたらset
  Future<void> _accordionInputChange(
      BuildContext context,
      DisplayList displayList,
      String newDesc, int index,
      ComparisonOverview comparisonOverview) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
      await viewModel.setChangeListDesc(
          comparisonOverview,displayList,newDesc, index);
    }


  ///Accordion中の選択したリスト追加
  Future<void> _accordionAddList(
      BuildContext context,
      DisplayList displayList,
      ComparisonOverview comparisonOverview) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.accordionAddList(comparisonOverview,displayList);
    }

  ///Accordion中の選択したリスト削除
  Future<void> _accordionDeleteList(
      BuildContext context,
      DisplayList displayList,
      int accordionIdIndex,
      ComparisonOverview comparisonOverview) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.accordionDeleteList(
        displayList,accordionIdIndex,comparisonOverview);
  }


  }



