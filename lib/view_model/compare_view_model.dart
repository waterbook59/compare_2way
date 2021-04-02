import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
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


  String _itemTitle = '';

  String get itemTitle => _itemTitle;
  String _way1Title = '';

  String get way1Title => _way1Title;
  String _way2Title = '';

  String get way2Title => _way2Title;
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


  ListEditMode editStatus = ListEditMode.display;

  ///ページ開いた時の取得(notifyListeners(リビルド)あり)
  Future<void> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    _way1Title = comparisonOverviews[0].way1Title;
    _way2Title = comparisonOverviews[0].way2Title;
    notifyListeners();
  }

  ///FutureBuilder用(notifyListeners(リビルド)なし)
  //todo getSingle()に変更してすっきり書く
  Future<List<ComparisonOverview>> getWaitOverview(
      String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    _itemTitle = comparisonOverviews[0].itemTitle;
    _way1Title = comparisonOverviews[0].way1Title;
    _way2Title = comparisonOverviews[0].way2Title;
    _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate;
    _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverviews[0].way2DemeritEvaluate;
    _conclusionController.text = comparisonOverviews[0].conclusion;

    //todo way3Evaluate
//    print('FutureBuilderのway2のタイトル:$_way2Title');
    return _comparisonOverviews;
  }

  ///ComparisonOverview=>ComparisonOverviewRecordでDB登録
  Future<void> createComparisonOverview(
      ComparisonOverview comparisonOverview) async {
    await _compareRepository.createComparisonOverview(comparisonOverview);
//    notifyListeners();
  }

  ///way1Merit,way2Meritのリストを作って保存
  //todo list.add=>DB登録=>list空にせずに、initWay1MeritをリストにしてcreateDescListに渡す
  Future<void> createDesc(Way1Merit initWay1Merit,
      Way2Merit initWay2Merit,) async {
    //ここでaddしていくと古いものがだぶるのでは
    _way1MeritList.add(initWay1Merit);
    _way2MeritList.add(initWay2Merit);
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
  Future<void> setWay1MeritDesc(ComparisonOverview comparisonOverview,
      String newDesc, int index) async {
    print('setWay1MeritNewDesc!:$newDesc');

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
    ///変更行作成=>DB更新は変更した行のみ
    final changeWay1Merit = Way1Merit(
      way1MeritId: _way1MeritList[index].way1MeritId,
      comparisonItemId: _way1MeritList[index].comparisonItemId,
      way1MeritDesc: newDesc,
    );
    await _compareRepository.setWay1MeritDesc(changeWay1Merit, index);
    _way1MeritList = await _compareRepository.getWay1MeritList(
        comparisonOverview.comparisonItemId);
    notifyListeners();
  }

  ///DescFormAndButtonでList<Way1Merit>のリスト追加を行ったとき
  Future<void> addWay1Merit(ComparisonOverview comparisonOverview) async {
//    print('ComparisonIdを渡してway1Meritのリスト追加');
    final initWay1Merit = Way1Merit(
      comparisonItemId: comparisonOverview.comparisonItemId,
      way1MeritDesc: '',
    );

    print('CompareViewModel/addWay1Merit/新規リスト追加前${_way1MeritList.map((
        way1Merit) => way1Merit.way1MeritDesc).toList()}');
    await _compareRepository.addWay1Merit(initWay1Merit);
    //1行DBへ追加した後、追加したもの含めて_way1MeritListに取得リスト格納してみる

    _way1MeritList = await _compareRepository.getWay1MeritList(
        comparisonOverview.comparisonItemId);
    print('CompareViewModel/addWay1Merit/新規リスト追加後${_way1MeritList.map((
        way1Merit) => way1Merit.way1MeritDesc).toList()}');

    //selectorビルドさせたところで、GFAccordion表示に変化がない...
//    _way1Title = '変更！';
//    compareScreenStatus = CompareScreenStatus.set;
    notifyListeners();
  }

  ///DescFormAndButtonでList<Way1Merit>のリスト削除を行ったとき
  Future<void> deleteWay1Merit(int way1MeritIdIndex,
      ComparisonOverview comparisonOverview) async {
    final deleteQay1MeritId = _way1MeritList[way1MeritIdIndex].way1MeritId;
    await _compareRepository.deleteWay1Merit(deleteQay1MeritId);
    //再取得しないとDescFormAndButtonでのListViewの認識している長さと削除するindexが異なりエラー
    _way1MeritList = await _compareRepository.getWay1MeritList(
        comparisonOverview.comparisonItemId);
//    notifyListeners();
  }


  ///CompareScreenで表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
  //todo favorite,way3追加
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
    final saveOverview = ComparisonOverview(
      comparisonItemId: updateOverview.comparisonItemId,
      itemTitle: _itemTitle,
      way1Title: _way1Title,
      way2Title: _way2Title,
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
    _itemTitle = comparisonOverview.itemTitle;
    _way1Title = comparisonOverview.way1Title;
    _way1MeritEvaluate = comparisonOverview.way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate;
    _way2Title = comparisonOverview.way2Title;
    _way2MeritEvaluate = comparisonOverview.way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate;
    conclusion = comparisonOverview.conclusion;
    print('文頭のsetOverview/notifyListeners');
//    notifyListeners();
  }


  ///List<Way1Merit>取得(文頭取得用)
  Future<void> getWay1MeritList(String comparisonItemId) async {
    _way1MeritList =
    await _compareRepository.getWay1MeritList(comparisonItemId);
    print('getWay1MeritList/notifyListeners');
    notifyListeners();
  }

  ///List<Way1Merit>取得(FutureBuilder用)
  Future<List<Way1Merit>> getDesc(String comparisonItemId) async {
//    print('FutureBuilderでDBからList<Way1Merit> _way1MeritList取得');
    return _way1MeritList =
    await _compareRepository.getWay1MeritList(comparisonItemId);
  }

  ///List<Way2Merit>取得(文頭取得用)
//  Future<void> getWay2MeritList(String comparisonItemId) async {
//    _way2MeritList =
//    await _compareRepository.getWay2MeritList(comparisonItemId);
//    notifyListeners();
//  }

  ///List<Way1Mer2t>取得(FutureBuilder用)
//  Future<List<Way1Merit>> getWay2Desc(String comparisonItemId) async {
//    return _way2MeritList =
//    await _compareRepository.getWay2eritList(comparisonItemId);
//  }


//todo textControllerを破棄
}
