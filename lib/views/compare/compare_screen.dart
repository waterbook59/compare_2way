import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/common/nav_bar_button.dart';
import 'package:compare_2way/views/common/nav_bar_icon_title.dart';
import 'package:compare_2way/views/compare/components/accordion_part.dart';
import 'package:compare_2way/views/compare/components/conclusion_input_part.dart';
import 'package:compare_2way/views/compare/components/sub/accrodion_sub_part.dart';
import 'package:compare_2way/views/compare/components/tag_chip_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'components/icon_title.dart';
import 'components/sub/edit_bottom_action.dart';
import 'components/table_part.dart';

///Table=>conclusionの順で編集するとTableリセットされる問題を解決
class CompareScreen extends StatelessWidget {
  const CompareScreen({Key? key,
    ///comparisonOverviewは必ずページ遷移で入るはず
    required this.comparisonOverview,
    this.tagTitle,
    this.screenEditMode,
  }) : super(key: key);

  final ComparisonOverview comparisonOverview;
  final String? tagTitle;
  final ScreenEditMode? screenEditMode;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;
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
        //最後getCandidateでnotifyListenersする
//        await viewModel.getCandidateTagList();
      });
      viewModel.compareScreenStatus = CompareScreenStatus.update;
    }
///リストの中身を見るのにtoSet使うと良いかも（map((e)=>print).toListが確実）

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        ///leadingの戻るアイコンの色を変更するだけならこれでOK
        /// todo actionsForegroundColorが廃止
        // actionsForegroundColor: Colors.white,
        middle:
        screenEditMode ==ScreenEditMode.fromListPage
            ?  Selector<CompareViewModel, String>(
          selector: (context, viewModel) => viewModel.itemTitle,
          builder: (context, itemTitle, child) {
            return Text(
                  itemTitle,
                  style: middleTextStyle,
                );
          },
        )
