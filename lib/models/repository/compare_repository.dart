import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/utils/extensions.dart';
import 'package:moor/ffi.dart';

class CompareRepository {
  CompareRepository({ComparisonItemDao comparisonItemDao})
      : _comparisonItemDao = comparisonItemDao;

  final ComparisonItemDao _comparisonItemDao;
  List<ComparisonOverview> _overviewResults = <ComparisonOverview>[];

  Future<void> createComparisonItems(ComparisonItem comparisonItem) async {
    try {
      ///ComparisonItem=>ComparisonOverviewRecord
      final comparisonOverviewRecord =
          comparisonItem.toOverviewRecord(comparisonItem);
      //  comparisonItem.way1MeritとcomparisonItem.way1Demeritがnullなのでextensions内の
      //forEachでエラー：The method 'forEach' was called on null.
      // final way1MeritDescs = comparisonItem.toWay1MeritRecord(comparisonItem);
      // final way1DemeritDescs =
      //    comparisonItem.toWay1DemeritRecord(comparisonItem);

//      await _comparisonItemDao.insertDB(
//          comparisonOverviewRecord, way1MeritDescs,way1DemeritDescs);

      await _comparisonItemDao
          .insertComparisonOverviewDB(comparisonOverviewRecord);
      print('way1とway2のタイトル登録完了');
    } on SqliteException catch (e) {
      //ここでエラーを返さずにviewとviewModelのvalidationの条件に同じタイトルを弾くようにしてみる
      print('repositoryエラー:この問題はすでに登録${e.toString()}');
    }
  }

  Future<List<ComparisonOverview>> getOverview(String comparisonItemId) async {
    ///resultComparisonOverviewRecordsはList<ComparisonOverviewRecord>
    final resultComparisonOverviewRecords =
        await _comparisonItemDao.getOverview(comparisonItemId);

    ///comparisonOverviewRecords=>comparisonOverview
    return _overviewResults = resultComparisonOverviewRecords
        .toComparisonOverviews(resultComparisonOverviewRecords);
  }

  ///保存
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
    try {
      ///ComparisonOverview=>ComparisonOverviewRecord
      final comparisonOverviewRecord =
          updateOverview.toComparisonOverviewRecord(updateOverview);
      await _comparisonItemDao
          .saveComparisonOverviewDB(comparisonOverviewRecord);
      print('comparisonOverviewRecord保存完了');
    } on SqliteException catch (e) {
      print('repository保存エラー:${e.toString()}');
    }
  }

//todo Read
//resultはComparisonItemRecord
//  result = await _comparisonItemDao.getJoinedItemList();
//List<ComparisonItemRecord>

//  CompareRepository({})
}
