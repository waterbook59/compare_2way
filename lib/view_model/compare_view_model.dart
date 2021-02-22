import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class CompareViewModel extends ChangeNotifier {
  CompareViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;
  List<ComparisonOverview> _comparisonOverviews = <ComparisonOverview>[];
  List<ComparisonOverview> get comparisonOverviews => _comparisonOverviews;
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


  ///ページ開いた時の取得(notifyListeners(リビルド)あり)
  Future<List<ComparisonOverview>> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
        await _compareRepository.getOverview(comparisonItemId);
    _way1Title = comparisonOverviews[0].way1Title;
    _way2Title = comparisonOverviews[0].way2Title;
    print('way2のタイトル:$_way2Title');

    notifyListeners();
  }

  ///FutureBuilder用(notifyListeners(リビルド)なし)
  Future<List<ComparisonOverview>> getWaitOverview(String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
     _way1Title = comparisonOverviews[0].way1Title;
     _way2Title = comparisonOverviews[0].way2Title;
     _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate;
     _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate;
     _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate;
     _way2DemeritEvaluate  =comparisonOverviews[0].way2DemeritEvaluate;
     //todo way3Evaluate
    print('FutureBuilderのway2のタイトル:$_way2Title');

  }


  //todo 登録・更新時createdAtをDateTime.now()に変更

}
