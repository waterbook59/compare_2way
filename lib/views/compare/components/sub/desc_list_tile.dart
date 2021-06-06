import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DescListTile extends StatelessWidget {
  const DescListTile({
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
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    //todo way1,2,3Merit,Demerit分作成
    //todo ListTile同士の間隔空きすぎ
    switch (displayList) {
      case DisplayList.way1Merit:
        return
        ListTile(
          dense: true,
          title: viewModel.selectedDescListIndex == index &&
              viewModel.isWay1MeritFocusList
              ? DescForm(
            inputChanged: inputChanged,
            controllers: controllers,
            index: index,
            deleteList: deleteList,
            focusNode: focusNode,
            displayList: displayList,
          )
              : controllers[index].text.isNotEmpty
              ? Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Text('${controllers[index].text}'))
              :  Container(
              decoration:const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child:  const
              Text('メリットを入力', style: TextStyle(color: Colors.grey),)),
        );
        break;
      case DisplayList.way2Merit:
        return
        ListTile(
          title:           viewModel.selectedDescListIndex == index &&
              viewModel.isWay2MeritFocusList
              ? DescForm(
            inputChanged: inputChanged,
            controllers: controllers,
            index: index,
            deleteList: deleteList,
            focusNode: focusNode,
            displayList: displayList,
          )
              : controllers[index].text.isNotEmpty
              ? Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Text('${controllers[index].text}'))
              : Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Text('メリットを入力', style: TextStyle(color: Colors.grey),)),
        );
        break;
    }
  }
}

