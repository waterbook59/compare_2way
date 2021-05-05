import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:flutter/material.dart';

class CompareViewModel extends ChangeNotifier {
  CompareViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;
  List<ComparisonOverview> _comparisonOverviews = <ComparisonOverview>[];
  List<ComparisonOverview> get comparisonOverviews => _comparisonOverviews;
  CompareScreenStatus compareScreenStatus;
  ComparisonOverview overviewDB;
  List<Way1Merit> _way1MeritList = <Way1Merit>[];
  List<Way1Merit> get way1MeritList => _way1MeritList;
  List<Way2Merit> _way2MeritList = <Way2Merit>[];
  List<Way2Merit> get way2MeritList => _way2MeritList;

//textFieldからviewModelへの変更値登録があるのでカプセル化しない
  String itemTitle = '';
  String way1Title = '';
  String way2Title = '';

  int _way1MeritEvaluate = 0;
  int get way1MeritEvaluate => _way1MeritEvaluate;
  int _way1DemeritEvaluate = 0;
  int get way1DemeritEvaluate => _way1DemeritEvaluate;
  int _way2MeritEvaluate = 0;
  int get way2MeritEvaluate => _way2MeritEvaluate;
  int _way2DemeritEvaluate = 0;
  int get way2DemeritEvaluate => _way2DemeritEvaluate;
  int _way3MeritEvaluate = 0;
  int get way3MeritEvaluate => _way3MeritEvaluate;
  int _way3DemeritEvaluate = 0;
  int get way3DemeritEvaluate => _way3DemeritEvaluate;

  //いらんかも
  TextEditingController _conclusionController = TextEditingController();
  TextEditingController get conclusionController => _conclusionController;
  String conclusion = '';

  //textFieldからviewModelへの変更値登録があるのでカプセル化しない
  String tagTitle= '';
  List<String> _tagNameList = <String>[];
  List<Tag> _tagList = <Tag>[];
  List<Tag> get tagList => _tagList;
  List<Chip> _displayChipList = <Chip>[];
  List<Chip> get displayChipList =>_displayChipList;
  List<Tag> _deleteTagList = <Tag>[];
  List<Tag> get deleteTagList => _deleteTagList;

  ListEditMode editStatus = ListEditMode.display;

