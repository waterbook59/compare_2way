import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DescForm extends StatefulWidget {
  const DescForm(
      {
      this.inputChanged,
      this.index,
      this.controllers,
      this.deleteList,
      this.focusNode,
        this.displayList,
      });

  final Function(String) inputChanged;
  final Function(int) deleteList;
  final int index;
  final List<TextEditingController> controllers;
  final FocusNode focusNode;
  final DisplayList displayList;


  @override
  _DescFormState createState() => _DescFormState();
}

class _DescFormState extends State<DescForm> {
//  final _focusNode = FocusNode();

//  @override
//  void initState() {
//    widget.focusNode.addListener(() {
//      print('Has focus: ${widget.focusNode.hasFocus}');
//    });
//    super.initState();
//  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

//todo way1,2,3Merit,Demerit分作成
    switch(widget.displayList){
      case DisplayList.way1Merit:
        return Stack(
          //material
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'メリットを入力してください',
                ///TextFieldを長く入力するとボタンが重なるのを回避
                contentPadding: EdgeInsets.fromLTRB(6, 6, 48, 0),
//InputDecoration/isDense:trueで幅狭くなる
//            isDense: true,
              ),
              controller: widget.controllers[widget.index],
              onChanged: (newDesc) => widget.inputChanged(newDesc),
              style: const TextStyle(color: Colors.black),
              ///TextFieldを長く入力すると折り返し
              maxLines: null,
              focusNode: widget.focusNode,
            ),
            //todo ボタンをフォーカス時のみ出す、初回時、way1Meritとway2Meritをまたぐ時ボタンでない
            //_focusNode.hasFocusで最初IconButton出ない、閉じると出る=>初期設定おかしい
            //ListViewのcontrollersの中をfocus中に移動すると最初のfocus時しかIconButton出ない=>focusNodeをListView.builderの中でindexとともに設定=>DescFormのインスタンスに渡す
            //focus中に移動するとtrue=>false=>trueとなって結局消えない、移動した時にfocusNodeをfalseにするには？
            //初回 isDisplayIconをviewModelにもたせる、2回目以降hasFocus


            //todo displayListで場合わけしたい
            viewModel.isWay1MeritDeleteIcon
                ?//GestureDetector _selectedIndex ==index 且つfocus当たってるとき
            IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.grey,
                size: 24,
              ),
              //ここではvoidCallbackでindexのみ渡して具体的なロジックはDescFormAndButtonで
              onPressed: () => widget.deleteList(widget.index),
            )
                :Container(),
          ],
        );
        break;
      case DisplayList.way2Merit:
        return Stack(
          //material
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'メリットを入力してください',
                ///TextFieldを長く入力するとボタンが重なるのを回避
                contentPadding: EdgeInsets.fromLTRB(6, 6, 48, 0),
              ),
              controller: widget.controllers[widget.index],
              onChanged: (newDesc) => widget.inputChanged(newDesc),
              style: const TextStyle(color: Colors.black),
              ///TextFieldを長く入力すると折り返し
              maxLines: null,
              focusNode: widget.focusNode,
            ),
            //todo ボタンをフォーカス時のみ出す、初回時、way1Meritとway2Meritをまたぐ時ボタンでない
            //_focusNode.hasFocusで最初IconButton出ない、閉じると出る=>初期設定おかしい
            //ListViewのcontrollersの中をfocus中に移動すると最初のfocus時しかIconButton出ない=>focusNodeをListView.builderの中でindexとともに設定=>DescFormのインスタンスに渡す
            //focus中に移動するとtrue=>false=>trueとなって結局消えない、移動した時にfocusNodeをfalseにするには？
            //初回 isDisplayIconをviewModelにもたせる、2回目以降hasFocus


            //todo displayListで場合わけしたい
            viewModel.isWay2MeritDeleteIcon
                ? IconButton(
                    icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.grey,
                    size: 24,
              ),
              //ここではvoidCallbackでindexのみ渡して具体的なロジックはDescFormAndButtonで
              onPressed: () => widget.deleteList(widget.index),
            )
                :Container(),
          ],
        );
        break;
    }



  }
}
