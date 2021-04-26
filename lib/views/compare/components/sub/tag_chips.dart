import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({this.onSubmitted});
  final ValueChanged<List<String>> onSubmitted;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  var  _testChips =<Chip>[Chip(label: Text('青空'),),];
  var _chipLabels =<String>['青空'];
  var _tempoLabels = <String>[];
  final _temporaryTags = <Tag>[];

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
//      Row(
//        children:List<Widget>.generate(_chipLabel.length, (int index){
//          return Chip(label: Text(_chipLabel[index]));
//        }).toList(),
//      ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 0,
            direction: Axis.horizontal,
            children:_testChips,),

              TagInputChip(
                onSubmitted: (input){
                  //todo inputが既存の仮tagクラス内またはDB内に存在しないのかvalidation
                  //DBのvalidationはmy_own_flash_card参考
                  // validation問題なければ保存前の仮tagモデルクラスへ格納
                  //_chipLabels内にinputあるかどうか

                  ///リスト内に重複がないかのvalidation
                  //まずは入力値を文字リストに入れる
                  _tempoLabels.add(input);
                  //set型に変換しないと重複削除できないので、toSet
                  //list.toSet().toList();だけではできなかった
                  final set1 = _chipLabels.toSet();
                  final set2 =_tempoLabels.toSet();
                  //addAllで重複削除
                  set1.addAll(set2);
                  //Listへ戻す
                  _chipLabels = set1.toList();
                  print('_chipLabels.addAll$_chipLabels');
                  //表示用チップリストList<Chip>を上記で重複を整理したchipLabelsを元に作成
                  _testChips=
                    _chipLabels.map((value) {
                      return Chip(label: Text(value));
                    }).toList();
                  //tag_dialog_pageへタグタイトルのリスト上げる
                    widget.onSubmitted(_chipLabels);


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

