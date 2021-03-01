import 'dart:async';
import 'dart:collection';

import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class ListViewModel extends ChangeNotifier{

  ListViewModel({
    CompareRepository compareRepository,
  }):_compareRepository = compareRepository;
  final CompareRepository _compareRepository;

  List<ComparisonOverview> _overviews = <ComparisonOverview>[];
  //taskのリストをview層からとるとUnmodifiableListViewで返す
//  UnmodifiableListView<ComparisonOverview> get overviews {
//    return UnmodifiableListView( _overviews);
//}
  List<ComparisonOverview> get overviews => _overviews;




///Consumer用
  Future<void> getOverviewList() async{

    print('getOverviewList発動');
    //todo circular indicator追加
     _overviews = await _compareRepository.getOverviewList();
    print('getOverviewList非同期終了');
    notifyListeners();
  }


///FutureBuilder用
//リストをDBでとるのはConsumer側でやってるので、リストあるかどうかだけ返せばいいのでは？_overviews.isEmptyかどうかを返す
//=>最初のbuildの時にConsumer側でリスト取得するまでリスト空の表示が出てしまう
  Future<List<ComparisonOverview>> getList() async{
    print('getList発動');
    _overviews = await _compareRepository.getList();
    print('getList非同期終了');
    return _overviews;
  }

  ///FutureBuilder用
  Future<List<ComparisonOverview>> isOverviewList() async{
    return _overviews;
  }




}