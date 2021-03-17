import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DescForm extends StatefulWidget {
  const DescForm({this.items});

  final List<Way1Merit> items;

  @override
  _DescFormState createState() => _DescFormState();
}

class _DescFormState extends State<DescForm> {

  List<TextEditingController> controllers;

  @override
  void initState() {
    if(widget.items.isNotEmpty){
      //List<Way1Merit>をmapでWay1Meritでほぐして(ここではitem)、
      //Way1Meritのway1MeritDescプロパティだけをTextEditingControllerの初期値設定して、
      //toList()でTextEditingControllerをリスト化
      // [TextEditingController(),TextEditingController(),...]
      controllers = widget.items.map((item){
        return TextEditingController(text: item.way1MeritDesc);
      }).toList();
    }else{
      controllers = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      //Vertical viewport was given unbounded height.のエラーはshrinkWrap:trueで
      shrinkWrap: true,
      children:controllers.map((controller) {
       return CupertinoTextField(
         placeholder: 'メリットを入力してください',
         controller: controller,
         style: const TextStyle(color: Colors.black),
       );
      }).toList(),
    );
  }
}
