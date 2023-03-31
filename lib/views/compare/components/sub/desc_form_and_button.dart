import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescFormAndButton extends StatefulWidget {
  const DescFormAndButton({Key? key,
    required this.displayList,
    this.way1MeritList,
    this.way2MeritList,
    this.way1DemeritList,
    this.way2DemeritList,
    // //todo
//    this.way3MeritList,
//    this.way3DemeritList,
    required this.inputChanged,
    required this.addList,
    required this.deleteList,
    required this.controllers,
    required this.focusNodes,
  }) : super(key: key);

  final DisplayList displayList;
  final List<Way1Merit>? way1MeritList;
  final List<Way2Merit>? way2MeritList;
  final List<Way1Demerit>? way1DemeritList;
  final List<Way2Demerit>? way2DemeritList;
  final Function(String, int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  @override
  // _DescFormAndButtonState createState() => _DescFormAndButtonState();
  State<DescFormAndButton> createState() => _DescFormAndButtonState();
}

class _DescFormAndButtonState extends State<DescFormAndButton> {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);


    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.controllers.length,
            itemBuilder: (context, index) {
              return
                  ///way1とway2等リストまたぐと反応しない=>Consumerに変更してAccordionPart以下を再ビルド
                  GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.selectedDescListIndex = index;
                    debugPrint('viewModel.selectedIndex:'
                        '${viewModel.selectedDescListIndex}');
                    widget.focusNodes[index].requestFocus();
                    //isDisplayIconをviewModelにもたせる
                    // //todo way3Merit,Demerit分作成
                    switch (widget.displayList) {
                      case DisplayList.way1Merit:
                        viewModel.focusWay1MeritList();
                        break;
                      case DisplayList.way2Merit:
                        viewModel.focusWay2MeritList();
                        break;
                      case DisplayList.way1Demerit:
                        viewModel.focusWay1DemeritList();
                        break;
                      case DisplayList.way2Demerit:
                        viewModel.focusWay2DemeritList();
                        break;

                      case DisplayList.way3Merit:
                      // //todo
                        break;
                      case DisplayList.way3Demerit:
                      // //todo
                        break;
                    }

                    debugPrint('DescFormAndButton/Listの１つをonTap!');
                  });
                },
                child: DescListTile(
                  inputChanged: (newDesc) =>
                      widget.inputChanged(newDesc, index),
                  controllers: widget.controllers,
                  index: index,
                  deleteList: (deleteIndex) =>
                      _deleteList(context, deleteIndex),
                  focusNode: widget.focusNodes[index],
                  displayList: widget.displayList,
                ),
              );
            },),

      ],
    );
  }

  // //todo リストが1の時だけdeleteIcon出さない
  //deleteするときのキーボード立ち上がりをふせぐ
  void _deleteList(BuildContext context, int deleteIndex) {
//    print(
//        'DescFormAndButton/removeOnTapした瞬間のcontrollers.length:${controllers.length}'
//        '/onTapしたindex$deleteIndex');

    //リストを0にしない
    if (widget.controllers.length > 1) {
      setState(() {
        widget.controllers.removeAt(deleteIndex);
        widget.focusNodes.removeAt(deleteIndex);
        widget.deleteList(deleteIndex);
        debugPrint('DescForm削除setState時のcontrollers.length:'
            '${widget.controllers.length}');
      });
    }
  }


}
