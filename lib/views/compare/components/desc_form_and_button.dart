import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'desc_form.dart';

class DescFormAndButton extends StatefulWidget {
  const DescFormAndButton(
      {this.displayList,
      this.way1MeritList,
      this.way2MeritList,
      this.inputChanged,
      this.addList,
      this.deleteList});

  final DisplayList displayList;
  final List<Way1Merit> way1MeritList;
  final List<Way2Merit> way2MeritList;
  final Function(String, int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;

  @override
  _DescFormAndButtonState createState() => _DescFormAndButtonState();
}

class _DescFormAndButtonState extends State<DescFormAndButton> {
  List<TextEditingController> controllers = <TextEditingController>[];

  @override
  void initState() {
    switch(widget.displayList){
      case DisplayList.way1Merit:
        widget.way1MeritList.isNotEmpty
            ? controllers = widget.way1MeritList.map((item) {
          return TextEditingController(text: item.way1MeritDesc);
        }).toList()
        :controllers = [];
        break;
      case DisplayList.way2Merit:
        widget.way2MeritList.isNotEmpty
            ? controllers = widget.way2MeritList.map((item) {
          return TextEditingController(text: item.way2MeritDesc);
        }).toList()
            :controllers = [];
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return
                  //deleteするときのキーボード立ち上がりをふせぐにはStackでボタン独立
                  DescForm(
                inputChanged: (newDesc) => widget.inputChanged(newDesc, index),
                controllers: controllers,
                index: index,
                deleteList: (deleteIndex) => _deleteList(context, deleteIndex),
              );
            }),
        RaisedButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              //非同期(widget.addList)を待ってる間に先にcontrollersが増える
              // =>非同期終了したらviewModelでの_way1MeritListにリスト増えた形で格納
              print('押したらリストが増える');
              //追加直後にCompareScreen/Way1MeritSelector/FutureBuilder/AccordionPart描画しない
              widget.addList();
              controllers.add(TextEditingController());
              print(
                  'descFormAndButton/RaisedButton:controllers${controllers.map((controller) => controller.text).toList()}');
            });
          },
        ),
      ],
    );
  }

  //deleteするときのキーボード立ち上がりをふせぐ
  void _deleteList(BuildContext context, int deleteIndex) {
    print(
        'DescFormAndButton/removeOnTapした瞬間のcontrollers.length:${controllers.length}'
        '/onTapしたindex$deleteIndex');

    //リストを0にしない
    if (controllers.length > 1) {
      setState(() {
        controllers.removeAt(deleteIndex);
        widget.deleteList(deleteIndex);
        print('DescForm削除setState時のcontrollers.length:'
            '${controllers.length}');
      });
    }
  }
}
