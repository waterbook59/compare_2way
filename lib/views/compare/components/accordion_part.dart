import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/desc_form.dart';
import 'package:compare_2way/views/compare/components/desc_form_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';

import 'gf_accordian.dart' as custom;

class AccordionPart extends StatefulWidget {

  const AccordionPart({
    this.title, this.way1MeritList,
    this.inputChanged, this.addList,this.deleteList});

  final String title;
  final List<Way1Merit> way1MeritList;
  final Function(String, int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;

  @override
  _AccordionPartState createState() => _AccordionPartState();
}

class _AccordionPartState extends State<AccordionPart> {

  List<TextEditingController> textFieldControllers = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///課題はGFAccordionの中身を動的に変更できるか(継承とかでGFAccordionを再描画させられる？)
        custom.GFAccordion(
            title: widget.title,
            titleBorderRadius: accordionTopBorderRadius,
            contentBorderRadius:
            accordionBottomBorderRadius,
            showAccordion: true,
            collapsedTitleBackgroundColor:
            const Color(0xFFE0E0E0),
            contentChild:
          //リストが増えていくとDescFormButtonがタイトル部分にはみ出している
            ///=>custom.GFAccordion設定で初期位置修正
//初期y方向-0.06=>0なのでTweenのbeginをOffset.zeroにしてendをOffset(0,0.06)とかプラスにもっていく
            DescFormAndButton(
              items: widget.way1MeritList,
              inputChanged: widget.inputChanged,
              addList: (){
                widget.addList();
//               setState(() {
//               });
              },
              deleteList: widget.deleteList,
            ),
          contentPadding: const EdgeInsets.only(top: 1,left: 8,right: 8),

        ),
//        RaisedButton(
//          child: const Icon(Icons.add),
//          onPressed: () {
//            ///GFAccordionの中の状態を変更しないと意味がない(FutureBuilderまわるだけ)
//            setState(() {
//              widget.addList();
//            });
//          },),
      ],
    );
  }
}


