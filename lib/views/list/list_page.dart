import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //todo ここでそれぞれのページにAppBarをおく

    ///Theme使う場合はconst入れない
    final primaryColor = CupertinoTheme
        .of(context)
        .primaryColor;
    final accentColor = CupertinoTheme
        .of(context)
        .primaryContrastingColor;
    final regularTextStyle = CupertinoTheme
        .of(context)
        .textTheme
        .textStyle;

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
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
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
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            backgroundColor: accentColor,
//              const Color(0xFFFF7043),
            child: Icon(Icons.add, color: const Color(0xFF000000), size: 40),
            onPressed: () => print('押したぜFAB'),
          ),
        ),
    ),
      );
  }
}
