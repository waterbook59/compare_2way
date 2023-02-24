import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form_and_button.dart';
import 'package:compare_2way/views/compare/components/sub/gf_accordian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';

//import 'sub/gf_accordian.dart' as custom;

class AccordionSubPart extends StatefulWidget {

  const AccordionSubPart({Key? key,
    required this.title,
    required this.displayList,
    this.way1MeritList,
    this.way2MeritList,
    this.way1DemeritList,
    this.way2DemeritList,
    required this.inputChanged,
    required this.addList,
    required this.deleteList,
  }) : super(key: key);
  ///way1&way2のMerit/Demeritを共通して使っているのでway xxx List箇所は安全呼び出し
  final String title;
  final DisplayList displayList;
  final List<Way1Merit>? way1MeritList;
  final List<Way2Merit>? way2MeritList;
  final List<Way1Demerit>? way1DemeritList;
  final List<Way2Demerit>? way2DemeritList;
  final Function(String, int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;

  @override
  _AccordionSubPartState createState() => _AccordionSubPartState();
}

class _AccordionSubPartState extends State<AccordionSubPart> {

  ///way1&way2のMerit/DemeritのListは必ずcompareScreenから値くるので?付けない
  List<TextEditingController> controllers = <TextEditingController>[];
  List<FocusNode> focusNodes = <FocusNode>[];


  @override
  void initState() {
    //todo way3Merit,Demerit分作成
    switch (widget.displayList) {
      case DisplayList.way1Merit:
        widget.way1MeritList!.isNotEmpty
            ? createWay1MeritList()
            : controllers = [];
        break;
      case DisplayList.way2Merit:
        widget.way2MeritList!.isNotEmpty
            ? createWay2MeritList()
            : controllers = [];
        break;
      case DisplayList.way1Demerit:
        widget.way1DemeritList!.isNotEmpty
            ? createWay1DemeritList()
            : controllers = [];
        break;
      case DisplayList.way2Demerit:
        widget.way2DemeritList!.isNotEmpty
            ? createWay2DemeritList()
            : controllers = [];
        break;
    }

    super.initState();
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose()).toList();
    focusNodes.map((e) => e.dispose()).toList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//Column=> StackでDescFormAndButtonをGFAccordionのタイトルのところに追加(PlayButtonsPart)
    return Stack(
      children: [

        GFAccordion(
          title: widget.title,
          titleBorderRadius: accordionTopBorderRadius,
          contentBorderRadius:
          accordionBottomBorderRadius,
          showAccordion: true,
          collapsedTitleBackgroundColor:
          const Color(0xFFE0E0E0),
          // collapsed時にDB再読込,更新される場合されない場合のエラー回避
          onToggleCollapsed: (value){
            FocusScope.of(context).unfocus();
            //accordionpart=>descFormのiconButtonの非表示
            viewModel
              ..isWay1MeritDeleteIcon  = false
              ..isWay1DemeritDeleteIcon  = false
              ..isWay2MeritDeleteIcon  = false
              ..isWay2DemeritDeleteIcon  = false
              ..isWay3MeritDeleteIcon  = false
              ..isWay3DemeritDeleteIcon  = false

              ..isWay1MeritFocusList = false//settingPageでやったisReturnText
              ..isWay2MeritFocusList = false
              ..isWay3MeritFocusList = false
              ..isWay1DemeritFocusList = false
              ..isWay2DemeritFocusList = false
              ..isWay3DemeritFocusList = false;

          },
          contentChild:
          //リストが増えていくとDescFormButtonがタイトル部分にはみ出している
          ///=>custom.GFAccordion設定で初期位置修正
          //todo way3追加
          DescFormAndButton(
            displayList: widget.displayList,
            way1MeritList: widget.way1MeritList,
            way1DemeritList: widget.way1DemeritList,
            way2MeritList: widget.way2MeritList,
            way2DemeritList: widget.way2DemeritList,
            inputChanged: widget.inputChanged,
            addList: (){
              widget.addList();
            },
            deleteList: widget.deleteList,
            controllers: controllers,
            focusNodes: focusNodes,
          ),
          contentPadding: const EdgeInsets.only(top: 1,left: 8,right: 8),
        ),

        //todo ボタン押しやすいサイズに
        Positioned(
          right: 64,
          top: 20,
          child: GestureDetector(
              child: const Icon(
                CupertinoIcons.plus_circled, color: Colors.black,),
              // DescFormAndButtonのsetStateで実行していることをここでやる
              onTap: () {
                setState(() {
                  widget.addList();
                  controllers.add(TextEditingController());
                  focusNodes.add(FocusNode());
                });
              },),)
      ],
    );
  }

  //todo way3Merit,Demerit分作成
  ///initStateでの条件分岐があり必ず各リストが入るので強制呼び出し
  void createWay1MeritList() {
    controllers = widget.way1MeritList!.map((item) {
      return TextEditingController(text: item.way1MeritDesc);
    }).toList();
    focusNodes = widget.way1MeritList!.map((item) => FocusNode()).toList();
  }

  void createWay2MeritList() {
    controllers = widget.way2MeritList!.map((item) {
      return TextEditingController(text: item.way2MeritDesc);
    }).toList();
    focusNodes = widget.way2MeritList!.map((item) => FocusNode()).toList();
  }
  void createWay1DemeritList() {
    controllers = widget.way1DemeritList!.map((item) {
      return TextEditingController(text: item.way1DemeritDesc);
    }).toList();
    focusNodes = widget.way1DemeritList!.map((item) => FocusNode()).toList();
  }
  void createWay2DemeritList() {
    controllers = widget.way2DemeritList!.map((item) {
      return TextEditingController(text: item.way2DemeritDesc);
    }).toList();
    focusNodes = widget.way2DemeritList!.map((item) => FocusNode()).toList();
  }


}
