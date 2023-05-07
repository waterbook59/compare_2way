import 'package:compare_2way/views/compare/components/sub/candidate_tag.dart';
import 'package:compare_2way/views/compare/components/sub/create_tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';

class TagChips extends StatefulWidget {

  const TagChips({Key? key,
    required this.tagNameList,
    required this.onSubmitted,
    required this.onDeleted,
    // this.addTagTitle,
    required this.candidateTagNameList,
    required this.setTempoInput,
  }) : super(key: key);
  final List<String> tagNameList;//DBからのtagTitleのリスト
  final ValueChanged<List<String>> onSubmitted;
//  final ValueChanged<List<String>,List<String>> onDeleted;
  final Function(List<String>,List<String>) onDeleted;
  // final String addTagTitle;
  final List<String> candidateTagNameList;
  final ValueChanged<String> setTempoInput;

  @override
  State<TagChips> createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  List<String> _tempoDisplayList =<String>[];//メインとなる選択タグの表示用リスト
  Set<String>  tagNameListSet= <String>{};//DBからのtagTitleのリストのset型(削除時等加工用)
  List<String> _tempoLabels = <String>[];
  List<String> _tempoDeleteLabels =<String>[];
  List<String> _tempoCandidateLabels = <String>[];

  int value=0;
  bool isCandidate=false;
  bool isFocus = false;
  String _tempoInput ='';
  bool isInput= false;//TagInputChipの入力表示(true)とActionChip(false)

  @override
  void initState() {
  //List<Tag>=>Set<String>とList<String>へ変換
    //型推論に失敗する時はmapの後ろに型を明示
//     tagNameListSet =widget.tagNameList.map<String>(
//       (tagTitle)=>tagTitle,).toSet() ;//toListではなく、toSetに変更で一気に変換
// //    print('TagChips/initState/tagTitles(Set):$tagNameListSet');
//     _tempoDisplayList  = tagNameListSet.toList();
  ///CompareScreen開くときにgetTagListでviewModel側のtempoDisplayListにはtagNameList格納
    _tempoDisplayList=widget.tagNameList;


    /// //todo view層で場合分けが必要か、viewModel層以下での場合分必要か
if(widget.candidateTagNameList.isEmpty){
  isCandidate =false;
}else{
  isCandidate = true;
}
    // ignore: lines_longer_than_80_chars
    //candidateTagNameListから選択したもの消したいので、widget.candidateTagNameList=>_tempoCandidateLabelsへinitStateで変換
    //TagDialogPageのgetCandidateTagListでviewModelにcandidateTagNameList格納
    _tempoCandidateLabels = widget.candidateTagNameList;

    debugPrint('tagChips/initState/_tempoDisplayList(=tagNameList):'
        '$_tempoDisplayList, _tempoCandidateLabels:$_tempoCandidateLabels, '
        '_tempoInput:$_tempoInput, _tempoDeleteLabels:$_tempoDeleteLabels, _tempoLabels:$_tempoLabels');

    super.initState();
  }

