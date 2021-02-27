import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/list_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<ListViewModel>(context, listen: false);
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
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child:  Center(child: Text('リスト表示'))),
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
              backgroundColor: accentColor,
              child: const Icon(Icons.add, color: Colors.black, size: 40),

            onPressed: () => _saveComparisonItems(context),

          ),
        ),
      ),
    );
  }

  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {

///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
        Navigator.of(context,rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }


}
