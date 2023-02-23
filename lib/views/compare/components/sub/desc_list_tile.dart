import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_display.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DescListTile extends StatelessWidget {
  const DescListTile({
    required this.inputChanged,
    required this.index,
    required this.controllers,
    required this.deleteList,
    required this.focusNode,
    required this.displayList,
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

    switch (displayList) {
      case DisplayList.way1Merit:
        return viewModel.selectedDescListIndex == index &&
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
                ? DescDisplay(
                    description: controllers[index].text,
                    //todo 文字色blac12で良いか確認
                    textColor: Colors.black12,
                  )
                : const DescDisplay(
                    description: 'メリットを入力',
                    textColor: Colors.grey,
                  );
        break;
      case DisplayList.way2Merit:
        return viewModel.selectedDescListIndex == index &&
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
                ? DescDisplay(
                    description: controllers[index].text,
                    textColor: Colors.black12,
                  )
                : const DescDisplay(
                    description: 'メリットを入力',
                    textColor: Colors.grey,
                  );
        break;
      case DisplayList.way1Demerit:
        return viewModel.selectedDescListIndex == index &&
                viewModel.isWay1DemeritFocusList
            ? DescForm(
                inputChanged: inputChanged,
                controllers: controllers,
                index: index,
                deleteList: deleteList,
                focusNode: focusNode,
                displayList: displayList,
              )
            : controllers[index].text.isNotEmpty
                ? DescDisplay(
                    description: controllers[index].text,
                    textColor: Colors.black12,
                  )
                : const DescDisplay(
                    description: 'デメリットを入力',
                    textColor: Colors.grey,
                  );
        break;
      case DisplayList.way2Demerit:
        return viewModel.selectedDescListIndex == index &&
                viewModel.isWay2DemeritFocusList
            ? DescForm(
                inputChanged: inputChanged,
                controllers: controllers,
                index: index,
                deleteList: deleteList,
                focusNode: focusNode,
                displayList: displayList,
              )
            : controllers[index].text.isNotEmpty
                ? DescDisplay(
                    description: controllers[index].text,
                    textColor: Colors.black12,
                  )
                : const DescDisplay(
                    description: 'デメリットを入力',
                    textColor: Colors.grey,
                  );
        break;
      //todo way3Merit,Demerit分作成
      case DisplayList.way3Merit:
        return Container();
      case DisplayList.way3Demerit:
        return Container();
    }
  }
}
