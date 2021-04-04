import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/compare/components/accordion_part.dart';
import 'package:compare_2way/views/compare/components/desc_form.dart';
import 'package:compare_2way/views/compare/components/desc_form_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static List<Way1Merit> testItems = [
    Way1Merit(
      way1MeritId: 1,
      comparisonItemId: '1',
      way1MeritDesc: 'Content 1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          '設定',
          style: middleTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body:Column(children: [
          GFAccordion(
            title: 'テスト',
            titleBorderRadius: accordionTopBorderRadius,
            contentBorderRadius:
            accordionBottomBorderRadius,
            showAccordion:true,
            collapsedTitleBackgroundColor:
            const Color(0xFFE0E0E0),
//            content: 'GFAccordion content',
            contentChild:
                //todo contentChildの中でボタン押す=>DescFormAndButtonへ変更
            DescFormAndButton(
                    way1MeritList: testItems,
                  ),
          ),

        ],)
//        Container(child: const Center(child: Text('設定ページ')),
      ),
    );
  }

}
