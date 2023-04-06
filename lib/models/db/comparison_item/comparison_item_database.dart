import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'comparison_item_dao.dart';

part 'comparison_item_database.g.dart';

///comparison_item結合(ComparisonOverviewRecords+Way1MeritRecords+..+TagRecords)
class ComparisonOverviewRecords extends Table {
  IntColumn get dataId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()(); //UuIdで他のテーブルとの結合に使用の可能性
  TextColumn get itemTitle => text()();
  ///way1
  TextColumn get way1Title => text()();
  IntColumn get way1MeritEvaluate =>
      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ
  IntColumn get way1DemeritEvaluate =>
      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ
  ///way2
  TextColumn get way2Title => text()();
  IntColumn get way2MeritEvaluate => integer().withDefault(const Constant(0))();
  IntColumn get way2DemeritEvaluate =>
      integer().withDefault(const Constant(0))();

  /// //todo way3はあとで追加
//  TextColumn get way3Title => text()();
//  IntColumn get way3MeritEvaluate =>
//      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ
//  IntColumn get way3DemeritEvaluate =>
//      integer().withDefault(const Constant(0))();

//  TextColumn get tags => text().nullable()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  TextColumn get conclusion => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  ///unique制約外し
//  @override
//  Set<Column> get primaryKey => {dataId};

}

//テーブルway1Merit
//comparisonItemIdをテーブル紐付けに使う
class Way1MeritRecords extends Table {
  IntColumn get way1MeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way1MeritDesc => text().nullable()();
  @override
  Set<Column<dynamic>> get primaryKey => {way1MeritId};
}
//テーブルway1Demerit
class Way1DemeritRecords extends Table {
  IntColumn get way1DemeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way1DemeritDesc => text().nullable()();
  @override
  Set<Column<dynamic>> get primaryKey => {way1DemeritId};
}
//テーブルway2Merit
class Way2MeritRecords extends Table {
  IntColumn get way2MeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way2MeritDesc => text().nullable()();
  @override
  Set<Column<dynamic>> get primaryKey => {way2MeritId};
}
//テーブルway2Demerit
class Way2DemeritRecords extends Table {
  IntColumn get way2DemeritId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get way2DemeritDesc => text().nullable()();
  @override
  Set<Column<dynamic>> get primaryKey => {way2DemeritId};
}
//テーブルtag
class TagRecords extends Table{
  IntColumn get tagId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()();
  TextColumn get tagTitle => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get createAtToString => text()();
  //tagTitleの重複登録必要なのでprimaryKeyには設定しない
  @override
  Set<Column<dynamic>> get primaryKey => {tagId};
}
//テーブルtagChart
class TagChartRecords extends Table{
  IntColumn get dataId => integer().autoIncrement()();
  TextColumn get tagTitle => text()();
  IntColumn get tagAmount => integer().nullable()();
  //tagTitleをKeyにするとdataIdのautoIncrementが反映されない
//  @override
//  Set<Column> get primaryKey => {tagTitle};

}

/// //todo @DriftDatabase
@UseMoor(tables: [
  ComparisonOverviewRecords,
  Way1MeritRecords,
  Way1DemeritRecords,
  Way2MeritRecords,
  Way2DemeritRecords,
  TagRecords,
  TagChartRecords,
],daos: [ComparisonItemDao],)
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
    /// //todo DriftではNativeDatabase
    return VmDatabase(file);
  });
}
