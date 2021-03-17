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
  List<TextEditingController> _way1MeritControllers;
  List<TextEditingController> get way1MeritControllers => _way1MeritControllers;

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

  //todo conclusion用のcontrollerの設定必要？

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

  //way1Meritのリストを作って保存
  Future<void> createDesc(Way1Merit initWay1Merit) async {
    //ここでaddしていくと古いものがだぶるのでは
    _way1MeritList.add(initWay1Merit);
    print('viewModel.way1MeritList:$_way1MeritList');
    await _compareRepository.createDescList(_way1MeritList);
    _way1MeritList = <Way1Merit>[];
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
    print('getList発動');
    _comparisonOverviews = await _compareRepository.getList();
    print('getList非同期終了');
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

    notifyListeners();
  }

  ///List<Way1Merit>取得
  Future<List<Way1Merit>> getDesc(String comparisonItemId) async {
    _way1MeritList =
    await _compareRepository.getWay1MeritList(comparisonItemId);
     _way1MeritControllers =
    List.generate(_way1MeritList.length, (i) =>
        TextEditingController(text: _way1MeritList[i].way1MeritDesc));
    return _way1MeritList;
  }

//todo textControllerを破棄
}
