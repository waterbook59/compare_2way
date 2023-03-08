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
  TagChartRecords,
],)
class ComparisonItemDao extends DatabaseAccessor<ComparisonItemDB>
    with _$ComparisonItemDaoMixin {
  ComparisonItemDao(ComparisonItemDB itemDB) : super(itemDB);

  Future<List<ComparisonOverviewRecord>> get allOverviews =>
      select(comparisonOverviewRecords).get();

  ///新規作成:ComparisonOverview
  Future<void> insertComparisonOverviewDB({
    required ComparisonOverviewRecordsCompanion newCompanion,
}) =>
      // into(comparisonOverviewRecords).insert(comparisonOverviewRecord);
  into(comparisonOverviewRecords).insert(newCompanion);


  ///読込:ComparisonOverview(comparisonItemIdをもとにway1タイトル、way2タイトルをとってくる)
  Future<List<ComparisonOverviewRecord>> getOverview(String comparisonItemId) =>
      (select(comparisonOverviewRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();

  ///読込：comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<ComparisonOverviewRecord> getComparisonOverview(
      String comparisonItemId,) =>
      (select(comparisonOverviewRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .getSingle();

  ///保存:comparisonOverview
  Future<void> saveComparisonOverviewDB({
      required ComparisonOverviewRecordsCompanion overviewCompanion,
    required String comparisonItemId,}) {
    return (update(comparisonOverviewRecords)
      ..where((it) => it.comparisonItemId.equals(comparisonItemId )))
        .write(overviewCompanion);
  }

  ///削除：comparisonOverview
  Future<void> deleteItem(String comparisonItemId) =>
      //comparisonOverviewRecordsテーブルのcomparisonItemIdと
  // view側から持ってきたcomparisonItemIdが同じものを削除
  (delete(comparisonOverviewRecords)
    ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
      .go();

  ///新規作成:List<Way1Merit>
  Future<void> insertWay1MeritRecordDB(
      List<Way1MeritRecordsCompanion> way1MeritItemRecords,) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1MeritRecords, way1MeritItemRecords);
    });
    print('daoに新規作成List<Way1Merit>');
  }
  ///新規作成:List<Way2Merit>
  Future<void> insertWay2MeritRecordDB(
      List<Way2MeritRecordsCompanion> way2MeritItemRecords,) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way2MeritRecords, way2MeritItemRecords);
    });
    print('daoに新規作成List<Way2Merit>');
  }
  ///新規作成:List<Way1Demerit>
  Future<void> insertWay1DemeritRecordDB(
      List<Way1DemeritRecordsCompanion> way1DemeritItemRecords,) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way1DemeritRecords, way1DemeritItemRecords);
    });
  }
  ///新規作成:List<Way2Demerit>
  Future<void> insertWay2DemeritRecordDB(
      List<Way2DemeritRecordsCompanion> way2DemeritItemRecords,) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(way2DemeritRecords, way2DemeritItemRecords);
    });
  }
  //todo 新規作成:List<Way3Merit>
  //todo 新規作成:List<Way3Demerit>


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
  ///読込：comparisonItemIdからList<Way1DemeritRecord>をとってくる
  Future<List<Way1DemeritRecord>> getWay1DemeritList(String comparisonItemId) =>
      (select(way1DemeritRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();
  ///読込：comparisonItemIdからList<Way2DemeritRecord>をとってくる
  Future<List<Way2DemeritRecord>> getWay2DemeritList(String comparisonItemId) =>
      (select(way2DemeritRecords)
        ..where((t) => t.comparisonItemId.equals(comparisonItemId)))
          .get();


  ///更新:Way1Merit
  Future<bool> updateWay1MeritRecordDB(
      Way1MeritRecord way1MeritItemRecord,) async {
    print('リスト更新:${way1MeritItemRecord.way1MeritId}/'
        '${way1MeritItemRecord.way1MeritDesc}');
    return update(way1MeritRecords).replace(way1MeritItemRecord);
  }
  ///更新:Way2Merit
  Future<bool> updateWay2MeritRecordDB(
      Way2MeritRecord way2MeritItemRecord,) async {
    print('リスト更新:${way2MeritItemRecord.way2MeritId}/'
        '${way2MeritItemRecord.way2MeritDesc}');
    return update(way2MeritRecords).replace(way2MeritItemRecord);
  }
  ///更新:Way3Merit
//  Future<void> updateWay3MeritRecordDB(
//      Way3MeritRecord way3MeritItemRecord) async {
//    return update(way3MeritRecords).replace(way3MeritItemRecord);
//  }
  ///更新:Way1Demerit
  Future<bool> updateWay1DemeritRecordDB(
      Way1DemeritRecord way1DemeritItemRecord,) async {
    print('リスト更新:${way1DemeritItemRecord.way1DemeritId}/'
        '${way1DemeritItemRecord.way1DemeritDesc}');
    return update(way1DemeritRecords).replace(way1DemeritItemRecord);
  }
  ///更新:Way2Demerit
  Future<bool> updateWay2DemeritRecordDB(
      Way2DemeritRecord way2DemeritItemRecord,) async {
    return update(way2DemeritRecords).replace(way2DemeritItemRecord);
  }
  ///更新:Way3Demerit
//  Future<void> updateWay3DemeritRecordDB(
//      Way3DemeritRecord way3DemeritItemRecord) async {
//    return update(way3DemeritRecords).replace(way3DemeritItemRecord);
//  }


  ///リスト１行新規追加：Way1Merit
  Future<void> insertWay1MeritRecordSingle(Way1MeritRecord way1MeritRecord) =>
      into(way1MeritRecords).insert(way1MeritRecord);
  ///リスト１行新規追加：Way2Merit
  Future<void> insertWay2MeritRecordSingle(Way2MeritRecord way2MeritRecord) =>
      into(way2MeritRecords).insert(way2MeritRecord);
  ///リスト１行新規追加：Way1Demerit
  Future<void> insertWay1DemeritRecordSingle(
      Way1DemeritRecord way1DemeritRecord,) =>
      into(way1DemeritRecords).insert(way1DemeritRecord);
  ///リスト１行新規追加：Way1Demerit
  Future<void> insertWay2DemeritRecordSingle(
      Way2DemeritRecord way2DemeritRecord,) =>
      into(way2DemeritRecords).insert(way2DemeritRecord);
  //todo way3Merit/Demerit



  ///リスト１行削除(DescFormAndButton)：Way1Merit
  Future<int> deleteWay1Merit(int way1MeritId) async {
    print('dao/way1Meritリスト削除:$way1MeritId');
    return (delete(way1MeritRecords)
      ..where((tbl) => tbl.way1MeritId.equals(way1MeritId)))
        .go();
  }
  ///リスト１行削除(DescFormAndButton)：Way2Merit
  Future<int> deleteWay2Merit(int way2MeritId) async {
    print('dao/way2Merit:$way2MeritId');
    return (delete(way2MeritRecords)
      ..where((tbl) => tbl.way2MeritId.equals(way2MeritId)))
        .go();
  }
  ///リスト１行削除(DescFormAndButton)：Way1Demerit
  Future<int> deleteWay1Demerit(int way1DemeritId) async {
    print('dao/way1Demeritリスト削除:$way1DemeritId');
    return (delete(way1DemeritRecords)
      ..where((tbl) => tbl.way1DemeritId.equals(way1DemeritId)))
        .go();
  }
  ///リスト１行削除(DescFormAndButton)：Way2Demerit
  Future<int> deleteWay2Demerit(int way2DemeritId) async {
    print('dao/way1Demeritリスト削除:$way2DemeritId');
    return (delete(way2DemeritRecords)
      ..where((tbl) => tbl.way2DemeritId.equals(way2DemeritId)))
        .go();
  }
  //todo way3Merit/Demerit

  ///削除：List<Way1Merit>
  Future<void> deleteWay1MeritList(String comparisonItemId) =>
      (delete(way1MeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();
  ///削除：List<Way2Merit>
  Future<void> deleteWay2MeritList(String comparisonItemId) =>
      (delete(way2MeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();
  ///削除：List<Way3Merit>  //todo way3Merit
//  Future<void> deleteWay3MeritList(String comparisonItemId) =>
//      (delete(way3MeritRecords)
//        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
//          .go();
  ///削除：List<Way1Demerit>
  Future<void> deleteWay1DemeritList(String comparisonItemId) =>
      (delete(way1DemeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();
  ///削除：List<Way2Demerit>
  Future<void> deleteWay2DemeritList(String comparisonItemId) =>
      (delete(way2DemeritRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();
  ///削除：List<Way3Demerit>  //todo way3Demerit
//  Future<void> deleteWay3DemeritList(String comparisonItemId) =>
//      (delete(way3DemeritRecords)
//        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
//          .go();



  ///comparisonOverview,List<Way1Merit>をまとめて削除
  //todo Way1MeritList,Way2MeritListが削除できていない
  Future<void> deleteListAll(String comparisonItemId) =>
      transaction(() async {
        await deleteItem(comparisonItemId);
        await deleteWay1MeritList(comparisonItemId);
        await deleteWay2MeritList(comparisonItemId);
      });




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
        t.createAtToString,mode: OrderingMode.asc,)])
      ).get();

  ///削除：List<Tag> comparisonItemIdとtagTitleの２つの条件のもののみ削除
  //todo forEach=>map.toList
  //todo TagDialogPageの削除はdeleteSingleTagListとかに名前変更
  Future<void> deleteTagList(List<TagRecord> deleteTagRecordList)async {
    deleteTagRecordList.forEach((tag) {
      (delete(tagRecords)..where(
              (tbl) => tbl.comparisonItemId.equals(tag.comparisonItemId)
              & tbl.tagTitle.equals(tag.tagTitle),)).go();
    });
    print('dao/削除');
  }
  ///削除：List<Tag> CompareScreenを削除時、comparisonItemIdのtag全削除
  Future<void> deleteAllTagList(String comparisonItemId) =>
      (delete(tagRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)))
          .go();

  ///読込：全タグ情報取得
  Future<List<TagRecord>> getAllTagList() =>
      (select(tagRecords)..orderBy([(t)=>OrderingTerm(expression:
      t.createAtToString,mode: OrderingMode.asc,)])).get();

  ///読込：選択タグ情報取得 tagTitleから登録順に返す
  //なぜか取得できない=>async/awaitではなくreturnがよかったみたい
  Future<List<TagRecord>> onSelectTag(String tagTitle) {
    return (select(tagRecords)
            ..where((tbl) => tbl.tagTitle.equals(tagTitle))
            ..orderBy([(t)=>OrderingTerm(expression:
            t.createAtToString,mode: OrderingMode.asc,)])
    ).get();

  }

  ///編集 タグタイトル     saveComparisonOverviewDB参考
  //idListではなく、tagIdも入れたList<TagRecord>でcomparisonItemId & tagIdが一致したものだけ上書き
  Future<void> updateTagTitle(
      List<TagRecord> selectTagRecordList,
      TagRecordsCompanion tagRecordCompanion,) async{

  //comparisonItemIdとtagIdを元にタイトルを編集(参照:deleteTagList)
  //Future内でforEach回そうとするとエラー=>Future.forEachへ変更
    await Future.forEach(selectTagRecordList,(TagRecord tag) {
      (update(tagRecords)
        ..where((tbl) => tbl.comparisonItemId.equals(tag.comparisonItemId)
        & tbl.tagId.equals(tag.tagId)
        ,))
          .write(tagRecordCompanion);
    });
  }

  ///削除：Tag tagPageでのtagTitleを削除
  Future<void> onDeleteTag(TagRecord deleteTagRecord) =>
      (delete(tagRecords)
        ..where((tbl) => tbl.tagTitle.equals(deleteTagRecord.tagTitle)))
          .go();

  ///削除：Tag tagPageでの選択したtagTitleを削除
  Future<void> deleteSelectTagList(List<TagRecord> deleteTagRecordList)async{
    await Future.forEach(deleteTagRecordList,(TagRecord tag) {
      (delete(tagRecords)
        ..where((tbl) => tbl.tagTitle.equals(tag.tagTitle)))
          .go();
    });

  }


  ///並び替え保存:comparisonOverview
  Future<int> changeCompareListOrder(
      String comparisonItemId,
      ComparisonOverviewRecordsCompanion overviewCompanion,) async{

//    print('並び替え:dao');
    return (update(comparisonOverviewRecords)
      ..where((it) => it.comparisonItemId.equals(comparisonItemId)))
        .write(overviewCompanion);
  }

  ///新規作成:List<TagChart>登録(dataIdはincrement)&tagTitle同じものは更新
  Future<void> createTagChart(
      List<TagChartRecordsCompanion> tagChartRecordList,) async {
    await Future.forEach(tagChartRecordList,(TagChartRecordsCompanion tagChart){
      into(tagChartRecords).insertOnConflictUpdate(tagChart);
    });
  }

  ///更新:List<TagChart>tagTitleに紐づいて数量を更新
  Future<void> updateTagChart(
      List<String> tagTitleList,
      TagChartRecordsCompanion updateTagRecordCompanion
      ,) async {
    ///tagChartRecordListからはtagTitleのリストさえ手に入れば良い。

    await Future.forEach(tagTitleList,(String title) {
      (update(tagChartRecords)
        ..where((tbl) => tbl.tagTitle.equals(title)
        ,))
          .write(updateTagRecordCompanion);
    });
  }

  ///更新:TagChart tagTitle編集・更新
  Future<void> updateTagChartTitle(
      TagChartRecord tagChartRecord,
      TagChartRecordsCompanion updateTagRecordCompanion
      ,) async {
//    await Future.forEach(tagChartRecordList,(TagChartRecord tagChart) {
      await (update(tagChartRecords)
        ..where((tbl) => tbl.dataId.equals(tagChartRecord.dataId)
        ,))
          .write(updateTagRecordCompanion);
//    });
  }

  ///読込：tagTitleからTagChart返す(１行だけ取ってくる)
  Future<TagChartRecord> getTagChart(String title) {
    return (select(tagChartRecords)
      ..where((t) => t.tagTitle.equals(title)
      ,)).getSingle();
  }

  ///削除：TagChart tagTitleから削除
  Future<void> removeTagChart(List<String> removeTagTitleList
      ,)async{
    await Future.forEach(removeTagTitleList,(String removeTagTitle) {
      (delete(tagChartRecords)
        ..where((tbl) => tbl.tagTitle.equals(removeTagTitle)))
          .go();
    });
  }

  ///読込：全TagChart情報取得
  Future<List<TagChartRecord>>  getAllTagChartList() =>
      select(tagChartRecords).get();

  ///並び替え保存:TagChart
  Future<int> changeTagListOrder(String itemTagTitle,
      TagChartRecordsCompanion tagChartCompanion,) async{
    return (update(tagChartRecords)
      ..where((it) => it.tagTitle.equals(itemTagTitle)))
        .write(tagChartCompanion);
  }

  ///削除：TagChart 全削除
  Future<void> allDeleteTagChartList()async{
    await delete(tagChartRecords).go();
  }
///新規作成：TagChart全登録
  Future<void> allCreateTagChartList(List<TagChartRecord> tagChartRecordList)
  async{
    await batch((batch) {
      batch.insertAll(tagChartRecords, tagChartRecordList);
    });
//    print('dao/insertTagRecordList:${tagChartRecordList.map((e) => e.tagTitle)}');
  }


  ///読込：comparisonItemIdからList<ComparisonOverviewRecord>を(１行だけ取ってくる)
  Future<ComparisonOverviewRecord> getOverviewRecord(
      String comparisonItemId,) {
    return (select(comparisonOverviewRecords)
      ..where((tbl) => tbl.comparisonItemId.equals(comparisonItemId)
      ,)).getSingle();
  }

  ///削除：List<ComparisonOverviewRecord> 全削除
  Future<void> allDeleteItemtList()async{
    await delete(comparisonOverviewRecords).go();
    }
  ///新規作成:List<ComparisonOverviewRecord> 全登録
  Future<void> allCreateItemList(
      List<ComparisonOverviewRecord> itemRecordList,) async {
    //2行以上の可能性あり
    await batch((batch) {
      batch.insertAll(comparisonOverviewRecords, itemRecordList);
    });
  }







}
