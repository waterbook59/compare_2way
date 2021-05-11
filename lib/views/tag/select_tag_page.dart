import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";


class SelectTagPage extends StatelessWidget {
  const SelectTagPage({this.selectTagList});
//todo viewModel値渡しではなく、SelectTagPage側でviewModelで取得する形に
  final List<Tag> selectTagList;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text(
          //todo viewModel値渡しではなく、SelectTagPage側でviewModelで取得する形に
          selectTagList[0].tagTitle,
          style: middleTextStyle,
        ),
      ),
      //materialのScaffoldで問題なし
      child:Scaffold(
        body:
        Selector<CompareViewModel, List<ComparisonOverview>>(
    selector: (context, viewModel) => viewModel.selectOverviews,
    builder: (context, selectOverviews, child) {
      return
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: selectOverviews.length,
            itemBuilder: (BuildContext context, int index){
            final overview = selectOverviews[index];
            final formatter = DateFormat('yyyy/MM/dd(E) HH:mm:ss', 'ja_JP');
            final formatted = formatter.format(overview.createdAt);

            return OverViewList(
              title: overview.itemTitle,
              conclusion: overview.conclusion,
              createdAt: formatted,
//              onDelete: () => _deleteList(
//                  context, overview.comparisonItemId),
//              onTap: () => _updateList(context, overview),
              listDecoration: listDecoration,
            );


//              Column(children: [Text(overView.itemTitle),
//                const SizedBox(height: 16,),],);
          });


        Text(selectOverviews[0].itemTitle);
    }
        ),


      )

    );
  }
}