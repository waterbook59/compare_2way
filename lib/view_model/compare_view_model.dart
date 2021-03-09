import 'package:compare_2way/data_models/comparison_overview.dart';
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
  String _itemTitle ='';
  String get itemTitle => _itemTitle;
  String _way1Title ='';
  String get way1Title => _way1Title;
  String _way2Title ='';
  String get way2Title => _way2Title;
  int _way1MeritEvaluate =0;
  int get way1MeritEvaluate => _way1MeritEvaluate;
  int _way1DemeritEvaluate =0;
  int get way1DemeritEvaluate => _way1DemeritEvaluate;
  int _way2MeritEvaluate =0;
  int get way2MeritEvaluate => _way2MeritEvaluate;
  int _way2DemeritEvaluate =0;
  int get way2DemeritEvaluate => _way2DemeritEvaluate;
  int _way3MeritEvaluate =0;
  int get way3MeritEvaluate => _way3MeritEvaluate;
  int _way3DemeritEvaluate =0;
  int get way3DemeritEvaluate => _way3DemeritEvaluate;
  //いらんかも
  TextEditingController _conclusionController = TextEditingController();
  TextEditingController get conclusionController => _conclusionController;
  String conclusion ='';

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
  Future<List<ComparisonOverview>> getWaitOverview(String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
     _itemTitle = comparisonOverviews[0].itemTitle;
     _way1Title = comparisonOverviews[0].way1Title;
     _way2Title = comparisonOverviews[0].way2Title;
     _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate;
     _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate;
     _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate;
     _way2DemeritEvaluate  =comparisonOverviews[0].way2DemeritEvaluate;
     _conclusionController.text = comparisonOverviews[0].conclusion;

     //todo way3Evaluate
//    print('FutureBuilderのway2のタイトル:$_way2Title');
    return _comparisonOverviews;
  }

  Future<void> setWay1MeritNewValue(int newValue) async{
    _way1MeritEvaluate = newValue;
    notifyListeners();
  }

  Future<void> setWay1DemeritNewValue(int newValue) async{
    _way1DemeritEvaluate = newValue;
    notifyListeners();
  }

  Future<void> setWay2MeritNewValue(int newValue) async{
    _way2MeritEvaluate = newValue;
    notifyListeners();
  }

  Future<void> setWay2DemeritNewValue(int newValue) async{
    _way2DemeritEvaluate = newValue;
    notifyListeners();
  }


  ///CompareScreenで表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
  //todo favorite,way3追加
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async{


//    final updateOverview = ComparisonOverview(
//      comparisonItemId: comparisonItemId,
//      itemTitle: _itemTitle,
//      way1Title: _way1Title,
//      way2Title: _way2Title,
//      way1MeritEvaluate: _way1MeritEvaluate,
//      way1DemeritEvaluate: _way1DemeritEvaluate,
//      way2MeritEvaluate: _way2MeritEvaluate,
//      way2DemeritEvaluate: _way2DemeritEvaluate,
//      conclusion: conclusion,
//      createdAt: DateTime.now(),
//    );
    await _compareRepository.saveComparisonItem(updateOverview);
    notifyListeners();
  }

  ///データ保存後に再取得
  Future<void> getOverviewList() async{
    print('getOverviewList発動');
    _comparisonOverviews  = await _compareRepository.getOverviewList();
    print('getOverviewList非同期終了');
    notifyListeners();
  }

  ///FutureBuilder用
  Future<List<ComparisonOverview>> getList() async{
    print('getList発動');
    _comparisonOverviews  = await _compareRepository.getList();
    print('getList非同期終了');
    return _comparisonOverviews ;
  }

  //FutureBuilder用
  Future<List<ComparisonOverview>> isOverviewList() async{
    return _comparisonOverviews ;
  }

  Future<void> changeEditStatus(ListEditMode editMode) async{
      if(editMode== ListEditMode.edit){
        editStatus = ListEditMode.display;
      }else{
        editStatus =  ListEditMode.edit;
      }
      notifyListeners();
  }

  Future<void> deleteList(String comparisonItemId) async{
    //削除
   await  _compareRepository.deleteList(comparisonItemId);
    //データ取得?
   notifyListeners();
  }





//todo textControllerを破棄
}
