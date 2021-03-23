import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DescFormAndButton extends StatefulWidget {

  const DescFormAndButton({this.items,this.inputChanged,this.addList});

  final List<Way1Merit> items;
  final Function(String,int) inputChanged;
  final Function() addList;

  @override
  _DescFormAndButtonState createState() => _DescFormAndButtonState();
}

class _DescFormAndButtonState extends State<DescFormAndButton> {

  List<TextEditingController> controllers;

  @override
  void initState() {
    if(widget.items.isNotEmpty){
      controllers = widget.items.map((item){
        return TextEditingController(text: item.way1MeritDesc);
      }).toList();

      print('descFormAndButton/initState/items${widget.items.map((item)=>item.way1MeritDesc).toList()}');

    }else{
      controllers = [];
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(children: [
        ListView.builder(
        shrinkWrap:true,
        itemCount: controllers.length,
        itemBuilder: (context,index){
          return CupertinoTextField(//cupertiono
            //todo InputDecorationでsuffixIconプロパティでリスト削除できるかも
            placeholder: 'メリットを入力してください',
            controller: controllers[index],
            onChanged: (newDesc)=> widget.inputChanged(newDesc,index),
            style: const TextStyle(color: Colors.black),
          );
        }),

      RaisedButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            print('押したらリストが増える');
            widget.addList();
            controllers.add(TextEditingController());
            print('descFormAndButton/RaisedButton/controllers${controllers.map((controller) => controller.text).toList()}');
          });

        },),
    ],);
  }
}
