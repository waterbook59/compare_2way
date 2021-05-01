import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({this.onSubmitted,this.tagList,this.displayChipList});
  final ValueChanged<List<String>> onSubmitted;
  final List<Tag> tagList;
  final List<Chip> displayChipList;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  var  _tempoChips =<Chip>[];
  var _tagNameList =<String>[];
  final _tempoLabels = <String>[];
  Set<String>  tagNameListSet= <String>{};
  final _temporaryTags = <Tag>[];

  @override
  void initState() {
  //List<Tag>=>List<String>=>Set<String>へ変換したい
    //型推論に失敗する時はmapの後ろに型を明示
    tagNameListSet =widget.tagList.map<String>(
      (tag)=>tag.tagTitle).toSet() ;//toListではなく、toSetに変更で一気に変換
    print('TagInputChip/initState/tagTitles:$_tagNameList');

  //List<Chip>=>Set<String>へ変換したい
//  final setTest =  widget.displayChipList.map<Widget>((chip)
//  => chip.label).toSet();
//    set1= setTest ;

    _tempoChips = widget.displayChipList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Row[tagChipList,TagInputChip]
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
            children:_tempoChips,),

              TagInputChip(
                onSubmitted: (input){
                  //todo inputが既存の仮tagクラス内またはDB内に存在しないのかvalidation
                  //todo スペースは登録されないようvalidation
                  //DBのvalidationはmy_own_flash_card参考
                  // validation問題なければ仮Chipクラス(_tempoChips)へ格納
                  //_tagNameList内にinputあるかどうか

                  ///リスト内に重複がないかのvalidation
                  //まずは入力値を文字リストに入れる
                  //set型に変換しないと重複削除できないので、toSet
                  _tempoLabels.add(input);

                  //list.toSet().toList();だけではできなかった
//                  final set1 = _chipLabels.toSet();
//                  final  set1 = widget.displayChipList.map((chip)
//                  => chip.label).toSet() as Set<String>;

                  final tempoLabelSet =_tempoLabels.toSet();
                  //addAllで重複削除
                  tagNameListSet.addAll(tempoLabelSet);
                  //Listへ戻す
                  _tagNameList = tagNameListSet.toList();
                  print('_chipLabels.addAll$_tagNameList');
//TagDialogPage表示用チップリスト(完了前)List<Chip>を上記で重複を整理したchipLabelsを元に作成
                  _tempoChips=
                      _tagNameList.map((value) {
                      return Chip(label: Text(value));
                    }).toList();
                  //tag_dialog_pageへタグタイトルのリスト上げる
                    widget.onSubmitted(_tagNameList);


//                _chipLabels.forEach((name) {
//                  if(input.contains(name)){
//                    print('inputとnameが同じ：$nameと$input');
//                    //同じ場合はリスト追加できないようにする
//                    return;
//                  }else{
//                    print('inputとnameが違う：$nameと$input');
//                    //違う場合はリスト追加する
//                    print('tagChipsリスト追加前:$_chipLabels');
//                    _chipLabels.add(input);
//                    print('tagChipsリスト追加後:$_chipLabels');
//                  }
//                  ///chipsリストへ追加
//                  final inputChip = Chip(label: Text(input),);
//                  _testChips.add(inputChip);
//                  //tag_dialog_pageへタグタイトルのリスト上げる
////                    widget.onSubmitted(_chipLabels);
//                  });
//print('tagChipsリスト追加後:${_chipLabels.map((name) => print).toList()}');
//                    final temporaryTagList = Tag(
//                      tagTitle: input,
//                    );
                  setState(() {//tag_input_chipのcontroller破棄
                  },);
                }),
//        ],
//      ),
    ],
  );
  }
}

