import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';


//todo bottomNavbarがあるとややこしいので、Screenへ変更
class CompareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

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
              child: Card(
                  child: GFAccordion(
                    title: '賃貸と購入',
                    //trueで最初から開いた状態
                    showAccordion: true,
                    collapsedIcon: Icon(Icons.details),
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}