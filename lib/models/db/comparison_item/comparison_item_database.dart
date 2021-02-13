import 'package:moor/moor.dart';

part 'comparison_item_database.g.dart';

///comparison_item結合(ComparisonOverviewRecords+Way1MeritRecords+..+TagRecords)
class ComparisonOverviewRecords extends Table {
  IntColumn get dataId => integer().autoIncrement()();
  TextColumn get comparisonItemId => text()(); //UuIdで他のテーブルとの結合に使用の可能性
  TextColumn get itemTitle => text()();

  TextColumn get way1Title => text()();
  TextColumn get way1Demerit => text().nullable()();
  IntColumn get way1Evaluate =>
      integer().withDefault(const Constant(0))(); // 評価、初期ゼロ

  //todo way2テーブルはあとで追加
  TextColumn get way2Title => text()();

//  TextColumn get way2Merit => text().nullable()();
//  TextColumn get way2Demerit => text().nullable()();
  IntColumn get way2Evaluate => integer().withDefault(const Constant(0))();

//  TextColumn get way3Title => text().nullable()();
//  TextColumn get way3Merit => text().nullable()();
//  TextColumn get way3Demerit => text().nullable()();
//  IntColumn get way3Evaluate
//  =>integer().withDefault(const Constant(0))();// 評価、初期ゼロ

  TextColumn get tags => text().nullable()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  TextColumn get conclusion => text().nullable()();
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
class TagOverviewRecords extends Table{
  //autoIncrementのidあった方がいいかも
  TextColumn get tagId => text()();//タグを結合するためにComparisonItemIdとは別のUuid
  TextColumn get tagTitle => text()();
}

class ComparisonItemIdRecords extends Table{
  TextColumn get tagId => text()();
  TextColumn get comparisonItemId => text()();
}

//タグ結合クラス
class TagRecords{
  TagRecords({this.tagOverviewRecords, this.comparisonItemIds,});
  final TagOverviewRecords tagOverviewRecords;
  final ComparisonItemIdRecords comparisonItemIds;

}

///comparison_item結合クラス
class ComparisonItemRecords {
  ComparisonItemRecords(
      {this.comparisonOverviewRecords,
        this.way1meritRecords,
        this.way1DemeritRecords,
      this.tagRecords});

  final ComparisonOverviewRecords comparisonOverviewRecords;
  final Way1MeritRecords way1meritRecords;
  final Way1DemeritRecords way1DemeritRecords;
  final TagRecords tagRecords;


}


@UseMoor(tables: [ComparisonItemRecords])
class CompareListDB