//            : Text(tagTitle,style: middleTextStyle,),
          //todo 右に保存完了ボタンがあるのでNavBarIconTitleの左側にスペース追加
        ///fromSelectTagPageの場合、tagTitle必ず入ってくるので強制呼び出し
        :NavBarIconTitle(tagTitle:tagTitle!,titleIcon: CupertinoIcons.tag,
        leftFlex: 1,centerFlex: 10,rightFlex: 1,),

        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          ///保存完了ボタン
          NavBarButton(navBarIcon: CupertinoIcons.check_mark_circled,
          onTap: () => _saveItem(context, comparisonOverview),),
          const SizedBox(width: 8,),
          ///編集ボタン
          EditBottomAction(comparisonOverview: comparisonOverview,),
        ],),
      ),
      ///Fab使わないけどScaffold必須
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            _onTapUnFocus(context);
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // FutureBuilderいらない(compareOverviewをそのまま表示)
              ///タイトル:itemTitleに変更があったときだけrebuildされる
                screenEditMode ==ScreenEditMode.fromListPage
                ? Container()
                //TagPage側から
                :Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.itemTitle,
                  builder: (context, itemTitle, child) {
                    return Column(
                      children:[ Center(
                          child: Text(
                        itemTitle,
                        style: itemTitleTextStyle,
                      ),),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
              ///segment表示切り替えボタン
                SizedBox(
                  width: double.infinity,
                  child: Selector<CompareViewModel, String>(
                    selector: (context, viewModel) => viewModel.segmentValue,
                      builder: (context, segmentValue, child) {
                      //todo widget分割ですっきり書きたい
                      return CupertinoSegmentedControl(
                        children: const
                        {'0': Text('All'),
                          '1': Text('way1'),
                          '2': Text('way2'),},
                        onValueChanged: (String newValue){
                          print(newValue);
                          _selectSegment(context,newValue);
                        },
                        groupValue: segmentValue,
                        padding: const EdgeInsets.only(
                            right: 24,left: 24,bottom: 16,),
                        borderColor: Colors.grey,
                        selectedColor: primaryColor,
                      );
                      }

                  ,),
                ),
              ///メリットアイコン
                IconTitle(
                  title: 'メリット',
                  iconData: Icons.thumb_up,
                  iconColor: accentColor,
                ),
             ///リストのDeleteIconの表示をリスト跨ぎで再ビルドが必要なので、Selector=>Consumer
                ///way1 メリット
                Consumer<CompareViewModel>(
//                Selector<CompareViewModel, String>(
//                    selector: (context, viewModel) => viewModel.way1Title,
                    builder: (context, viewModel, child) {
                      return
                  (viewModel.segmentValue == '0'||viewModel.segmentValue == '1')
                        ? FutureBuilder( //material
                        future: viewModel
                        .getWay1MeritDesc(comparisonOverview.comparisonItemId),
                        builder:
                            (context, AsyncSnapshot<List<Way1Merit>> snapshot) {
                            //todo 変更時、createdAtを更新
                              return
                                ///inNotEmpty箇所は強制呼び出しでエラー消える
                                snapshot.hasData && snapshot.data!.isNotEmpty
                            ? AccordionPart(
                              title: viewModel.way1Title,
                              displayList: DisplayList.way1Merit,
                              inputChanged: (newDesc, index) =>
                                  _accordionInputChange(
                                  context,DisplayList.way1Merit,
                                      newDesc, index,comparisonOverview,),
                              way1MeritList: snapshot.data,
                              addList: () =>
                                  _accordionAddList(context,
                                    DisplayList.way1Merit, comparisonOverview,),
                              deleteList: (way1MeritIdIndex)=>
                                  _accordionDeleteList(context,
                                        DisplayList.way1Merit,
                                        way1MeritIdIndex,comparisonOverview,),
                            )
                            ///SegmentedControl切替時nullの時、文頭で取得した値表示
//AccordionPartにするとsnapshot.data =nullの時にAccordionPartのinitStateが回ってしまう)
                              :AccordionSubPart(
                                title: viewModel.way1Title,
                                displayList: DisplayList.way1Merit,
                                inputChanged: (newDesc, index) =>
                                    _accordionInputChange(
                                        context,DisplayList.way1Merit,
                                        newDesc, index,comparisonOverview,),
                                way1MeritList: viewModel.way1MeritList,
                                addList: () =>
                                    _accordionAddList(context,
                                        DisplayList.way1Merit,
                                        comparisonOverview,),
                                deleteList: (way1MeritIdIndex)=>
                                    _accordionDeleteList(context,
                                        DisplayList.way1Merit,
                                        way1MeritIdIndex,comparisonOverview,),
                              );
//                              :Container(child: Text('nullの時/FutureBuilder  Merit way1みえない'),);
                          }
//                        },
                      ,)
                      : Container();
                    },),
                ///way2 メリット
                Consumer<CompareViewModel>(
//                Selector<CompareViewModel, String>(
//                  selector: (context, viewModel) => viewModel.way2Title,
                  builder: (context, viewModel, child) {
                    return
                      (viewModel.segmentValue == '0'||
                          viewModel.segmentValue == '2')
                      ? FutureBuilder(
                      future: viewModel
                        .getWay2MeritDesc(comparisonOverview.comparisonItemId),
                      builder:
                          (context, AsyncSnapshot<List<Way2Merit>> snapshot) {
                        return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? AccordionPart(
                            title: viewModel.way2Title,
                            displayList: DisplayList.way2Merit,
                            inputChanged: (newDesc, index) =>
                                _accordionInputChange(
                                    context,DisplayList.way2Merit,
                                    newDesc, index,comparisonOverview,),
                            way2MeritList: snapshot.data,
                            addList: () =>
                                _accordionAddList(context,
                                    DisplayList.way2Merit,comparisonOverview,),
                            deleteList: (way2MeritIdIndex)=>
                                _accordionDeleteList(context,
                                    DisplayList.way2Merit,
                                    way2MeritIdIndex,comparisonOverview,),
                          )
                        : AccordionSubPart(
                            title: viewModel.way2Title,
                            displayList: DisplayList.way2Merit,
                            inputChanged: (newDesc, index) =>
                                _accordionInputChange(
                                    context,DisplayList.way2Merit,
                                    newDesc, index,comparisonOverview,),
                            way2MeritList: viewModel.way2MeritList,
                            addList: () =>
                                _accordionAddList(context,
                                    DisplayList.way2Merit,comparisonOverview,),
                            deleteList: (way2MeritIdIndex)=>
                                _accordionDeleteList(context,
                                    DisplayList.way2Merit,
                                    way2MeritIdIndex,comparisonOverview,),
                          );
                      },
                    )
                    :Container();
                  },
                ),
                const SizedBox(height: 8,),
              ///デメリットアイコン
                IconTitle(
                  title: 'デメリット',
                  iconData: Icons.thumb_down,
                  iconColor: accentColor,
                ),
              ///way1 デメリット
                Consumer<CompareViewModel>(
                  builder: (context, viewModel, child) {
                    return
                      (viewModel.segmentValue == '0'||
                          viewModel.segmentValue == '1')
                      ? FutureBuilder(future: viewModel.getWay1DemeritDesc(
                          comparisonOverview.comparisonItemId,),
                      builder:
                          (context, AsyncSnapshot<List<Way1Demerit>> snapshot) {
                        return snapshot.hasData && snapshot.data!.isNotEmpty
                            ? AccordionPart(
                          title: viewModel.way1Title,
                          displayList: DisplayList.way1Demerit,
                          inputChanged: (newDesc, index) =>
                              _accordionInputChange(
                                  context,DisplayList.way1Demerit,
                                  newDesc, index,comparisonOverview,),
                          way1DemeritList: snapshot.data,
                          addList: () =>
                              _accordionAddList(context,
                                  DisplayList.way1Demerit,comparisonOverview,),
                          deleteList: (way1DemeritIdIndex)=>
                              _accordionDeleteList(context,
                                  DisplayList.way1Demerit,
                                  way1DemeritIdIndex,comparisonOverview,),
                        )
                            : AccordionSubPart(
                          title: viewModel.way1Title,
                          displayList: DisplayList.way1Demerit,
                          inputChanged: (newDesc, index) =>
                              _accordionInputChange(
                                  context,DisplayList.way1Demerit,
                                  newDesc, index,comparisonOverview,),
                          way1DemeritList: viewModel.way1DemeritList,
                          addList: () =>
                              _accordionAddList(context,
                                  DisplayList.way1Demerit,comparisonOverview,),
                          deleteList: (way1DemeritIdIndex)=>
                              _accordionDeleteList(context,
                                  DisplayList.way1Demerit,
                                  way1DemeritIdIndex,comparisonOverview,),
                        );
                      },
                    )
                    :Container();
                  },
                ),
              ///way2 デメリット
                Consumer<CompareViewModel>(
                  builder: (context, viewModel, child) {
                    return
                      (viewModel.segmentValue == '0'||
                          viewModel.segmentValue == '2')
                      ? FutureBuilder(future: viewModel.getWay2DemeritDesc(
                          comparisonOverview.comparisonItemId,),
                      builder:
                          (context, AsyncSnapshot<List<Way2Demerit>> snapshot) {
                        return snapshot.hasData && snapshot.data!.isNotEmpty
                            ? AccordionPart(
                          title: viewModel.way2Title,
                          displayList: DisplayList.way2Demerit,
                          inputChanged: (newDesc, index) =>
                              _accordionInputChange(
                                  context,DisplayList.way2Demerit,
                                  newDesc, index,comparisonOverview,),
                          way2DemeritList: snapshot.data,
                          addList: () =>
                              _accordionAddList(context,
                                  DisplayList.way2Demerit,comparisonOverview,),
                          deleteList: (way1DemeritIdIndex)=>
                              _accordionDeleteList(context,
                                  DisplayList.way2Demerit,
                                  way1DemeritIdIndex,comparisonOverview,),
                        )
                            : AccordionSubPart(
                          title: viewModel.way2Title,
                          displayList: DisplayList.way2Demerit,
                          inputChanged: (newDesc, index) =>
                              _accordionInputChange(
                                  context,DisplayList.way2Demerit,
                                  newDesc, index,comparisonOverview,),
                          way2DemeritList: viewModel.way2DemeritList,
                          addList: () =>
                              _accordionAddList(context,
                                  DisplayList.way2Demerit,comparisonOverview,),
                          deleteList: (way1DemeritIdIndex)=>
                              _accordionDeleteList(context,
                                  DisplayList.way2Demerit,
                                  way1DemeritIdIndex,comparisonOverview,),
                        );
                      },
                    )
                    :Container();
                  },
                ),
                //todo 自己評価&TablePart widget分割(スッキリ書く)
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('自己評価', textAlign: TextAlign.left,),
                ),
                const SizedBox(height: 4,),
              ///テーブル
                //todo  width: MediaQuery.of(context).size.width*0.8の形に変更
                //todo 保存せずに戻ると一部値が入力された状態を保持
                //way1Title,way2Title名編集時に即時反映させる=>Consumer
                Consumer<CompareViewModel>(
                 builder: (context, viewModel, child) {
                  return
                    TablePart(
                      comparisonItemId: comparisonOverview.comparisonItemId,
                      way1Title: viewModel.way1Title,
                      way1MeritEvaluate: comparisonOverview.way1MeritEvaluate!,
                      way1DemeritEvaluate:
                      comparisonOverview.way1DemeritEvaluate!,
                      way2Title: viewModel.way2Title,
                      way2MeritEvaluate: comparisonOverview.way2MeritEvaluate!,
                      way2DemeritEvaluate:
                      comparisonOverview.way2DemeritEvaluate!,
                      );
                    }
                ,),
                //todo 結論&ConclusionInputPart widget分割(スッキリ書く)
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
                Selector<CompareViewModel, String>(
                  selector: (context, viewModel) => viewModel.conclusion,
                    builder: (context, conclusion, child) {
                    return ConclusionInputPart(
                      conclusion: comparisonOverview.conclusion!,
                      //非同期でviewModelへ設定しにいかないと値保存できない
                      inputChanged: (newConclusion) =>
                          _conclusionInputChanged(context, newConclusion,
                            comparisonOverview.comparisonItemId,),
                    );
                    }
                ,),
                const SizedBox(height: 16,),
              ///タグエリア
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('タグ', textAlign: TextAlign.left,),
                ),
                const SizedBox(height: 4,),
                 // SelectorでDBから取って来たtagList=>displayList渡す
                 Selector<CompareViewModel,List<Chip>>(
                   selector: (context, viewModel) => viewModel.displayChipList,
                     builder: (context, displayChipList, child) {
                       return TagChipPart(
                         comparisonOverview: comparisonOverview,
                         //todo 初期はタグのリストはないのでnullになる？？
                         displayChipList:displayChipList,);
                     }
                 ,),
              ///保存ボタン
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape:
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),),
                    ),
                      onPressed: () async {
                      ///戻り値Future<void>のメソッド定義の場合、呼び出しはawait必要
                         await _saveItem(context,comparisonOverview,);},
                      child: const Text('保存'),),
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
      //TablePartでは変更が会った瞬間にDB保存が必要かも
    );
  }

  Future<void> _saveItem(
      BuildContext context, ComparisonOverview comparisonOverview,) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    ..compareScreenStatus = CompareScreenStatus.update;

    FocusScope.of(context).unfocus();

    //ComparisonOverviewをviewModel側から保存に変更
    ///表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
    await viewModel.saveComparisonItem(comparisonOverview);
    //todo 完了アイコンの入ったトースト表示
    await Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      msg: '保存完了',
    );
  }

  //conclusion変更されたらset
  Future<void> _conclusionInputChanged(
      BuildContext context, String newConclusion,String comparisonItemId,)
  async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.setConclusion(newConclusion:newConclusion,
        comparisonItemId: comparisonItemId,);
  }

  ///Accordion中の選択したリストの詳細が変更されたらset
  Future<void> _accordionInputChange(
      BuildContext context,
      DisplayList displayList,
      String newDesc, int index,
      ComparisonOverview comparisonOverview,) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
      await viewModel.setChangeListDesc(
          comparisonOverview,displayList,newDesc, index,);
    }


  ///Accordion中の選択したリスト追加
  Future<void> _accordionAddList(
      BuildContext context,
      DisplayList displayList,
      ComparisonOverview comparisonOverview,) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.accordionAddList(comparisonOverview,displayList);
    }

  ///Accordion中の選択したリスト削除
  Future<void> _accordionDeleteList(
      BuildContext context,
      DisplayList displayList,
      int accordionIdIndex,
      ComparisonOverview comparisonOverview,) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.accordionDeleteList(
        displayList,accordionIdIndex,comparisonOverview,);
  }

  void _onTapUnFocus(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //print('GestureDetectorをonTap!isDisplayIcon:${viewModel.isDisplayIcon}');
    ///任意の場所をタップするだけでフォーカス外せる(キーボード閉じれる)
    FocusScope.of(context).unfocus();
    //accordionpart=>descFormのiconButtonの非表示
    viewModel
      ..isWay1MeritDeleteIcon  = false
      ..isWay2MeritDeleteIcon  = false
      ..isWay1DemeritDeleteIcon  = false
      ..isWay2DemeritDeleteIcon  = false
      ..isWay3MeritDeleteIcon  = false
      ..isWay3DemeritDeleteIcon  = false
      ..isWay1MeritFocusList = false//settingPageでやったisReturnText
      ..isWay2MeritFocusList = false
      ..isWay1DemeritFocusList = false
      ..isWay2DemeritFocusList = false
      ..isWay3MeritFocusList = false
      ..isWay3DemeritFocusList = false;
  }

  ///選択したsegmentに更新
  Future<void> _selectSegment(BuildContext context,String newValue) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.selectSegment(newValue);
  }



  }
