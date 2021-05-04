import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({this.onSubmitted, this.tagList,
//    this.displayChipList,
  });
  final ValueChanged<List<String>> onSubmitted;
  final List<Tag> tagList;
//  final List<Chip> displayChipList;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  var _tagNameList =<String>[];
  final _tempoLabels = <String>[];
  Set<String>  tagNameListSet= <String>{};
  int value;

  @override
  void initState() {
  ///List<Tag>=>Set<String>とList<String>へ変換
    //型推論に失敗する時はmapの後ろに型を明示
    tagNameListSet =widget.tagList.map<String>(
      (tag)=>tag.tagTitle).toSet() ;//toListではなく、toSetに変更で一気に変換
    print('TagChips/initState/tagTitles(Set):$tagNameListSet');
    _tagNameList  = tagNameListSet.toList();

    ///_tempoChipsのList<ChoiceChip>への変換はinitState内ではなく、Wrap内で行わないと
    ///selectedが反映されない
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Wrap(
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
            ///_tempoChipsのList<InputChip>への変換はinitState内ではなく、Wrap内で行わないと
            ///selectedが反映されない、tagNameListからつくることでtempoChipsいらない
            List<InputChip>.generate(
                _tagNameList.length, (int index) {
              return InputChip(
                label: Text(_tagNameList[index]),
                selected: value == index,//bool
                selectedColor:  Colors.blue[100],
                //デフォルトの選択時のチェックマーク消す
                showCheckmark: false,
                //選択時だけdeleteIconがでる
                onDeleted: value == index ?(){}:null,
                deleteIcon: const Icon(Icons.highlight_off),
                onSelected: (bool isSelected){
                  setState(() {
                    //選択する(isSelected=trueのとき、value = index)
                    value = isSelected ? index :0 ;
                    print('choicechip/value:$value/isSelected:$isSelected');
                  });
                },

              );
            }).toList(),),

              TagInputChip(
                onSubmitted: (input){
                  ///inputが既存の仮tagクラス内またはDB内に存在しないのかvalidation
                  //todo スペースは登録されないようvalidation
                  ///リスト内に重複がないかのvalidation
                  //まずは入力値を文字リストに入れる
                  _tempoLabels.add(input);
                  //set型に変換しないと重複削除できないので、toSet
                  final tempoLabelSet =_tempoLabels.toSet();
                  //addAllで重複削除：_tagNameList内にinputあるかどうか
                  tagNameListSet.addAll(tempoLabelSet);
                  //Listへ戻す
                  _tagNameList = tagNameListSet.toList();
                  print('_chipLabels.addAll$_tagNameList');

                  //tag_dialog_pageへタグタイトルのリスト上げる
                    widget.onSubmitted(_tagNameList);

                  setState(() {//tag_input_chipのcontroller破棄
                  },);
                }),
    ],
  );
  }

}

