import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/desc_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DescFormAndButton extends StatefulWidget {
  const DescFormAndButton({
    this.displayList,
    this.way1MeritList,
    this.way2MeritList,
    this.inputChanged,
    this.addList,
    this.deleteList,
  });

  final DisplayList displayList;
  final List<Way1Merit> way1MeritList;
  final List<Way2Merit> way2MeritList;
  final Function(String, int) inputChanged;
  final Function() addList;
  final Function(int) deleteList;

  @override
  _DescFormAndButtonState createState() => _DescFormAndButtonState();
}

class _DescFormAndButtonState extends State<DescFormAndButton> {
  List<TextEditingController> controllers = <TextEditingController>[];
  List<FocusNode> focusNodes = <FocusNode>[];

//  int _selectedIndex ;

  @override
  void initState() {
    switch (widget.displayList) {
      case DisplayList.way1Merit:
        widget.way1MeritList.isNotEmpty
            ? createWay1MeritList()
//        controllers = widget.way1MeritList.map((item) {
//          return TextEditingController(text: item.way1MeritDesc);
//        }).toList()
            : controllers = [];
        break;
      case DisplayList.way2Merit:
        widget.way2MeritList.isNotEmpty
            ? createWay2MeritList()
//        controllers = widget.way2MeritList.map((item) {
//          return TextEditingController(text: item.way2MeritDesc);
//        }).toList()
            : controllers = [];
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);


    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return
                  //deleteするときのキーボード立ち上がりをふせぐにはStackでボタン独立
                  ///way1とway2等リストまたぐと反応しない=>Consumerに変更してAccordionPart以下を再ビルド
                  GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.selectedDescListIndex = index;
                    print('viewModel.selectedIndex:'
                        '${viewModel.selectedDescListIndex}');
                    focusNodes[index].requestFocus();
                    //isDisplayIconをviewModelにもたせる
                    //todo way1,2,3Merit,Demerit分作成
                    switch (widget.displayList) {
                      case DisplayList.way1Merit:
                        viewModel.focusWay1MeritList();
                        break;
                      case DisplayList.way2Merit:
                        viewModel.focusWay2MeritList();
                    }

                    print('DescFormAndButton/Listの１つをonTap!');
                  });
                },
                child: DescListTile(
                  inputChanged: (newDesc) =>
                      widget.inputChanged(newDesc, index),
                  controllers: controllers,
                  index: index,
                  deleteList: (deleteIndex) =>
                      _deleteList(context, deleteIndex),
                  focusNode: focusNodes[index],
                  displayList: widget.displayList,
                ),
              );
            }),
        RaisedButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              print('押したらリストが増える');
              widget.addList();
              controllers.add(TextEditingController());
              focusNodes.add(FocusNode());
              print(
                  'descFormAndButton/RaisedButton:controllers${controllers.map((controller) => controller.text).toList()}');
            });
          },
        ),
      ],
    );
  }

  //todo リストが1の時だけdeleteIcon出さない
  //deleteするときのキーボード立ち上がりをふせぐ
  void _deleteList(BuildContext context, int deleteIndex) {
    print(
        'DescFormAndButton/removeOnTapした瞬間のcontrollers.length:${controllers.length}'
        '/onTapしたindex$deleteIndex');

    //リストを0にしない
    if (controllers.length > 1) {
      setState(() {
        controllers.removeAt(deleteIndex);
        focusNodes.removeAt(deleteIndex);
        widget.deleteList(deleteIndex);
        print('DescForm削除setState時のcontrollers.length:'
            '${controllers.length}');
      });
    }
  }

  //todo way1,2,3Merit,Demerit分作成
  void createWay1MeritList() {
    controllers = widget.way1MeritList.map((item) {
      return TextEditingController(text: item.way1MeritDesc);
    }).toList();
    focusNodes = widget.way1MeritList.map((item) => FocusNode()).toList();
  }

  void createWay2MeritList() {
    controllers = widget.way2MeritList.map((item) {
      return TextEditingController(text: item.way2MeritDesc);
    }).toList();
    focusNodes = widget.way2MeritList.map((item) => FocusNode()).toList();
  }
}
