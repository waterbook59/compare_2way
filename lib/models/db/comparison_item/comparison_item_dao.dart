import 'package:moor/moor.dart';
import 'comparison_item_database.dart';

part 'comparison_item_dao.g.dart';

@UseDao(tables: [
  ComparisonOverviewRecords,
  Way1MeritRecords,
  Way1DemeritRecords,
  TagOverviewRecords,
  ComparisonItemIdRecords
])
class ComparisonItemDao extends DatabaseAccessor<ComparisonItemDB>
    with _$ComparisonItemDaoMixin {
  ComparisonItemDao(ComparisonItemDB itemDB) : super(itemDB);

  Future<List<ComparisonOverviewRecord>> get allOverviews =>
      select(comparisonOverviewRecords).get();

  ///新規作成:ComparisonOverview
  Future<void> insertComparisonOverviewDB(
          ComparisonOverviewRecord comparisonOverviewRecord) =>
      into(comparisonOverviewRecords).insert(comparisonOverviewRecord);

  ///新規作成:List<Way1Merit>
  Future<void> insertWay1MeritRecordDB(
      List<Way1MeritRecord> way1MeritItemRecords) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1MeritRecords, way1MeritItemRecords);
    });
    print('daoに新規作成');
  }

  ///更新:Way1Merit
  Future<void>updateWay1MeritRecordDB(
      Way1MeritRecord way1MeritItemRecord) async{
    print('リスト更新:${way1MeritItemRecord.way1MeritId}/'
        '${way1MeritItemRecord.way1MeritDesc}');
    return update(way1MeritRecords).replace(way1MeritItemRecord);

  }

  ///リスト１行新規追加：Way1Merit
  Future<void> insertWay1MeritRecordSingle(Way1MeritRecord way1MeritRecord)
  =>into(way1MeritRecords).insert(way1MeritRecord);


  Future<void> insertWay1DemeritRecordDB(
      List<Way1DemeritRecord> way1DemeritDescs) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1DemeritRecords, way1DemeritDescs);
    });
  }

  ///3つのテーブルにデータ格納
  Future<void> insertDB(
          ComparisonOverviewRecord comparisonOverviewRecord,
          List<Way1MeritRecord> way1MeritDescs,
          List<Way1DemeritRecord> way1DemeritDescs) =>
      transaction(() async {
        await insertComparisonOverviewDB(comparisonOverviewRecord);
        await insertWay1MeritRecordDB(way1MeritDescs);
        await insertWay1DemeritRecordDB(way1DemeritDescs);
      });

  //todo データ取得はあとで
  ///overviewとway1Meritを内部結合?(2個以上の複数テーブル結合の場合queryの中でinnerJoin繰り返す)
  Future<ComparisonItemRecord> getJoinedItemList() async {
    final query = select(comparisonOverviewRecords).join([
      innerJoin(
          way1MeritRecords,
          way1MeritRecords.comparisonItemId
              .equalsExp(comparisonOverviewRecords.comparisonItemId)),
      innerJoin(
          way1DemeritRecords,
          way1DemeritRecords.comparisonItemId
              .equalsExp(comparisonOverviewRecords.comparisonItemId)),
    ]);
    //print('query:${query.toString()}'); //queryはJoinedSelectStatement
    final rows = await query.get();
    final data = rows.map((resultRow) {
      return ComparisonItemRecord(
        comparisonOverviewRecord:
            resultRow.readTable(comparisonOverviewRecords),

        //行で入っているway1MeritRecordをList<Way1MeritRecord>にする必要あり
//        way1MeritRecord: resultRow.readTable(List<way1MeritRecords> as TableInfo),
//        way1DemeritRecord: resultRow.readTable(way1DemeritRecords),
      );
    });
//        .toList();
//    return data;
  }

  ///idをもとにway1タイトル、way2タイトルをとってくる
  /// 2.暗記済がfalse(暗記してないもの)だけを取ってくるクエリ
  //  Future<List<WordRecord>> get memorizedExcludeWords
  //  => (select(wordRecords)..where((t)=>t.isMemorized.equals(false))).get();
  Future<List<ComparisonOverviewRecord>> getOverview(String comparisonItemId) =>
      (select(comparisonOverviewRecords)
            ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();

  ///保存:comparisonOverview
  Future<void> saveComparisonOverviewDB(String comparisonItemId,
      ComparisonOverviewRecordsCompanion overviewCompanion) {
    return (update(comparisonOverviewRecords)
          ..where((it) => it.comparisonItemId.equals(comparisonItemId)))
        .write(overviewCompanion);
  }

  ///削除：comparisonOverview
  Future<void> deleteList(String comparisonItemId) =>
      //comparisonOverviewRecordsテーブルのcomparisonItemIdと
      // view側から持ってきたcomparisonItemIdが同じものを削除
      (delete(comparisonOverviewRecords)
            ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();

  ///削除：List<Way1Merit>
  Future<void> deleteWay1MeritList(String comparisonItemId)=>
      (delete(way1MeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();

  ///読込：comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<ComparisonOverviewRecord> getComparisonOverview(
          String comparisonItemId) =>
      (select(comparisonOverviewRecords)
            ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .getSingle();

  //todo way1,2 Merit/Demeritをtransactionでまとめてすっきり書く
  ///読込：idをもとにList<Way1MeritRecord>をとってくる
  Future<List<Way1MeritRecord>> getWay1MeritList(String comparisonItemId) =>
      (select(way1MeritRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();

  ///comparisonOverview,List<Way1Merit>をまとめて削除
  Future<void> deleteListAll(String comparisonItemId)=>
      transaction(() async{
      await deleteList(comparisonItemId);
      await deleteWay1MeritList(comparisonItemId);
    });




}
