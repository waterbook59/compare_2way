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
    print('FutureBuilderのway2のタイトル:$_way2Title');

  }

}
