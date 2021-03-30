import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            return TextFormField(
            decoration: _getInputDecoration(context,index),
              controller: controllers[index],
              onChanged: (newDesc)=> widget.inputChanged(newDesc,index),
              style: const TextStyle(color: Colors.black),
            );
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

  //todo deleteするときのキーボード立ち上がりをふせぐ
  InputDecoration _getInputDecoration(BuildContext context, int index) {
    return InputDecoration(
      hintText: 'メリットを入力してください',
      suffixIcon:Padding(
        padding:const EdgeInsetsDirectional.only(end: 12) ,
        child: GestureDetector(
          child: const Icon(Icons.remove_circle_outline),
          onTap: () {
            FocusScope.of(context).unfocus();
     print('DescFormAndButton/removeOnTapした瞬間のcontrollers.length:${controllers.length}'
                  '/onTapしたindex$index');
     //リストを0にしない
    if( controllers.length>1){
      setState(() {
        controllers.removeAt(index);
        //widget.items[index]は追加された直後は
        // CompareScreen/Way1MeritSelector/FutureBuilder/AccordionPart描画がなく、
        // initState通ってないので、存在しない=>エラー
        // indexだけわたしてviewModel側でway1MeritId設定
        widget.deleteList(index);
        print('DescFormAndButton/削除setState時のcontrollers.length:${controllers.length}');
      });
    }
          },
        ),
      ),
    );
  }
}
