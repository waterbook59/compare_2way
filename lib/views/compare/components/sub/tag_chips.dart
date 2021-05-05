import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({
    this.tagList,
    this.onSubmitted,
    this.onDeleted,
  });
  final List<Tag> tagList;
  final ValueChanged<List<String>> onSubmitted;
  final ValueChanged<List<String>> onDeleted;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  List<String> _tagNameList =<String>[];
  List<String> _tempoLabels = <String>[];
  List<String> _tempoDeleteLabels =<String>[];
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
            ///List<InputChip>への変換はinitState内ではなく、Wrap内で行わないとselectedが反映されない
            ///tagNameListからつくることでtempoChipsいらない
            //todo 長すぎるチップでも全部見えるようにする
            List<InputChip>.generate(
                _tagNameList.length, (int index) {
              return InputChip(
                label: Text(_tagNameList[index]),
                selected: value == index,//bool
                selectedColor:  Colors.blue[100],
                //デフォルトの選択時のチェックマーク消す
                showCheckmark: false,
                //選択時だけdeleteIconがでる
                onDeleted: value == index
                ///仮でtagNameListから選択したindex番目タイトル削除
                    ?()=> setState(() {
                  _tempoDeleteLabels.add(_tagNameList[index]);
                  print('チップ削除後_tempoDeleteLabels:$_tempoDeleteLabels');
                    _tagNameList.removeAt(index);
                    print('チップ削除後_tagNameList:$_tagNameList');
                    tagNameListSet = _tagNameList.toSet();
                    widget.onDeleted(_tempoDeleteLabels);
                  //tempoDeleteLabelsクリア(しないとviewModelのDeleteLabelsに重複して登録されていく)
                    _tempoDeleteLabels = [];

                  })
                    :null,
                deleteIcon: const Icon(Icons.highlight_off),
                onSelected: (bool isSelected){
                  setState(() {
                    //選択する(isSelected=trueのとき、value = index)
                    value = isSelected ? index :0 ;
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
                  //tempoLabelsクリア(しないと編集中に消したものが再度出てくる)
                  _tempoLabels =[];
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

