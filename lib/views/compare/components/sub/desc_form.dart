import 'dart:ui';

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


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

//todo way3Merit,Demerit追加
    switch(widget.displayList){
      case DisplayList.way1Merit:
        return Stack(
          //material
          alignment: Alignment.centerRight,
          children: [
//            TextFormField(
//              decoration: const InputDecoration(
//                hintText: 'メリットを入力してください',
//                ///TextFieldを長く入力するとボタンが重なるのを回避
//                contentPadding: EdgeInsets.fromLTRB(6, 6, 48, 0),
////InputDecoration/isDense:trueで幅狭くなる
////            isDense: true,
//              ),
//              controller: widget.controllers[widget.index],
//              onChanged: (newDesc) => widget.inputChanged(newDesc),
//              style: const TextStyle(color: Colors.black),
//              ///TextFieldを長く入力すると折り返し
//              maxLines: null,
//              focusNode: widget.focusNode,
//            ),
            CupertinoTextField(
              controller: widget.controllers[widget.index],
              onChanged: (newDesc) => widget.inputChanged(newDesc),
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              suffix: const SizedBox(width: 24,),//IconButton分(24)隙間あける
              focusNode: widget.focusNode,
              placeholder: 'メリットを入力',
              decoration:
              const BoxDecoration(
                  border: Border(bottom:BorderSide(color: Colors.grey)),
                  ),
//              clearButtonMode: OverlayVisibilityMode.editing,
//            selectionHeightStyle: BoxHeightStyle.includeLineSpacingBottom,
            ),

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
      case DisplayList.way1Demerit:
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            CupertinoTextField(
              controller: widget.controllers[widget.index],
              onChanged: (newDesc) => widget.inputChanged(newDesc),
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              suffix: const SizedBox(width: 24,),//IconButton分(24)隙間あける
              focusNode: widget.focusNode,
              placeholder: 'メリットを入力',
              decoration:
              const BoxDecoration(
                border: Border(bottom:BorderSide(color: Colors.grey)),
              ),
            ),

            viewModel.isWay1DemeritDeleteIcon
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
      case DisplayList.way2Demerit:
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            CupertinoTextField(
              controller: widget.controllers[widget.index],
              onChanged: (newDesc) => widget.inputChanged(newDesc),
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              suffix: const SizedBox(width: 24,),//IconButton分(24)隙間あける
              focusNode: widget.focusNode,
              placeholder: 'メリットを入力',
              decoration:
              const BoxDecoration(
                border: Border(bottom:BorderSide(color: Colors.grey)),
              ),
            ),

            viewModel.isWay2DemeritDeleteIcon
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
    }



  }
}
