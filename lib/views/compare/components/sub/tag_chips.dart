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
    this.setTempoInput,
  });
  final List<String> tagNameList;//DBからのtagTitleのリスト
  final ValueChanged<List<String>> onSubmitted;
  final ValueChanged<List<String>> onDeleted;
  final String addTagTitle;
  final List<String> candidateTagNameList;
  final ValueChanged<String> setTempoInput;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  List<String> _tempoDisplayList =<String>[];//メインとなる選択タグの表示用リスト
  Set<String>  tagNameListSet= <String>{};//DBからのtagTitleのリストのset型(削除時等加工用)
  List<String> _tempoLabels = <String>[];
  List<String> _tempoDeleteLabels =<String>[];
  List<String> _tempoCandidateLabels = <String>[];

  int value;
  bool isCandidate;
  bool isFocus = false;

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
    // ignore: lines_longer_than_80_chars
    //candidateTagNameListから選択したもの消したいので、widget.candidateTagNameList=>_tempoCandidateLabelsへinitStateで変換
    _tempoCandidateLabels = widget.candidateTagNameList;

    print('tagChips/initState/tagNameListSet:$tagNameListSet, candidateTagNameList:${widget.candidateTagNameList}' );

    super.initState();
  }

  @override
  void dispose() {
    _tempoCandidateLabels = [];
    print('tagChips/dispose_tempoCandidateLabels:$_tempoCandidateLabels');
    super.dispose();
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
                      /// 削除ボタン押したらcandidateTagに追加(再度候補タグとして表示)
                      _tempoCandidateLabels.add(_tempoDisplayList[index]);
                      _tempoDeleteLabels.add(_tempoDisplayList[index]);
                      print('チップ削除後_tempoDeleteLabels:$_tempoDeleteLabels');
                      _tempoDisplayList.removeAt(index);
                        print('チップ削除後_tempoDisplayList:$_tempoDisplayList');
                      // ignore: lines_longer_than_80_chars
                      //DB由来のタイトルから削除タイトル抜かないと1回削除して再度TagInputChipで同じものを入力しようとしても重複タグ扱いになって登録されない
                        tagNameListSet = _tempoDisplayList.toSet();
                      print('InputChip/onDeleted/tagNameListSet:$tagNameListSet');
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

                  // ignore: lines_longer_than_80_chars
                  //input追加時はDB由来のtagNameListと重複したタグが作られないようvalidationして表示リスト全てをviewModelへ格納
                  TagInputChip(
                    //tagInputChipのautoFocus外して入力モードになったら+create'...'ボタン出す
                    onFocusChange: (focus){
                      setState(() {
                        isFocus = focus.hasFocus;
                      });
                    },
                    setTempoInput: (tempoInput){
                      widget.setTempoInput(tempoInput);
                    },
                    onSubmitted: (input){
                      ///inputが既存の仮tagクラス内またはDB内に存在しないのかvalidation
                      //入力なしは登録されないようvalidation(input =''の時登録なし)
                      if(input == ''){
                      }else{
                        ///tagNameList内に重複がないかのvalidation
                        //まずは入力値を文字リストに入れる
                        _tempoLabels.add(input);
                        //set型に変換しないと重複削除できないので、toSet
                        final tempoLabelSet =_tempoLabels.toSet();
                        //addAllで重複削除：_tagNameList内にinputあるかどうか
                        tagNameListSet.addAll(tempoLabelSet);
                        /// _tempoCandidateLabels内にinput要素があれば削除
                        if( _tempoCandidateLabels.contains(input)){
                          _tempoCandidateLabels.remove(input);
                        }
                        //tempoLabelsクリア(しないと編集中に消したものが再度出てくる)
                        _tempoLabels =[];
                        //Listへ戻す
                        _tempoDisplayList = tagNameListSet.toList();
                        print('InputChip/TagInputChip/onSubmitted/_tempoDisplayList:$_tempoDisplayList');
                        print('InputChip/TagInputChip/onSubmitted/tagNameListSet:$tagNameListSet');
                        //tag_dialog_pageへタグタイトルのリスト上げてviewModelに格納
                        widget.onSubmitted(_tempoDisplayList);
                      }

                      setState(() {//tag_input_chipのcontroller破棄
                      },);
                    }),
        ],
      ),
      const Divider(color: Colors.black,),
      isFocus
      //input入力時
      ?const Text('+createTag表示')
      : isCandidate
    ? ListView.builder(
    shrinkWrap: true,
    //リストが縦方向にスクロールできるようになる
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _tempoCandidateLabels.length,
    itemBuilder: (BuildContext context, int index) {
    final tagTitle= _tempoCandidateLabels[index];
    ///ListTileのスペースがいまいちなのでDescDisplay参照
    return CandidateTag(
    title: tagTitle,
    onTap: (title){
      setState(() {
        // ignore: lines_longer_than_80_chars
        // _tempoDisplayList内に重複がないかのvalidation(既にinputChipで同じもの入力してたら重複入力できないように)は、inputChip入力時に重複タグタイトルを候補タグから削除しているので必要なし
        _tempoDisplayList.add(title);
        _tempoCandidateLabels.removeAt(index);
        //tag_dialog_pageへタグタイトルのリスト上げてviewModelに格納
        widget.onSubmitted(_tempoDisplayList);
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

