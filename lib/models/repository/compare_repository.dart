import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:compare_2way/utils/extensions.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';

class CompareRepository {
  CompareRepository({ComparisonItemDao comparisonItemDao})
      : _comparisonItemDao = comparisonItemDao;

  final ComparisonItemDao _comparisonItemDao;
  List<ComparisonOverview> _overviewResults = <ComparisonOverview>[];
  ComparisonOverview _overviewResult;

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

  ///comparisonOverview=>ComparisonOverviewRecordへ変換保存
  Future<void> createComparisonOverview(
      ComparisonOverview comparisonOverview) async {
    try {
      final comparisonOverviewRecord =
          comparisonOverview.toComparisonOverviewRecord(comparisonOverview);
      await _comparisonItemDao
          .insertComparisonOverviewDB(comparisonOverviewRecord);
      print('comparisonOverviewを新規登録');
    } on SqliteException catch (e) {
      print('repositoryエラー:${e.toString()}');
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
  Future<void> saveComparisonItem(
      String comparisonItemId, ComparisonOverview updateOverview) async {
    try {
      ///ComparisonOverview=>ComparisonOverviewRecord
      final comparisonOverviewRecord =
          updateOverview.toComparisonOverviewRecord(updateOverview);
      //todo extensionsの中で一気にやる
      ///ComparisonOverviewRecord=>ComparisonOverviewRecordsCompanion
      final overviewCompanion = ComparisonOverviewRecordsCompanion(
        //アップデート要素がないものを入れるとnullでエラー(Companionに入れるのは値が更新できるものだけ)
//        dataId: Value(comparisonOverviewRecord.dataId),
        comparisonItemId: Value(comparisonOverviewRecord.comparisonItemId),
        itemTitle: Value(comparisonOverviewRecord.itemTitle),
        way1Title: Value(comparisonOverviewRecord.way1Title),
        way1MeritEvaluate: Value(comparisonOverviewRecord.way1MeritEvaluate),
        way1DemeritEvaluate:
            Value(comparisonOverviewRecord.way1DemeritEvaluate),
        way2Title: Value(comparisonOverviewRecord.way2Title),
        way2MeritEvaluate: Value(comparisonOverviewRecord.way2MeritEvaluate),
        way2DemeritEvaluate:
            Value(comparisonOverviewRecord.way2DemeritEvaluate),
//        favorite: Value(comparisonOverviewRecord.favorite),
        conclusion: Value(comparisonOverviewRecord.conclusion),
        createdAt: Value(comparisonOverviewRecord.createdAt),
      );

      await _comparisonItemDao.saveComparisonOverviewDB(
          comparisonItemId, overviewCompanion);
      print('comparisonOverviewRecord保存完了');
    } on SqliteException catch (e) {
      print('repository保存エラー:${e.toString()}');
    }
  }

  ///Read
  Future<List<ComparisonOverview>> getOverviewList() async {
    final comparisonOverviewRecords = await _comparisonItemDao.allOverviews;
    return _overviewResults = comparisonOverviewRecords
        .toComparisonOverviews(comparisonOverviewRecords);
  }

  Future<List<ComparisonOverview>> getList() async {
    final comparisonOverviewRecords = await _comparisonItemDao.allOverviews;
    return _overviewResults = comparisonOverviewRecords
        .toComparisonOverviews(comparisonOverviewRecords);
  }

  ///Delete
  Future<void> deleteList(String comparisonItemId) async {
//    final comparisonOverviewRecord =
    //todo Merit/Dmerit、Tagのリストも同時に削除必要
    await _comparisonItemDao.deleteList(comparisonItemId);
    print('データ削除完了');
  }

  ///List<ComparisonOverview>ではなく、comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<ComparisonOverview> getComparisonOverview(
      String comparisonItemId) async {
    final comparisonOverviewRecord =
        await _comparisonItemDao.getComparisonOverview(comparisonItemId);

    ///ComparisonOverviewRecord=>ComparisonOverview
    return _overviewResult =
        comparisonOverviewRecord.toComparisonOverview(comparisonOverviewRecord);
  }
}
