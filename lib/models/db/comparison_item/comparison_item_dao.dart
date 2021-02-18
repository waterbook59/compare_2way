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

  //id,タイトル,評価等１行ですむもの
  Future<void> insertComparisonOverviewDB(
          ComparisonOverviewRecord comparisonOverviewRecord) =>
      into(comparisonOverviewRecords).insert(comparisonOverviewRecord);

  Future<void> insertWay1MeritRecordDB(
      List<Way1MeritRecord> way1MeritDescs) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1MeritRecords, way1MeritDescs);
    });
  }

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
  ///  //2.暗記済がfalse(暗記してないもの)だけを取ってくるクエリ
  //  Future<List<WordRecord>> get memorizedExcludeWords => (select(wordRecords)..where((t)=>t.isMemorized.equals(false))).get();
  Future<List<ComparisonOverviewRecord>> getOverview(String comparisonItemId)
  =>(select(comparisonOverviewRecords)
    ..where((t) =>t.comparisonItemId.equals(comparisonItemId))).get();






}
