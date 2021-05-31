import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/compare/components/accordion_part.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form_and_button.dart';
import 'package:compare_2way/views/tag/components/sub/edit_tag_title.dart';
import 'package:compare_2way/views/tag/components/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _tagTitleController = TextEditingController();
  List<TextEditingController> myControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<TagChart> testTagChart = [
    TagChart(
      tagTitle: 'オラオラオラオラ',
      tagAmount: 2,
    ),
    TagChart(
      tagTitle: '無駄無駄無駄無駄',
      tagAmount: 3,
    ),
    TagChart(
      tagTitle: 'ゴールドエクスペリエンス',
      tagAmount: 1,
    ),
    TagChart(
      tagTitle: 'クレイジーダイヤモンド',
      tagAmount: 7,
    ),
  ];
  List<FocusNode> myFocusNodes =[
   FocusNode(),
   FocusNode(),
   FocusNode(),
   FocusNode(),
  ];

  int _selectedIndex ;
  //List<bool>


  static List<Way1Merit> testItems = [
    Way1Merit(
      way1MeritId: 1,
      comparisonItemId: '1',
      way1MeritDesc: 'Content 1',
    ),
  ];

  final myFocusNode = FocusNode();
  bool isDisplayIcon = false;

  @override
  void initState() {
//
    myControllers.asMap().forEach((index, controller) {
      controller.text = testTagChart[index].tagTitle;
    });
//    final tagChartMap = testTagChart.asMap().forEach((index, tagChart) {
//      print('$index,$tagChart');
//    });
    print('myControllers:$myControllers');

    myFocusNode.addListener(() {
     print('Has focus: ${myFocusNode.hasFocus}');
                    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;



//    List<bool>
   final _selected = List.generate(testTagChart.length, (i) => false);

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
        body:GestureDetector(
          onTap: () {
            ///任意の場所をタップするだけでフォーカス外せる(キーボード閉じれる)
            FocusScope.of(context).unfocus();
            //setStateいらない
              isDisplayIcon = false;
          },
          child: SingleChildScrollView(
            child: Column(children: [
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

              const SizedBox(height: 16,),
              const Text('ListView/ListTileテスト'),
              ListView.builder(
                  itemCount: testTagChart.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      decoration: BoxDecoration(
                        color:
                        _selectedIndex == index
//                    index == _selectedIndex
//                    _selected[index]
                          ?Colors.grey[400]
                            :Colors.transparent,
                      ),
                      child: ListTileTheme(
//                    selectedColor: Colors.blueGrey,
                        child: ListTile(

                          title: _selectedIndex == index
                          ?  Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CupertinoTextField(
                              //todo decoration編集
                              controller: myControllers[index],
                              focusNode:
//                              myFocusNode,
                              myFocusNodes[index],
                              maxLines: null,
                            ),
                              ///hasFocus使うと初回でてこないので、isDisplayIcon設定
                              _selectedIndex == index && isDisplayIcon
//                              myFocusNodes[index].hasFocus
                              ?IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                                //ここではvoidCallbackでindexのみ渡して具体的なロジックはDescFormAndButtonで
                                onPressed: (){},
                              )
                                  :Container(),


                          ]
                          )

                          :Text(testTagChart[index].tagTitle),
                          subtitle:Text('アイテム数:${testTagChart[index].tagAmount}'),
                          onTap: (){
                            print('ListTileのリスト onTap!');
                            setState(() {
                              _selectedIndex = index;
                              myFocusNodes[index].requestFocus();
                              isDisplayIcon = true;
//                              myFocusNode.requestFocus();
                            });
                          },

                        ),
                      ),
                    );

                  }),

            ],),
          ),
        )
//        Container(child: const Center(child: Text('設定ページ')),
      ),
    );
  }

}
