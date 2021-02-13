
import 'package:moor/moor.dart';

part 'comparison_item_database.g.dart';

//テーブルcomparison_item
class ComparisonItemRecords extends Table{
  IntColumn get dataId =>integer().autoIncrement()();
  TextColumn get itemTitle => text()();

  TextColumn get way1Title => text()();
  TextColumn get way1Merit => text().nullable()();
  TextColumn get way1Demerit => text().nullable()();
  IntColumn get way1Evaluate
  =>integer().withDefault(const Constant(0))();// 評価、初期ゼロ

  TextColumn get way2Title => text()();
  TextColumn get way2Merit => text().nullable()();
  TextColumn get way2Demerit => text().nullable()();
  IntColumn get way2Evaluate
  =>integer().withDefault(const Constant(0))();// 評価、初期ゼロ

  TextColumn get way3Title => text()();
  TextColumn get way3Merit => text().nullable()();
  TextColumn get way3Demerit => text().nullable()();
  IntColumn get way3Evaluate
  =>integer().withDefault(const Constant(0))();// 評価、初期ゼロ

  TextColumn get tags => text().nullable()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  TextColumn get conclusion => text().nullable()();

  @override
  Set<Column> get primaryKey => {dataId};
}

//テーブルway1Merit
//テーブルway1Demerit
//テーブルway2Merit
//テーブルway2Demerit
//テーブルtags


@UseMoor(tables:[ComparisonItemRecords])
class CompareListDB