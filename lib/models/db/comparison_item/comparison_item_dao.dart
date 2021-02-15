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

  ///overviewとway1Meritを内部結合?(2個以上の複数テーブル結合の場合queryの中でinnerJoin繰り返す)
  Future<List<ComparisonItemRecord>> getJoinedItemList() async {
    final query = select(productRecords).join([
      innerJoin(productRecordImages,
          productRecordImages.productId.equalsExp(productRecords.productId)),
    ]);
    //print('query:${query.toString()}'); //queryはJoinedSelectStatement
    final rows = await query.get();
    final data = rows.map((resultRow) {
      return JoinedProduct(
        productRecord: resultRow.readTable(productRecords),
        productRecordImage: resultRow.readTable(productRecordImages),
      );
    }).toList();
    return data;
  }








}
