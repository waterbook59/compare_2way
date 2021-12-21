import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/common/nav_bar_icon_title.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import 'components/select_item_list.dart';


class SelectTagPage extends StatelessWidget {
  const SelectTagPage({this.tagTitle});

  final String tagTitle;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        actionsForegroundColor: Colors.white,
        backgroundColor: primaryColor,
        // tagアイコン追加(アイコン+文字を中心にもっていくため右を48空ける)
        middle:NavBarIconTitle(tagTitle:tagTitle,titleIcon: CupertinoIcons.tag,
        rightPadding: 48,),
      ),
      //materialのScaffoldで問題なし
      child:Scaffold(
        body:
        // 並び順を更新日順に変更する
        Selector<CompareViewModel, List<ComparisonOverview>>(
            selector: (context, viewModel) => viewModel.selectOverviews,
            builder: (context, selectOverviews, child) {
//              print('SelectTagPage通って描画');
        return
          //FutureBuilderでgetList()しないと再描画してもselectOverviews更新されない
          //=>この画面を更新したいメソッドのところでselectOverviewsを更新する
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectOverviews.length,
                  itemBuilder: (BuildContext context, int index){
                    final overview = selectOverviews[index];
                    final formatter = DateFormat('yyyy/MM/dd(E) HH:mm:ss', 'ja_JP');
                    final formatted = formatter.format(overview.createdAt);

                    return SelectItemList(
                      title: overview.itemTitle,
                      conclusion: overview.conclusion,
                      createdAt: formatted,
//              onDelete: () => _deleteList(
//                  context, overview.comparisonItemId),
                      onTap: () =>  _updateList(context, overview,tagTitle,),
                      listDecoration: listDecoration,
                    );

                  });

    }
        ),


      )

    );
  }

  void _updateList(BuildContext context, ComparisonOverview updateOverview,
      String tagTitle) {
    ///初期表示は読み込みさせる
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..compareScreenStatus =CompareScreenStatus.set;
    ///画面遷移時、bottomNavbarを外す
    Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
            builder: (context) => CompareScreen(
              comparisonOverview: updateOverview,
              tagTitle: tagTitle,
              screenEditMode: ScreenEditMode.fromSelectTagPage,
            )));

  }
}