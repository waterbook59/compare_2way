import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/desc_form.dart';
import 'package:compare_2way/views/compare/components/desc_form_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';

class AccordionPart extends StatefulWidget {

  const AccordionPart(
      {this.title, this.way1MeritList, this.inputChanged, this.addList});

  final String title;
  final List<Way1Merit> way1MeritList;
  final Function(String, int) inputChanged;
  final Function() addList;

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
        GFAccordion(
            title: widget.title,
            titleBorderRadius: accordionTopBorderRadius,
            contentBorderRadius:
            accordionBottomBorderRadius,
            showAccordion: true,
            collapsedTitleBackgroundColor:
            const Color(0xFFE0E0E0),

            ///DescFormのway1MeritListの数の変更が通知されればGFAccordionはリスト表示している箱にすぎない(かも)
            ///DescFormを再描画させる(Comsumerとか？)
            contentChild:
//                          DescForm(
//                items: widget.way1MeritList,
//                inputChanged: widget.inputChanged,
//              ),
            DescFormAndButton(
              items: widget.way1MeritList,
              inputChanged: widget.inputChanged,
              addList: widget.addList,
            ),

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