  @override
  void dispose() {
    /// //todo disposeしなくてい良い??
    _tempoCandidateLabels = [];
    _tempoDisplayList = [];
    _tempoInput ='';//tagChips破棄時に空にする
    debugPrint('tagChips/dispose_tempoDisplayList :$_tempoDisplayList');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        children:
        [
              Wrap(
                spacing: 8,
                children:
                ///List<InputChip>への変換はinitState内ではなく、Wrap内で行わないとselectedが反映されない
                ///tagNameListからつくることでtempoChipsいらない
                /// //todo 長すぎるチップでも全部見えるようにする
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
                      _tempoDisplayList.removeAt(index);
                  debugPrint('TagChips/onDelete/tempoDeleteLabels:$_tempoDeleteLabels');
                  debugPrint('TagChips/onDelete/_tempoDisplayList:$_tempoDisplayList');
 ///削除した状態をviewModelへset
//                      widget.onSubmitted(_tempoDisplayList);
                      // ignore: lines_longer_than_80_chars
                      //DB由来のタイトルから削除タイトル抜かないと1回削除して再度TagInputChipで同じものを入力しようとしても重複タグ扱いになって登録されない
                        //tagNameListSet = _tempoDisplayList.toSet();//todo いらない？
//                      print('InputChip/onDeleted/tagNameListSet:$tagNameListSet');
                        widget.onDeleted(_tempoDeleteLabels,_tempoDisplayList);

                      //tempoDeleteLabelsクリア
                      // (しないとviewModelのDeleteLabelsに重複して登録されていく)
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
                    isInput: isInput,
                    onChangeInputMode: (){
                      setState(() {   //TagInputChip表示をTextFieldへ変更
                        isInput = true;
                      });
                    },
                    //tagInputChipのautoFocus外して入力モードになったら+create'...'ボタン出す
                    onFocusChange: (focus){
                      setState(() {isFocus = focus.hasFocus;});
                    },
                    setTempoInput: (tempoInput){
                      //createTag表示用(リアルタイムで)
                      setState(() {_tempoInput =tempoInput;});
                      widget.setTempoInput(tempoInput);
                    },
                    onSubmitted: (input){
                      debugPrint('tagChipsのonSubmitted時の_tempoCandidateLabels:$_tempoCandidateLabels');
                      debugPrint('tagChipsのonSubmitted時の_tempoDisplayList:$_tempoDisplayList');
                      debugPrint('tagChipsのonSubmitted時の_tempoDeleteLabels$_tempoDeleteLabels');
                      debugPrint('tagChipsのonSubmitted時の_tempoInput:$_tempoInput');
                      debugPrint('tagChipsのonSubmitted時の_tempoLabels:$_tempoLabels');
                      ///inputが既存の仮tagクラス内またはDB内に存在しないのかvalidation
                      //入力なしは登録されないようvalidation(input =''の時登録なし)
                      if(input == ''||input == ' ' ){
                      }else{
                        /// _tempoCandidateLabels内にinput要素があれば削除
                        if( _tempoCandidateLabels.contains(input)){
                          _tempoCandidateLabels.remove(input);
                        }
                        ///tagNameList内に重複がないかのvalidation
                        //まずは入力値を文字リストに入れる
                        _tempoLabels.add(input);
                        //set型に変換しないと重複削除できないので、toSet
                        final tempoLabelSet =_tempoLabels.toSet();
                        //tempoLabelsクリア(しないと編集中に消したものが再度出てくる)
                        _tempoLabels =[];
                        //addAllで重複削除：_tempoDisplayList内にinputあるかどうか
                        //_tempoDisplayListに事前に入っているものとtempoLabelを合体
                        final tempoDisplaySet =_tempoDisplayList.toSet()
                          ..addAll(tempoLabelSet);
                        _tempoDisplayList = tempoDisplaySet.toList();
                        //tag_dialog_pageへタグタイトルのリスト上げてviewModelに格納
                        widget.onSubmitted(_tempoDisplayList);
                        //createTag表示をリセット
                        _tempoInput ='';
                        //TagInputChip表示をActionChipへ戻す
                        isInput = false;
                      }
                      debugPrint('tagChipsのonSubmitted時の_tempoCandidateLabels:$_tempoCandidateLabels');
                      debugPrint('tagChipsのonSubmitted時の_tempoDisplayList:$_tempoDisplayList');
                      debugPrint('tagChipsのonSubmitted時の_tempoDeleteLabels$_tempoDeleteLabels');
                      debugPrint('tagChipsのonSubmitted時の_tempoInput:$_tempoInput');
                      debugPrint('tagChipsのonSubmitted時の_tempoLabels:$_tempoLabels');
                      setState(() {//tag_input_chipのcontroller破棄
                      },);



                    },),
        ],
      ),
      const Divider(color: Colors.black,),
      isFocus && (_tempoInput !='')
      //input入力時
      ? CreateTag(
        title: _tempoInput,
        onTapAddTag: (){
          //追加時フォーカス外す
          FocusScope.of(context).unfocus();
          setState(() {
            //候補タグから既にあるものを入れたら表示を消す
            if( _tempoCandidateLabels.contains(_tempoInput)){
              _tempoCandidateLabels.remove(_tempoInput);
            }
            //重複バリデーション
            _tempoLabels.add(_tempoInput);
            final tempoLabelSet =_tempoLabels.toSet();
            _tempoLabels =[];
            //_tempoDisplayListに事前に入っているものとtempoLabelを合体
            final tempoDisplaySet =_tempoDisplayList.toSet()
                  ..addAll(tempoLabelSet);
            _tempoDisplayList = tempoDisplaySet.toList();
            widget.onSubmitted(_tempoDisplayList);
            _tempoInput ='';
            //TagInputChip表示をActionChipへ戻す
            isInput = false;
          });

        },
      )
//      Text('＋ タグを追加"$_tempoInput"')
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
