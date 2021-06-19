import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SelectChip extends StatefulWidget {

  const SelectChip({
    this.displayTagNameList,//viewModel.tempoSelectListのこと
    this.index,
    this.onDeleted,

  });

  final List<String> displayTagNameList;
  final int index;
//  final ValueChanged<List<String>> onDeleted;
  final VoidCallback onDeleted;

  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {

  int value;
  List<String> _tempoDeleteLabels =<String>[];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return InputChip(
      label: Text(widget.displayTagNameList[widget.index]),
      selected: value == widget.index,//bool
      selectedColor:  Colors.blue[100],
      //デフォルトの選択時のチェックマーク消す
      showCheckmark: false,
      //選択時だけdeleteIconがでる
      onDeleted: value == widget.index
      ///tempoDeleteLabelsにtagNameListから選択したindex番目タイトル削除タグを追加
          ?(){
        widget.onDeleted();
        //todo setStateするとエラー
        setState(() {
        });
      }
//          viewModel.onDeleteSelectChip(widget.index)

//          setState(() {
//        _tempoDeleteLabels.add(widget.displayTagNameList[widget.index]);
//        print('チップ削除後_tempoDeleteLabels:$_tempoDeleteLabels');
//        widget.displayTagNameList.removeAt(widget.index);
//        print('チップ削除後widget.tempoTagNameList:${widget.displayTagNameList}');
//        tempoTagNameListSet = widget.tempoTagNameList.toSet();
//        widget.onDeleted(_tempoDeleteLabels);
        //tempoDeleteLabelsクリア(しないとviewModelのDeleteLabelsに重複して登録されていく)
//        _tempoDeleteLabels = [];

//      })
          :null,
      deleteIcon: const Icon(Icons.highlight_off),
      onSelected: (bool isSelected){
        setState(() {
          //選択する(isSelected=trueのとき、value = index)
          value = isSelected ? widget.index :0 ;
        });
      },
    );
  }
}
