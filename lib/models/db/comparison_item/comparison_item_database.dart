import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'comparison_item_dao.dart';
part 'comparison_item_database.g.dart';

///comparison_item結合(ComparisonOverviewRecords+Way1MeritRecords+..+TagRecords)
class ComparisonOverviewRecords extends Table {
  IntColumn get dataId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()(); //UuIdで他のテーブルとの結合に使用の可能性
  TextColumn get itemTitle => text()();

  TextColumn get way1Title => text()();
  IntColumn get way1MeritEvaluate =>
      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ
  IntColumn get way1DemeritEvaluate =>
      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ

  //todo way2テーブルはあとで追加
  TextColumn get way2Title => text()();
  IntColumn get way2MeritEvaluate => integer().withDefault(const Constant(0))();
  IntColumn get way2DemeritEvaluate =>
      integer().withDefault(const Constant(0))();

//  TextColumn get way2Merit => text().nullable()();
//  TextColumn get way2Demerit => text().nullable()();

//  TextColumn get way3Title => text().nullable()();
//  TextColumn get way3Merit => text().nullable()();
//  TextColumn get way3Demerit => text().nullable()();
//  IntColumn get way3MeritEvaluate
//  =>integer().withDefault(const Constant(0))();
//  IntColumn get way3DemeritEvaluate =>
//      integer().withDefault(const Constant(0))();

//  TextColumn get tags => text().nullable()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  TextColumn get conclusion => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {dataId};


}

//テーブルway1Merit
//comparisonItemIdをテーブル紐付けに使う
class Way1MeritRecords extends Table {
  IntColumn get way1MeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way1MeritDesc => text().nullable()();
  @override
  Set<Column> get primaryKey => {way1MeritId};
}
//テーブルway1Demerit
class Way1DemeritRecords extends Table {
  IntColumn get way1DemeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way1DemeritDesc => text().nullable()();
  @override
  Set<Column> get primaryKey => {way1DemeritId};
}
//テーブルway2Merit
//テーブルway2Demerit
//テーブルtags
//class TagTitleRecords extends Table{
//  TextColumn get comparisonItemId => text()();
//}

///タグ結合(TagRecords=TagOverviewRecords+ComparisonItemIdRecords)
class TagOverviewRecords extends Table {
  //autoIncrementのidあった方がいいかも
  TextColumn get tagId => text()(); //タグを結合するためにComparisonItemIdとは別のUuid
  TextColumn get tagTitle => text()();
}

class ComparisonItemIdRecords extends Table {
  TextColumn get tagId => text()();
  TextColumn get comparisonItemId => text()();
}

//タグ結合クラス
class TagRecords {
  TagRecords({this.tagOverviewRecords, this.comparisonItemIds,});
  final TagOverviewRecords tagOverviewRecords;
  final ComparisonItemIdRecords comparisonItemIds;

}

///comparison_item結合クラス
class ComparisonItemRecord {
  ComparisonItemRecord({
    this.comparisonOverviewRecord,
    this.way1MeritRecord,
    this.way1DemeritRecord,
//    this.tagRecord
  });

  final ComparisonOverviewRecord comparisonOverviewRecord;
  final List<Way1MeritRecord> way1MeritRecord;
  final List<Way1DemeritRecord> way1DemeritRecord;
//  final TagRecord tagRecord;


}


@UseMoor(tables: [
  ComparisonOverviewRecords,
  Way1MeritRecords,
  Way1DemeritRecords,
  TagOverviewRecords,
  ComparisonItemIdRecords
],daos: [ComparisonItemDao])
class ComparisonItemDB  extends _$ComparisonItemDB{
  ComparisonItemDB() : super(_openConnection());


  ///リリース後の項目編集はschemaVersionのupdateとMigrationが必須
  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {

  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    //Fileはdart.ioインポート
    final file = File(p.join(dbFolder.path, 'comparison_item.db'));
    return VmDatabase(file);
  });
}