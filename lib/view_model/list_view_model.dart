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
  UnmodifiableListView<ComparisonOverview> get overviews {
    return UnmodifiableListView( _overviews);
  }



///Consumer用
  //FutureBuilder側でリストとるならnotifyListenersだけするのでもいいのでは？
  Future<void> getOverviewList() async{
    //todo circular indicator追加,notifyListenersのみに変更してみる
    _overviews = await _compareRepository.getOverviewList();
    notifyListeners();
  }

  Future<List<ComparisonOverview>> getList() async{
    return _overviews = await _compareRepository.getList();
  }

///FutureBuilder用
  //リストをDBでとるのはConsumer側でやってるので、リストあるかどうかだけ返せばいいのでは？_overviews.isEmptyかどうかを返す
  //=>最初のbuildの時にConsumer側でリスト取得するまでリスト空の表示が出てしまう


}