  ///ページ開いた時の取得(notifyListeners(リビルド)あり)
  Future<void> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    way1Title = comparisonOverviews[0].way1Title;
    way2Title = comparisonOverviews[0].way2Title;
    notifyListeners();
  }

  ///FutureBuilder用(notifyListeners(リビルド)なし)
  //todo getSingle()に変更してすっきり書く
  Future<List<ComparisonOverview>> getWaitOverview(
      String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    itemTitle = comparisonOverviews[0].itemTitle;
    way1Title = comparisonOverviews[0].way1Title;
    way2Title = comparisonOverviews[0].way2Title;
    _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate;
    _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverviews[0].way2DemeritEvaluate;
    _conclusionController.text = comparisonOverviews[0].conclusion;

    //todo way3Evaluate
//    print('FutureBuilderのway2のタイトル:$_way2Title');
    return _comparisonOverviews;
  }

  ///AddScreen/InputPartでComparisonOverview新規登録：ComparisonOverview=>ComparisonOverviewRecordでDB登録
  Future<void> createComparisonOverview(
      ComparisonOverview comparisonOverview) async {
    await _compareRepository.createComparisonOverview(comparisonOverview);
//    notifyListeners();
  }
  ///AddScreen/InputPartでComparisonOverview更新：itemTitle,way1Title,way2Titleのみ変更
  Future<void> updateComparisonOverView(
      ComparisonOverview comparisonOverview) async {
    //更新するプロパティだけ入れてrepositoryでCompanion作成=>更新
    final updateOverview = ComparisonOverview(
      comparisonItemId: comparisonOverview.comparisonItemId,
      itemTitle: itemTitle,
      way1Title: way1Title,
      way2Title: way2Title,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateComparisonOverView(updateOverview);
  print('comparisonOverviewのタイトル類を更新');
    notifyListeners();
  }

  ///AddScreen/InputPartでWay1Merit,Way2Meritリストを新規登録
  //way1Merit,way2Meritのリストを作って保存
  //todo list.add=>DB登録=>list空の流れではなく、
  // initWay1MeritをリストにしてcreateDescListに渡す方がすっきり書ける
  Future<void> createDesc(Way1Merit initWay1Merit,
      Way2Merit initWay2Merit,) async {
    _way1MeritList = [initWay1Merit];
    _way2MeritList = [initWay2Merit];
    //ここでaddしていくと古いものがだぶる
///既存のoverviewでway1リスト追加=>新規でoverview,way1リスト作成,DB登録=>既存のoverviewが重複して登録されてしまう
//    _way1MeritList.add(initWay1Merit);
//    print('compareViewModel/createDesc/way1MeritList.add$_way1MeritList');
//    _way2MeritList.add(initWay2Merit);
    await _compareRepository.createDescList(_way1MeritList,_way2MeritList);
    _way1MeritList = <Way1Merit>[];
    _way2MeritList = <Way2Merit>[];
  }

  ///List<ComparisonOverview>ではなく、comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<void> getComparisonOverview(String comparisonItemId) async {
    overviewDB =
    await _compareRepository.getComparisonOverview(comparisonItemId);
  }

  Future<void> setWay1MeritNewValue(int newValue) async {
    _way1MeritEvaluate = newValue;
  }

  Future<void> setWay1DemeritNewValue(int newValue) async {
    _way1DemeritEvaluate = newValue;
  }

  Future<void> setWay2MeritNewValue(int newValue) async {
    _way2MeritEvaluate = newValue;
  }

  Future<void> setWay2DemeritNewValue(int newValue) async {
    _way2DemeritEvaluate = newValue;
  }

  Future<void> setConclusion(String newConclusion) async {
    conclusion = newConclusion;
  }

  ///DescFormAndButtonでList<Way1Merit>の入力変更があったとき
  Future<void> setChangeListDesc(
      ComparisonOverview comparisonOverview,
      DisplayList displayList,
      String newDesc, int index) async {
    print('setNewDesc!:$newDesc');

    ///List.generate=>DB更新は変更した行のみ
    // Listの中の[index]の番号のway1MeritDescのプロパティだけnewDescに変えたい
//    _way1MeritList = List.generate(_way1MeritList.length, (i) {
//      if(i == index){
//        return Way1Merit(
//          way1MeritId: _way1MeritList[i].way1MeritId,
//          comparisonItemId: _way1MeritList[i].comparisonItemId,
//          way1MeritDesc: newDesc,
//        );
//      }else{
//        return Way1Merit(
//          way1MeritId: _way1MeritList[i].way1MeritId,
//          comparisonItemId: _way1MeritList[i].comparisonItemId,
//          way1MeritDesc: _way1MeritList[i].way1MeritDesc,
//        );
//      }
//    });
    //    await _compareRepository.setWay1MeritDesc(_way1MeritList,index);
    switch(displayList){
      case DisplayList.way1Merit:
          ///変更行作成=>DB更新は変更した行のみ
          final changeWay1Merit = Way1Merit(
            way1MeritId: _way1MeritList[index].way1MeritId,
            comparisonItemId: _way1MeritList[index].comparisonItemId,
            way1MeritDesc: newDesc,
          );
          await _compareRepository.setWay1MeritDesc(changeWay1Merit, index);
          _way1MeritList = await _compareRepository.getWay1MeritList(
              comparisonOverview.comparisonItemId);
          break;
      case DisplayList.way2Merit:
          final changeWay2Merit = Way2Merit(
            way2MeritId: _way2MeritList[index].way2MeritId,
            comparisonItemId: _way2MeritList[index].comparisonItemId,
            way2MeritDesc: newDesc,
          );
          await _compareRepository.setWay2MeritDesc(changeWay2Merit, index);
          _way2MeritList = await _compareRepository.getWay2MeritList(
              comparisonOverview.comparisonItemId);
          break;
    }

    notifyListeners();
  }

  ///DescFormAndButtonでリスト行追加
  Future<void> accordionAddList(ComparisonOverview comparisonOverview,
      DisplayList displayList) async {
    switch(displayList){
      case DisplayList.way1Merit:
            final initWay1Merit = Way1Merit(
              comparisonItemId: comparisonOverview.comparisonItemId,
              way1MeritDesc: '',
            );
            print('CompareViewModel/addWay1Merit/新規リスト追加前'
                '${_way1MeritList.map((
                way1Merit) => way1Merit.way1MeritDesc).toList()}');
            await _compareRepository.addWay1Merit(initWay1Merit);
            //1行DBへ追加した後、追加したもの含めて_way1MeritListに取得リスト格納してみる
            _way1MeritList = await _compareRepository.getWay1MeritList(
                comparisonOverview.comparisonItemId);
            print('CompareViewModel/addWay1Merit/新規リスト追加後'
                '${_way1MeritList.map((
                way1Merit) => way1Merit.way1MeritDesc).toList()}');
            break;
      case DisplayList.way2Merit:
            final initWay2Merit = Way2Merit(
              comparisonItemId: comparisonOverview.comparisonItemId,
              way2MeritDesc: '',
            );
            await _compareRepository.addWay2Merit(initWay2Merit);
            _way2MeritList = await _compareRepository.getWay2MeritList(
                comparisonOverview.comparisonItemId);
            break;
    }
    notifyListeners();
  }

  ///DescFormAndButtonでリスト削除
  Future<void> accordionDeleteList(
      DisplayList displayList,
      int accordionIdIndex,
      ComparisonOverview comparisonOverview) async {
    switch(displayList){
      case DisplayList.way1Merit:
        final deleteWay1MeritId = _way1MeritList[accordionIdIndex].way1MeritId;
        await _compareRepository.deleteWay1Merit(deleteWay1MeritId);
        //再取得しないとDescFormAndButtonでのListViewの認識している長さと削除するindexが異なりエラー
        _way1MeritList = await _compareRepository.getWay1MeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Merit:
        final deleteWay2MeritId = _way2MeritList[accordionIdIndex].way2MeritId;
        await _compareRepository.deleteWay2Merit(deleteWay2MeritId);
        _way2MeritList = await _compareRepository.getWay2MeritList(
            comparisonOverview.comparisonItemId);
        break;
    }

//    notifyListeners();
  }


  ///CompareScreenで表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
  //todo favorite,way3追加
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
    final saveOverview = ComparisonOverview(
      comparisonItemId: updateOverview.comparisonItemId,
      itemTitle: itemTitle,
      way1Title: way1Title,
      way2Title: way2Title,
      way1MeritEvaluate: _way1MeritEvaluate,
      way1DemeritEvaluate: _way1DemeritEvaluate,
      way2MeritEvaluate: _way2MeritEvaluate,
      way2DemeritEvaluate: _way2DemeritEvaluate,
      conclusion: conclusion,
      createdAt: DateTime.now(),
    );
    await _compareRepository.saveComparisonItem(saveOverview);
    notifyListeners();
  }

  ///データ保存後に再取得
  Future<void> getOverviewList() async {
    print('getOverviewList発動');
    _comparisonOverviews = await _compareRepository.getOverviewList();
    print('getOverviewList非同期終了');
    notifyListeners();
  }

  ///ListPageのFutureBuilder用
  Future<List<ComparisonOverview>> getList() async {
//    print('getList発動');
    _comparisonOverviews = await _compareRepository.getList();
//    print('getList非同期終了');
    return _comparisonOverviews;
  }

  //FutureBuilder用
  Future<List<ComparisonOverview>> isOverviewList() async {
    return _comparisonOverviews;
  }

  Future<void> changeEditStatus(ListEditMode editMode) async {
    if (editMode == ListEditMode.edit) {
      editStatus = ListEditMode.display;
    } else {
      editStatus = ListEditMode.edit;
    }
    notifyListeners();
  }

  Future<void> deleteList(String comparisonItemId) async {
    //削除
    await _compareRepository.deleteList(comparisonItemId);
    //データ取得?
    notifyListeners();
  }

  Future<void> backListPage() {
    notifyListeners();
  }

  Future<void> setOverview(ComparisonOverview comparisonOverview) async {
    itemTitle = comparisonOverview.itemTitle;
    way1Title = comparisonOverview.way1Title;
    _way1MeritEvaluate = comparisonOverview.way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate;
    way2Title = comparisonOverview.way2Title;
    _way2MeritEvaluate = comparisonOverview.way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate;
    conclusion = comparisonOverview.conclusion;
    print('文頭のsetOverview/notifyListeners');
//    notifyListeners();
  }


  ///List<Way1Merit>,List<Way2Merit>取得(文頭取得用)
  Future<void> getAccordionList(String comparisonItemId) async {
    _way1MeritList =
    await _compareRepository.getWay1MeritList(comparisonItemId);
    _way2MeritList =
    await _compareRepository.getWay2MeritList(comparisonItemId);
    print('getWay1/Way2MeritList/notifyListeners');
    notifyListeners();
  }

  ///List<Way1Merit>取得(FutureBuilder用)
  Future<List<Way1Merit>> getWay1MeritDesc(String comparisonItemId) async {
//    print('FutureBuilderでDBからList<Way1Merit> _way1MeritList取得');
      return _way1MeritList =
      await _compareRepository.getWay1MeritList(comparisonItemId);
  }


  ///List<Way1Mer2t>取得(FutureBuilder用)
  Future<List<Way2Merit>> getWay2MeritDesc(String comparisonItemId) async {
    return _way2MeritList =
    await _compareRepository.getWay2MeritList(comparisonItemId);
  }

  Future<void> deleteWay2Merit(int way2MeritIdIndex,
      ComparisonOverview comparisonOverview) async{
    print('Way2Meritの選択したものを削除');
//    final deleteWay2MeritId = _way2MeritList[way2MeritIdIndex].way2MeritId;
//    await _compareRepository.deleteWay1Merit(deleteWay2MeritId);
//    //再取得しないとDescFormAndButtonでのListViewの認識している長さと削除するindexが異なりエラー
//    _way1MeritList = await _compareRepository.getWay2MeritList(
//        comparisonOverview.comparisonItemId);
//    notifyListeners();
  }

 ///tagDialogPageでList<tag>を新規登録
  Future<void> createTag(ComparisonOverview comparisonOverview) async{
    print('createTag:$_tagNameList&${comparisonOverview.comparisonItemId}');
    //完了を押したらinput内容(List<String>)とcomparisonIdを基にList<Tag>クラスをDB登録
    //comparisonItemIdとtagNameListからList<Tag>作成
    final tagList = _tagNameList.map((name) {
      return Tag(
        comparisonItemId: comparisonOverview.comparisonItemId,
        tagTitle: name,
      );
    }).toList();
    //tagListをrepositoryへ
    await _compareRepository.createTag(tagList);
    //新規作成のときはnotifyListenersいらない？取得の時のみ？
  }

  ///tagChipsでtextField入力内容をviewModelへset
  Future<void> setTagNameList(List<String> tagNameList)async{
    _tagNameList = tagNameList;
//    print('compareViewModelへtagNameListをset:'
//        '${_tagNameList.map((tagName) => print('$tagName')).toList()}');
    print('compareViewModelへtagNameListをset:$_tagNameList');
  }
 ///List<Tag>取得(文頭取得用)
  Future<void> getTagList(String comparisonItemId) async{
    _tagList = await _compareRepository.getTagList(comparisonItemId);
//    print('viewModel.getTagList:${_tagList.map((e) => e.tagTitle)}');
    //_tagNameListにもtagTitle格納
    _tagNameList = _tagList.map((tag) {
      return tag.tagTitle;
    }).toList();
    print('viewModel.getTagList/_tagNameList:$_tagNameList');
    //List<Tag>=>List<Chips>へ変更
    _displayChipList = _tagList.map((tag) {
      return Chip(
        label: Text(tag.tagTitle),
      );
    }).toList();
    notifyListeners();
  }

  ///tagChipsで削除するTagを登録
  Future<void> createDeleteList(
      List<String> tempoDeleteLabels, String comparisonItemId) async{
    final joinList = [...tempoDeleteLabels,..._tagNameList];
//  final joinList= List<String>.from(tempoDeleteLabels)..addAll(_tagNameList);
    //削除する項目(tempoDeleteLabels)とDB登録してある項目(_tagNameList)を結合して
    //重複しているものだけを抜き出す（もっと簡単に抜き出す方法はないか??重複したものだけ抜き出せばlistsが登録にも使える）
    print('viewModel.createDeleteList/joinList:$joinList');
    final lists =<String>[];
    joinList.map((title) {
      if(lists.contains(title)){
        final deleteTag = Tag(
            comparisonItemId: comparisonItemId,
            tagTitle: title,
        );
        deleteTagList.add(deleteTag);
        print('deleteTagList:${deleteTagList.map((e) => e.tagTitle).toList()}');
      }else{
       lists.add(title);
       print('delete以外のリスト：$lists');
      }
    }).toList();


  }
  ///tagDialogPageでList<tag>を削除
  Future<void>deleteTag() async{
    print('deleteTagメソッドで消すリスト:'
        '${deleteTagList.map((e) => e.tagTitle).toList()}');
    await _compareRepository.deleteTag(deleteTagList);
   _deleteTagList = [];
  }





//todo textControllerを破棄
}
