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

  //todo _tempoChipsは押した時に削除できるようにChip=>InputChip(透明になってしまう)
  var  _tempoChips =<ChoiceChip>[];
  var _tagNameList =<String>[];
  final _tempoLabels = <String>[];
  Set<String>  tagNameListSet= <String>{};
  final _temporaryTags = <Tag>[];
  bool _isInputChipSelected = false;
  int value;

  @override
  void initState() {
  ///List<Tag>=>List<String>=>Set<String>へ変換したい
    //型推論に失敗する時はmapの後ろに型を明示
    tagNameListSet =widget.tagList.map<String>(
      (tag)=>tag.tagTitle).toSet() ;//toListではなく、toSetに変更で一気に変換
    print('TagChips/initState/tagTitles(Set):$tagNameListSet');
    _tagNameList  = tagNameListSet.toList();

    ///_tempoChipsのList<ChoiceChip>への変換はinitState内ではなく、Wrap内で行わないと
    ///selectedが反映されない
    //mapではなく、List.generateへ変更(news_feed参照)
//    _tempoChips = widget.displayChipList.map((chip) {
//      return ChoiceChip(
//        label: chip.label,
//        selected: _isInputChipSelected,
//        selectedColor: Colors.blue,
//        onSelected: (selected){
//          setState(() {
//            _isInputChipSelected =selected;
//            print('inputChip/_isInputChipSelected:$_isInputChipSelected');
//          });
//        },
////        deleteIcon: const Icon(Icons.highlight_off),
////        onPressed: (){
////          setState(() {
////            _selected = !_selected;
////            print('inputChip/selected:$_selected');
////          });
////        },
////        backgroundColor: Colors.transparent,
//
////        onDeleted: (){},
//      );
//    }).toList();


//    _tempoChips = List<ChoiceChip>.generate(
//        widget.displayChipList.length, (int index) {
//      return ChoiceChip(
//        label: widget.displayChipList[index].label,
//        selected: value == index,//bool
//        selectedColor: Colors.blue,
//        onSelected: (bool isSelected){
//
//            setState(() {
//              //選択する(isSelected=trueのとき、value = index)
//              value = isSelected ? index :0 ;
//              print('choicechip/value:$value/isSelected:$isSelected');
//              onChoiceChipSelected(value);
//            });
//        },
//
//      );
//    }).toList();
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
            children:
            ///_tempoChipsのList<ChoiceChip>への変換はinitState内ではなく、Wrap内で行わないと
            ///selectedが反映されない
            List<ChoiceChip>.generate(
                _tagNameList.length, (int index) {
              return ChoiceChip(
                label: Text(_tagNameList[index]),
                selected: value == index,//bool
                selectedColor: Colors.blue,
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
//TagDialogPage表示用チップリスト(完了前)List<Chip>を上記で重複を整理したchipLabelsを元に作成
                  // validation問題なければ仮Chipクラス(_tempoChips)へ格納
                  // tempoChipsをmapではなくList.generateに変更
                  _tempoChips=
//                      _tagNameList.map((value) {
//                      return ChoiceChip(
//                          label: Text(value),
//                          selected: _isInputChipSelected,
//                          onSelected: (selected){
//    setState(() {
//    _isInputChipSelected =selected;
//    });
//    },
//                          backgroundColor: Colors.transparent,
//                          selectedColor: Colors.blue,
////                          deleteIcon: const Icon(Icons.highlight_off),
////                          onDeleted: (){},
////                          onPressed: (){
////                            setState(() {
////                              _selected = !_selected;
////                            });
////                          },
//                      );
//                    }).toList();

                  List<ChoiceChip>.generate(_tagNameList.length, (index) {
                    return ChoiceChip(
                      label: Text(_tagNameList[index]),
                      selected: value == index,//bool
                      onSelected: (bool isSelected){
                        setState(() {
                          //選択する(isSelected=trueのとき、value = index)
                          value = isSelected ? index :0 ;
                          print('choicechip/value:$value/isSelected:$isSelected');
                        });
                      },
                    );
                  }).toList();
                  //tag_dialog_pageへタグタイトルのリスト上げる
                    widget.onSubmitted(_tagNameList);

                  setState(() {//tag_input_chipのcontroller破棄
                  },);
                }),
    ],
  );
  }

}

