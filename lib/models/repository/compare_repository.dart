import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
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
  List<Way1Merit> _way1MeritList = <Way1Merit>[];
  List<Way2Merit> _way2MeritList = <Way2Merit>[];


  ///新規作成 comparisonOverview
  Future<void> createComparisonOverview(
      ComparisonOverview comparisonOverview) async {
    try {
      //comparisonOverview=>ComparisonOverviewRecordへ変換保存
      final comparisonOverviewRecord =
          comparisonOverview.toComparisonOverviewRecord(comparisonOverview);
      await _comparisonItemDao
          .insertComparisonOverviewDB(comparisonOverviewRecord);
      print('comparisonOverviewを新規登録');
    } on SqliteException catch (e) {
      print('repositoryエラー:${e.toString()}');
    }
  }

  ///更新 comparisonOverview
  Future<void> updateComparisonOverView(ComparisonOverview updateOverview)async{
  try{
    //更新プロパティ以外のdataIdとかは値入ってないのでnull
    final comparisonOverviewRecord =
    updateOverview.toComparisonOverviewRecord(updateOverview);
    final overviewCompanion = ComparisonOverviewRecordsCompanion(
      //アップデート要素がないものを入れるとnullでエラー(Companionに入れるのは値が更新できるものだけ)
      comparisonItemId: Value(comparisonOverviewRecord.comparisonItemId),
      itemTitle: Value(comparisonOverviewRecord.itemTitle),
      way1Title: Value(comparisonOverviewRecord.way1Title),
      way2Title: Value(comparisonOverviewRecord.way2Title),
      createdAt: Value(comparisonOverviewRecord.createdAt),
    );
    await _comparisonItemDao.saveComparisonOverviewDB(
        comparisonOverviewRecord.comparisonItemId, overviewCompanion);

  }on SqliteException catch (e) {
    print('repository更新エラー:${e.toString()}');
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

  ///保存 comparisonOverview
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
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
          comparisonOverviewRecord.comparisonItemId, overviewCompanion);
      print('comparisonOverviewRecord保存完了');
    } on SqliteException catch (e) {
      print('repository保存エラー:${e.toString()}');
    }
  }

  ///Read comparisonOverview
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

//    //todo Merit/Dmerit、Tagのリストも同時に削除必要(transaction)
//    await _comparisonItemDao.deleteListAll(comparisonItemId);
    await _comparisonItemDao.deleteList(comparisonItemId);
    await _comparisonItemDao.deleteWay1MeritList(comparisonItemId);
    await _comparisonItemDao.deleteWay2MeritList(comparisonItemId);
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

  ///ComparisonItem=>ComparisonOverviewRecord,List<Way1Merit>に分解登録

  //todo createComparisonOverviewと結合
  ///新規作成 way1MeritList,way2MeritList
  Future<void> createDescList(
      List<Way1Merit> way1MeritList, List<Way2Merit> way2MeritList) async {
    try {
      ///way1Merit 1行の場合
//      final way1MeritRecord = way1Merit.toWay1MeritRecord(way1Merit);
      ///List<way1Merit>の場合
      final way1MeritItemRecords =
          way1MeritList.toWay1InitMeritRecordList(way1MeritList);
      final way2MeritItemRecords =
      way2MeritList.toWay2InitMeritRecordList(way2MeritList);

      await _comparisonItemDao.insertWay1MeritRecordDB(way1MeritItemRecords);
      await _comparisonItemDao.insertWay2MeritRecordDB(way2MeritItemRecords);
      print('List<Way1Merit>を新規登録');
    } on SqliteException catch (e) {
      print('repositoryエラー:${e.toString()}');
    }
  }

  ///Read List<Way1Merit>
  Future<List<Way1Merit>> getWay1MeritList(String comparisonItemId) async {
    //comparisonItemIdを元に得られたList<Way1MeritRecord>をList<Way1Merit>へ変換する
    final way1MeritRecordList =
        await _comparisonItemDao.getWay1MeritList(comparisonItemId);
    return _way1MeritList =
        way1MeritRecordList.toWay1MeritList(way1MeritRecordList);
  }
  ///Read List<Way2Merit>
  Future<List<Way2Merit>> getWay2MeritList(String comparisonItemId) async {
    final way2MeritRecordList =
    await _comparisonItemDao.getWay2MeritList(comparisonItemId);
    return _way2MeritList =
        way2MeritRecordList.toWay2MeritList(way2MeritRecordList);
  }

  ///保存 変更したWay1Merit=>変更したWay1Meritだけ更新
  //変更前：List<Way1Merit>=>変更したWay1Meritだけ更新
  Future<void> setWay1MeritDesc(Way1Merit updateWay1Merit, int index) async {
    try {
      ///List<way1Merit>=>List<Way1MeritRecord>の場合
//      final way1MeritItemRecords = way1MeritList.toWay1MeritRecordList(
//          way1MeritList);
      ///Way1Merit=>Way1MeritRecordの場合
      final way1MeritRecord =
          updateWay1Merit.toUpdateWay1MeritRecord(updateWay1Merit);
      await _comparisonItemDao.updateWay1MeritRecordDB(
//          way1MeritItemRecords[index]);
          way1MeritRecord);
    } on SqliteException catch (e) {
      print('repositoryエラー:${e.toString()}');
    }
  }

  ///保存 Way2Merit一部変更=>変更行だけ更新
  Future<void> setWay2MeritDesc(Way2Merit updateWay2Merit, int index) async{
    try{
      final way2MeritRecord =
      updateWay2Merit.toUpdateWay2MeritRecord(updateWay2Merit);
      await _comparisonItemDao.updateWay2MeritRecordDB(
          way2MeritRecord);
    }on SqliteException catch (e) {
      print('repository/setWay2MeritDescエラー:${e.toString()}');
    }
  }

  ///リスト１行追加：Way1Merit
  Future<void> addWay1Merit(Way1Merit initWay1Merit) async {
    //1行だけ差し込めるか
    try {
      final way1MeritRecord =
          initWay1Merit.toCreateWay1MeritRecord(initWay1Merit);
      await _comparisonItemDao.insertWay1MeritRecordSingle(way1MeritRecord);
      print('repository:リスト１行新規追加');
    } on SqliteException catch (e) {
      print('Way1Merit追加エラー:${e.toString()}');
    }
  }
  ///リスト１行追加：Way2Merit
  Future<void> addWay2Merit(Way2Merit initWay2Merit) async {
    try {
      final way2MeritRecord =
      initWay2Merit.toCreateWay2MeritRecord(initWay2Merit);
      await _comparisonItemDao.insertWay2MeritRecordSingle(way2MeritRecord);
      print('repository:リストWay2Merit１行新規追加');
    } on SqliteException catch (e) {
      print('Way2Merit追加エラー:${e.toString()}');
    }
  }

  ///リスト1行削除:Way1Merit
  Future<void> deleteWay1Merit(int way1MeritId) async {
    await _comparisonItemDao.deleteWay1Merit(way1MeritId);
  }
  ///リスト1行削除:Way2Merit
  Future<void> deleteWay2Merit(int way2MeritId) async {
    await _comparisonItemDao.deleteWay2Merit(way2MeritId);
  }




}
