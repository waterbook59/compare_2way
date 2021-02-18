import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class CompareViewModel extends ChangeNotifier {
  CompareViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;

  List<ComparisonOverview> _comparisonOverviews = <ComparisonOverview>[];

  Future<List<ComparisonOverview>> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
        await _compareRepository.getOverview(comparisonItemId);
    notifyListeners();
  }
}
