import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';


class CompareScreen extends StatelessWidget {

  const CompareScreen({this.comparisonItemId});
  final String comparisonItemId;

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

    final viewModel = Provider.of<CompareViewModel>(context,listen: false);
    //普通にここのFuture内でstream.listenして通知すればbodyをStatefulにしなくても良い
    Future((){
      viewModel.getOverview(comparisonItemId);
    });

    return CupertinoPageScaffold(
      //todo trailing修正時はconst削除
      navigationBar: const CupertinoNavigationBar(
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
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              child: GFAccordion(
                title: 'way1',
                //trueで最初から開いた状態
                showAccordion: true,
//                collapsedIcon: Icon(Icons.details),
                collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                contentChild: Column(
                  children: [
                    Row(children: [
                      Text('結論'),
                      CupertinoSwitch(
                        value: true,
                        onChanged: (value) {
                          value = false;
                        },
                      )
                    ]),
                    Text('購入を検討しつつ、２年は賃貸'),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>addList(context),
        ),
      ),
    );
  }

  void addList(BuildContext context) {}
}
