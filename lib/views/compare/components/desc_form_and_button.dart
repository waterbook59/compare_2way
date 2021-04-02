import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:compare_2way/utils/constants.dart';

import 'desc_form.dart';

class DescFormAndButton extends StatefulWidget {

  const DescFormAndButton({
    this.items,this.inputChanged,this.addList,this.deleteList});

  final List<Way1Merit> items;
  final Function(String,int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;

  @override
  _DescFormAndButtonState createState() => _DescFormAndButtonState();
}

class _DescFormAndButtonState extends State<DescFormAndButton> {

  List<TextEditingController> controllers =<TextEditingController>[];
//  ScrollController _scrollController = ScrollController();//mate

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
    return Column(
      children: [
          ListView.builder(
              shrinkWrap:true,
          physics: const NeverScrollableScrollPhysics(),
//            controller: _scrollController,
          itemCount: controllers.length,
          itemBuilder: (context,index){
            return
            //deleteするときのキーボード立ち上がりをふせぐにはStackでボタン独立
            //todo TextFieldを長く入力するとボタンが重なる
              DescForm(
                inputChanged: (newDesc)=> widget.inputChanged(newDesc,index),
                controllers: controllers,
                index: index,
                deleteList: (deleteIndex)=>_deleteList(context, deleteIndex),
//                widget.deleteList,
              );
//              TextFormField(
////              focusNode: AlwaysDisabledFocusNode(),
//              decoration: _getInputDecoration(context,index),
//              controller: controllers[index],
//              onChanged: (newDesc)=> widget.inputChanged(newDesc,index),
//              style: const TextStyle(color: Colors.black),
//            );

          }),
//        ),

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
            print('descFormAndButton/RaisedButton:controllers${controllers.map((controller) => controller.text).toList()}');
            });

        },),
    ],);
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

  //deleteList

}
