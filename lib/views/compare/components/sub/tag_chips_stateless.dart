import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/select_chip.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagChipsStateless extends StatelessWidget {

  const TagChipsStateless({
    this.tempoSelectList,
    this.onSubmitted,
    this.onDeleted,});

  final List< String> tempoSelectList;
//  final ValueChanged<List<String>> onSubmitted;
//  final VoidCallback onSubmitted;
  final ValueChanged<String> onSubmitted;
//  final ValueChanged<List<String>> onDeleted;
  final ValueChanged<int> onDeleted;



  @override
  Widget build(BuildContext context) {
    var _tempoLabels = <String>[];
//    var  tagNameListSet= <String>{};




    int value;

    return  Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 8,
      runSpacing: 0,
      children:
      [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 0,
          direction: Axis.horizontal,
          children:
          ///List<InputChip>への変換はinitState内ではなく、Wrap内で行わないとselectedが反映されない
          ///todo ここだけでも分割してstatefulできないか??deleteIconを出す出さない複雑そう
          //todo 長すぎるチップでも全部見えるようにする
          List<SelectChip>.generate(
              tempoSelectList.length, (int index) {
            return SelectChip(
              //ここでの表示は仮リスト、正式にはtagDialogPageの完了ボタンでList<Tag>,tagNameList(DB登録済みのNameList)
              displayTagNameList: tempoSelectList,
              index: index,
              onDeleted: ()=>onDeleted(index),
            );
//              InputChip(
//              label: Text(viewModel.tagNameList[index]),
//              selected: value == index,//bool
//              selectedColor:  Colors.blue[100],
//              //デフォルトの選択時のチェックマーク消す
//              showCheckmark: false,
//              //選択時だけdeleteIconがでる
//              onDeleted: value == index
//              ///仮でtagNameListから選択したindex番目タイトル削除
//                  ?()=>{
//                _tempoDeleteLabels.add(viewModel.tagNameList[index]);
//                print('チップ削除後_tempoDeleteLabels:$_tempoDeleteLabels');
//                viewModel.tagNameList.removeAt(index);
//                print('チップ削除後_tagNameList:${viewModel.tagNameList}');
//                tagNameListSet = viewModel.tagNameList.toSet();
//                onDeleted(_tempoDeleteLabels);
//                //tempoDeleteLabelsクリア(しないとviewModelのDeleteLabelsに重複して登録されていく)
//                _tempoDeleteLabels = [];
//
//              }
//                  :null,
//              deleteIcon: const Icon(Icons.highlight_off),
//              onSelected: (bool isSelected){
//
//                  //選択する(isSelected=trueのとき、value = index)
//                  value = isSelected ? index :0 ;
//
//              },
//            );
          }).toList(),
        ),

        TagInputChip(
          //input内容が既存の仮tagクラス内またはDB内に存在しないのかvalidationした後、tempoSelectList登録
            onSubmitted:(input) {
              print('TagInputChip/input内容:$input');
              onSubmitted(input);
            }
    ),
//                (input){
//              viewModel.inputTagName(input);
//            }),
    ],
    );
    }
  }