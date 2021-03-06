//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';

extension ConvertToComparisonItemRecord on ComparisonItem {
  //モデルクラス(ComparisonItem)をDBのテーブルクラス(ComparisonOverviewRecord)に変換
  ComparisonOverviewRecord toOverviewRecord(ComparisonItem comparisonItem) {
    // var wordRecord = WordRecord();のインスタンスは作らず直接代入
    //varではなくfinalでも良い
    ///comparisonItemをまず４つのテーブルに格納できるよう変換

    final comparisonOverviewRecord = ComparisonOverviewRecord(
      dataId: comparisonItem.dataId,
      comparisonItemId: comparisonItem.comparisonItemId,
      itemTitle: comparisonItem.itemTitle ?? '',
      way1Title: comparisonItem.way1Title ?? '',
      way1MeritEvaluate: comparisonItem.way1MeritEvaluate ?? 0,
      way1DemeritEvaluate: comparisonItem.way1DemeritEvaluate ?? 0,
      way2Title: comparisonItem.way2Title ?? '',
      way2MeritEvaluate: comparisonItem.way2MeritEvaluate ?? 0,
      way2DemeritEvaluate: comparisonItem.way2DemeritEvaluate ?? 0,
      //      way3Title:comparisonItem.way3Title ?? '',
//      way3MeritEvaluate: comparisonItem.way3MeritEvaluate ?? 0,
//      way3DemeritEvaluate: comparisonItem.way3DemeritEvaluate ?? 0,
      //      tags:comparisonItem.tags??'',
      favorite: comparisonItem.favorite ?? false,
      conclusion: comparisonItem.conclusion ?? '',
      createdAt: comparisonItem.createdAt,
    );
    return comparisonOverviewRecord;
  }

  List<Way1MeritRecord> toWay1MeritRecord(ComparisonItem comparisonItem) {
    //todo
//    way1MeritId:autoIncrementにしてるので、そのままにしてみる
    //List<メリット詳細>=>1つずつのメリットへ分解
    ///way1MeritDescsはway1MeritRecordと同義だた、daoでinsertするときややこしいので名前変更
    final way1MeritDescs = <Way1MeritRecord>[];
    comparisonItem.way1Merit.forEach((way1MeritSingle) {
      way1MeritDescs.add(Way1MeritRecord(
        comparisonItemId: way1MeritSingle.comparisonItemId,
        way1MeritDesc: way1MeritSingle.way1MeritDesc,
      ));
    });
    return way1MeritDescs;
  }

  List<Way1DemeritRecord> toWay1DemeritRecord(ComparisonItem comparisonItem) {
//    way1MeritId:autoIncrementにしてるので、そのままにしてみる
    //List<メリット詳細>=>1つずつのメリットへ分解
    ///way1MeritDescsはway1MeritRecordと同義だた、daoでinsertするときややこしいので名前変更
    final way1DemeritDescs = <Way1DemeritRecord>[];

    comparisonItem.way1Demerit.forEach((way1DemeritSingle) {
      way1DemeritDescs.add(Way1DemeritRecord(
        comparisonItemId: way1DemeritSingle.comparisonItemId,
//        comparisonItemId: way1DemeritSingle.comparisonItemId,
        way1DemeritDesc: way1DemeritSingle.way1DemeritDesc,
      ));
    });
    return way1DemeritDescs;
  }
}

///DBのComparisonOverviewRecordのリスト=>モデルクラスComparisonOverviewのリスト
extension ConvertToComparisonOverviewRecords on List<ComparisonOverviewRecord> {
  List<ComparisonOverview> toComparisonOverviews(
      List<ComparisonOverviewRecord> comparisonOverviewRecords) {
    var comparisonOverviews = <ComparisonOverview>[];

    comparisonOverviewRecords.forEach((comparisonOverviewRecord) {
      comparisonOverviews.add(ComparisonOverview(
        dataId: comparisonOverviewRecord.dataId ?? 0,
        comparisonItemId: comparisonOverviewRecord.comparisonItemId ?? '',
        itemTitle: comparisonOverviewRecord.itemTitle ?? '',
        way1Title: comparisonOverviewRecord.way1Title ?? '',
        way1MeritEvaluate: comparisonOverviewRecord.way1MeritEvaluate ?? 0,
        way1DemeritEvaluate: comparisonOverviewRecord.way1DemeritEvaluate ?? 0,
        way2Title: comparisonOverviewRecord.way2Title ?? '',
        way2MeritEvaluate: comparisonOverviewRecord.way2MeritEvaluate ?? 0,
        way2DemeritEvaluate: comparisonOverviewRecord.way2DemeritEvaluate ?? 0,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
        favorite: comparisonOverviewRecord.favorite ?? false,
        conclusion: comparisonOverviewRecord.conclusion ?? '',
      ));
    });
    return comparisonOverviews;
  }
}

///保存の場合はリスト型でやりとり必要ない
///モデルクラスComparisonOverview=>DBのComparisonOverviewRecordCompanion
extension ConvertToComparisonOverview on ComparisonOverview {
  ComparisonOverviewRecord toComparisonOverviewRecord(
      ComparisonOverview updateOverview) {
    final comparisonOverviewRecord =
        ComparisonOverviewRecord(
      dataId: updateOverview.dataId,
      comparisonItemId: updateOverview.comparisonItemId,
      itemTitle: updateOverview.itemTitle ,
      way1Title: updateOverview.way1Title ,
      way1MeritEvaluate: updateOverview.way1MeritEvaluate ?? 0,
      way1DemeritEvaluate:updateOverview.way1DemeritEvaluate ?? 0,
      way2Title: updateOverview.way2Title,
      way2MeritEvaluate: updateOverview.way2MeritEvaluate ??0,
      way2DemeritEvaluate: updateOverview.way2DemeritEvaluate ??0,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
      favorite: updateOverview.favorite ?? false,
      conclusion: updateOverview.conclusion ?? '',
      createdAt: updateOverview.createdAt,
    );
    return comparisonOverviewRecord;
  }
}

///リストじゃなくて、DBのComparisonOverviewRecordの１行=>ComparisonOverview
extension ConvertToComparisonOverviewRecord on ComparisonOverviewRecord {
  ComparisonOverview toComparisonOverview(
      ComparisonOverviewRecord overviewRecord) {
    final comparisonOverview =
    ComparisonOverview(
      dataId: overviewRecord.dataId,
      comparisonItemId: overviewRecord.comparisonItemId,
      itemTitle: overviewRecord.itemTitle ,
      way1Title: overviewRecord.way1Title ,
      way1MeritEvaluate: overviewRecord.way1MeritEvaluate ?? 0,
      way1DemeritEvaluate:overviewRecord.way1DemeritEvaluate ?? 0,
      way2Title: overviewRecord.way2Title,
      way2MeritEvaluate: overviewRecord.way2MeritEvaluate ??0,
      way2DemeritEvaluate: overviewRecord.way2DemeritEvaluate ??0,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
      favorite: overviewRecord.favorite ?? false,
      conclusion: overviewRecord.conclusion ?? '',
      createdAt: overviewRecord.createdAt,
    );
    return comparisonOverview;
  }
}