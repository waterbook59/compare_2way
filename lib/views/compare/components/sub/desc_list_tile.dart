import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_display.dart';
import 'package:compare_2way/views/compare/components/sub/desc_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescListTile extends StatelessWidget {
  const DescListTile({Key? key,
    required this.inputChanged,
    required this.index,
    required this.controllers,
    required this.deleteList,
    required this.focusNode,
    required this.displayList,
  }) : super(key: key);

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
                    textColor: Colors.black87,
                  )
                : const DescDisplay(
                    description: 'メリットを入力',
                    textColor: Colors.grey,
                  );
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
                    textColor: Colors.black87,
                  )
                : const DescDisplay(
                    description: 'メリットを入力',
                    textColor: Colors.grey,
                  );
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
                    textColor: Colors.black87,
                  )
                : const DescDisplay(
                    description: 'デメリットを入力',
                    textColor: Colors.grey,
                  );
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
                    textColor: Colors.black87,
                  )
                : const DescDisplay(
                    description: 'デメリットを入力',
                    textColor: Colors.grey,
                  );
      //todo way3Merit,Demerit分作成
      case DisplayList.way3Merit:
        return Container();
      case DisplayList.way3Demerit:
        return Container();
    }
  }
}
