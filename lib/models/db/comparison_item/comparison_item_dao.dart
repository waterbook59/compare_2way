import 'package:moor/moor.dart';
import 'comparison_item_database.dart';

part 'comparison_item_dao.g.dart';

@UseDao(tables: [
  ComparisonOverviewRecords,
  Way1MeritRecords,
  Way1DemeritRecords,
  Way2MeritRecords,
  Way2DemeritRecords,
  TagRecords,
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

  ///読込:ComparisonOverview(comparisonItemIdをもとにway1タイトル、way2タイトルをとってくる)
  Future<List<ComparisonOverviewRecord>> getOverview(String comparisonItemId) =>
      (select(comparisonOverviewRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();

  ///読込：comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<ComparisonOverviewRecord> getComparisonOverview(
      String comparisonItemId) =>
      (select(comparisonOverviewRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .getSingle();

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

  ///新規作成:List<Way1Merit>
  Future<void> insertWay1MeritRecordDB(
      List<Way1MeritRecord> way1MeritItemRecords) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1MeritRecords, way1MeritItemRecords);
    });
    print('daoに新規作成List<Way1Merit>');
  }
  ///新規作成:List<Way2Merit>
  Future<void> insertWay2MeritRecordDB(
      List<Way2MeritRecord> way2MeritItemRecords) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way2MeritRecords, way2MeritItemRecords);
    });
    print('daoに新規作成List<Way2Merit>');
  }

  //todo way1,2 Merit/Demeritをtransactionでまとめてすっきり書く
  ///読込：comparisonItemIdからList<Way1MeritRecord>をとってくる
  Future<List<Way1MeritRecord>> getWay1MeritList(String comparisonItemId) =>
      (select(way1MeritRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();
  ///読込：comparisonItemIdからList<Way2MeritRecord>をとってくる
  Future<List<Way2MeritRecord>> getWay2MeritList(String comparisonItemId) =>
      (select(way2MeritRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();


  ///更新:Way1Merit
  Future<void> updateWay1MeritRecordDB(
      Way1MeritRecord way1MeritItemRecord) async {
    print('リスト更新:${way1MeritItemRecord.way1MeritId}/'
        '${way1MeritItemRecord.way1MeritDesc}');
    return update(way1MeritRecords).replace(way1MeritItemRecord);
  }
  ///更新:Way2Merit
  Future<void> updateWay2MeritRecordDB(
      Way2MeritRecord way2MeritItemRecord) async {
    print('リスト更新:${way2MeritItemRecord.way2MeritId}/'
        '${way2MeritItemRecord.way2MeritDesc}');
    return update(way2MeritRecords).replace(way2MeritItemRecord);
  }

  ///リスト１行新規追加：Way1Merit
  Future<void> insertWay1MeritRecordSingle(Way1MeritRecord way1MeritRecord) =>
      into(way1MeritRecords).insert(way1MeritRecord);
  ///リスト１行新規追加：Way2Merit
  Future<void> insertWay2MeritRecordSingle(Way2MeritRecord way2MeritRecord) =>
      into(way2MeritRecords).insert(way2MeritRecord);

  ///リスト１行削除(DescFormAndButton)：Way1Merit
  Future<void> deleteWay1Merit(int way1MeritId) async {
    print('dao/way1Meritリスト削除:$way1MeritId');
    return (delete(way1MeritRecords)
      ..where((tbl) => tbl.way1MeritId.equals(way1MeritId)))
        .go();
  }

  ///リスト１行削除(DescFormAndButton)：Way2Merit
  Future<void> deleteWay2Merit(int way2MeritId) async {
    print('dao/way2Merit:$way2MeritId');
    return (delete(way2MeritRecords)
      ..where((tbl) => tbl.way2MeritId.equals(way2MeritId)))
        .go();
  }

  ///削除：List<Way1Merit>
  Future<void> deleteWay1MeritList(String comparisonItemId) =>
      (delete(way1MeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();
  Future<void> deleteWay2MeritList(String comparisonItemId) =>
      (delete(way2MeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();


  ///comparisonOverview,List<Way1Merit>をまとめて削除
  //todo Way1MeritList,Way2MeritListが削除できていない
  Future<void> deleteListAll(String comparisonItemId) =>
      transaction(() async {
        await deleteList(comparisonItemId);
        await deleteWay1MeritList(comparisonItemId);
        await deleteWay2MeritList(comparisonItemId);
      });

  Future<void> insertWay1DemeritRecordDB(
      List<Way1DemeritRecord> way1DemeritDescs) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1DemeritRecords, way1DemeritDescs);
    });
  }


  ///新規作成:List<TagRecord>:batchでやると重複登録されてしまうので
  ///1行ずつdao側でinsertOnConflictUpdate
  Future<void> insertTagRecordList(List<TagRecord> tagRecordList) async{
    
    await batch((batch) {
      batch.insertAll(tagRecords, tagRecordList);
    });
  print('dao/insertTagRecordList:$tagRecordList');

//   tagRecordList.forEach(
//     into(tagRecords).insertOnConflictUpdate
//    );
   
  }

  ///新規作成:List<TagRecord> 重複回避:
  ///https://moor.simonbinder.eu/docs/getting-started/writing_queries/
  //repository側でforEachしたものをinsertOnConflictUpdate
  //insertTagRecordListでもどちらでも良い(dao側、repository側どちらかでforEach)
  Future<void> createOrUpdateTag(TagRecord tagRecord) async{
    print('dao/createOrUpdateTag:$tagRecord');
    await into(tagRecords).insertOnConflictUpdate(tagRecord);
    }


  ///読込：comparisonItemIdからList<TagListRecord>を登録した古いもの順(asc)とってくる
  Future<List<TagRecord>> getTagList(String comparisonItemId) =>
      (select(tagRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId))
        //asc時間古い順
      ///createdAtだと登録桁数が少なすぎて2つ以上登録の場合綺麗なasc順にならないので、createAtToString順でとってくる
        ..orderBy([(t)=>OrderingTerm(expression:
        t.createAtToString,mode: OrderingMode.asc)])
      ).get();

  ///削除：List<Tag> comparisonItemIdとtagTitleの２つの条件のもののみ削除
  Future<void> deleteTagList(List<TagRecord> deleteTagRecordList){
    deleteTagRecordList.forEach((tag) {
      (delete(tagRecords)..where(
              (tbl) => tbl.comparisonItemId.equals(tag.comparisonItemId)
              & tbl.tagTitle.equals(tag.tagTitle))).go();
    });
    print('dao/削除');
  }
  ///削除：List<Tag> CompareScreenを削除時、comparisonItemIdのtag全削除
  Future<void> deleteAllTagList(String comparisonItemId) =>
      (delete(tagRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();





}
