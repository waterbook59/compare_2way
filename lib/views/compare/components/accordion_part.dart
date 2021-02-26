import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class AccordionPart extends StatelessWidget {

  AccordionPart({this.title});

  final String title;

  // 適当なリスト用データ
  List<String> items = [
     'Content 1',
     'Content 2',
     'Content 3',
  ];

  List<TextEditingController> textFieldControllers = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {
    return  GFAccordion(
      title: title,
      //trueで最初から開いた状態
      showAccordion: true,
      collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
      contentChild:
          //listView.builder & textEditingController
      //初期表示は出しながら、ボタンおしたらリストの中身をどんどん追加していけるか
      //モデルクラスに格納されたList<String>=>List<TextEditingController>の形でリスト表示できるか

      ListView.builder(
          itemBuilder: (context,index){
          textFieldControllers.add(TextEditingController());
          textFieldControllers[index].text;
    }
      ),
    );
  }
}
