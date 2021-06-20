import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/views/compare/components/sub/candidate_tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({
    this.tagNameList,
    this.onSubmitted,
    this.onDeleted,
    this.addTagTitle,
    this.candidateTagNameList,
  });
  final List<String> tagNameList;
  final ValueChanged<List<String>> onSubmitted;
  final ValueChanged<List<String>> onDeleted;
  final String addTagTitle;
  final List<String> candidateTagNameList;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  List<String> _tempoDisplayList =<String>[];//DBからのtagTitleのリスト
  Set<String>  tagNameListSet= <String>{};
  List<String> _tempoLabels = <String>[];
  List<String> _tempoDeleteLabels =<String>[];
  List<String> _tempoCandidateLabels = <String>[];

  int value;
  bool isCandidate;

  @override
  void initState() {
  ///List<Tag>=>Set<String>とList<String>へ変換
    //型推論に失敗する時はmapの後ろに型を明示
    tagNameListSet =widget.tagNameList.map<String>(
      (tagTitle)=>tagTitle).toSet() ;//toListではなく、toSetに変更で一気に変換
    print('TagChips/initState/tagTitles(Set):$tagNameListSet');
    _tempoDisplayList  = tagNameListSet.toList();

if(widget.candidateTagNameList.isEmpty||widget.candidateTagNameList==null){
  isCandidate =false;
}else{
  isCandidate = true;
}

    _tempoCandidateLabels = widget.candidateTagNameList;

    print('tagChips/tagNameList:$tagNameListSet, candidateTagNameList:$_tempoCandidateLabels' );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
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
                    _tempoDisplayList.length, (int index) {
                  return InputChip(
                    label: Text(_tempoDisplayList[index]),
                    selected: value == index,//bool
                    selectedColor:  Colors.blue[100],
                    //デフォルトの選択時のチェックマーク消す
                    showCheckmark: false,
                    //選択時だけdeleteIconがでる
                    onDeleted: value == index
                    ///仮でtagNameListから選択したindex番目タイトル削除
                        ?()=> setState(() {
                      _tempoDeleteLabels.add(_tempoDisplayList[index]);
                      print('チップ削除後_tempoDeleteLabels:$_tempoDeleteLabels');
                      _tempoDisplayList.removeAt(index);
                        print('チップ削除後_tagNameList:$_tempoDisplayList');
                        tagNameListSet = _tempoDisplayList.toSet();
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
                      _tempoDisplayList = tagNameListSet.toList();
                      print('_chipLabels.addAll$_tempoDisplayList');

                      //tag_dialog_pageへタグタイトルのリスト上げる
                        widget.onSubmitted(_tempoDisplayList);

                      setState(() {//tag_input_chipのcontroller破棄
                      },);
                    }),
        ],
      ),
      const Divider(color: Colors.black,),
      isCandidate
    ? ListView.builder(
    shrinkWrap: true,
    //リストが縦方向にスクロールできるようになる
    physics: const NeverScrollableScrollPhysics(),
//                  separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey,),
    itemCount: _tempoCandidateLabels.length,
    itemBuilder: (BuildContext context, int index) {
    final tagTitle= _tempoCandidateLabels[index];
    ///ListTileのスペースがいまいちなのでDescDisplay参照
    return CandidateTag(
    title: tagTitle,
//                        createdAt: '登録時間',
    onTap: (title){
      setState(() {
        _tempoDisplayList.add(title);
        //candidateTagNameListから選択したもの消したいので、widget.candidateTagNameList=>_tempoCandidateLabelsへinitStateで変換
        _tempoCandidateLabels.removeAt(index);

      });
    },
    listNumber: index,
    );
    },
    )
          :Container(),

    ],
  );
  }

}

