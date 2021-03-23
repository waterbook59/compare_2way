//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';

///DBのList<ComparisonOverviewRecord>=>モデルクラスList<ComparisonOverview>
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
        ///取得時のcreatedAt追加
        createdAt: comparisonOverviewRecord.createdAt ,
      ));
    });
    return comparisonOverviews;
  }
}

///保存・単独読込の場合はリスト型でやりとり必要ない
///モデルクラス:ComparisonOverview=>DB:ComparisonOverviewRecordCompanion
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

///読込時 DB:ComparisonOverviewRecordの１行=>ComparisonOverview
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

///保存時 モデルクラス:way1Merit=>DB:way1MeritRecord
extension ConvertToWay1MeritRecord on Way1Merit{
  Way1MeritRecord toWay1MeritRecord (Way1Merit initWay1Merit){
    final way1MeritRecord= Way1MeritRecord(

      comparisonItemId: initWay1Merit.comparisonItemId,
      way1MeritDesc: initWay1Merit.way1MeritDesc ?? '',
    );
    return way1MeritRecord;
  }
}

///初回登録時 デルクラス:Lis<Way1Merit>=>DB:List<Way1MeritRecord>
extension ConvertToWay1InitMeritRecordList on List<Way1Merit>{
  List<Way1MeritRecord> toWay1InitMeritRecordList(
      List<Way1Merit> way1MeritItems) {
    final way1MeritItemRecords = <Way1MeritRecord>[];
    //todo 単にforEachをmapに変換してもダメ
    way1MeritItems.forEach((way1MeritSingle) {
      way1MeritItemRecords.add(Way1MeritRecord(
        comparisonItemId: way1MeritSingle.comparisonItemId,
        way1MeritDesc: way1MeritSingle.way1MeritDesc,
      ));
    });
    return way1MeritItemRecords;
  }
}

///保存時 モデルクラス:Lis<Way1Merit>=>DB:List<Way1MeritRecord>
extension ConvertToWay1MeritRecordList on List<Way1Merit>{
  List<Way1MeritRecord> toWay1MeritRecordList(List<Way1Merit> way1MeritItems) {
//    way1MeritId:autoIncrementにしてるのでそのまま
    //List<メリット詳細>=>1つずつのメリットへ分解
    final way1MeritItemRecords = <Way1MeritRecord>[];
    //todo 単にforEachをmapに変換してもダメ,map&toList()
    way1MeritItems.forEach((way1MeritSingle) {
      way1MeritItemRecords.add(Way1MeritRecord(
        way1MeritId: way1MeritSingle.way1MeritId,
        comparisonItemId: way1MeritSingle.comparisonItemId,
        way1MeritDesc: way1MeritSingle.way1MeritDesc,
      ));
    });
    print('extensions:way1MeritRecordにcomparisonItemId保存できているか');
    print(way1MeritItemRecords.map((way1MeritSingle)
 => way1MeritSingle.comparisonItemId).toList());
    return way1MeritItemRecords;
  }
}

///読込時 DB:List<Way1MeritRecord>=>モデルクラス:Lis<Way1Merit>
extension ConvertToWay1MeritList on List<Way1MeritRecord>{
  List<Way1Merit> toWay1MeritList(List<Way1MeritRecord> way1MeritRecordList){
    final way1MeritList = <Way1Merit>[];
    way1MeritRecordList.forEach((way1MeritRecordSingle) {
      way1MeritList.add(Way1Merit(
        way1MeritId: way1MeritRecordSingle.way1MeritId,
        comparisonItemId: way1MeritRecordSingle.comparisonItemId,
        way1MeritDesc: way1MeritRecordSingle.way1MeritDesc,
      ));
    });
    return way1MeritList;
  }
}



///ComparisonItem=>ComparisonOverviewRecord,List<way1Merit>,List<way1Demerit>に変換
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

  ///ComparisonItem=>List<way1Merit>
//  List<Way1MeritRecord> toWay1MeritRecordList(ComparisonItem comparisonItem) {
//    //todo
////    way1MeritId:autoIncrementにしてるので、そのままにしてみる
//    //List<メリット詳細>=>1つずつのメリットへ分解
//    ///way1MeritDescsはway1MeritRecordと同義だた、daoでinsertするときややこしいので名前変更
//    final way1MeritDescs = <Way1MeritRecord>[];
//    comparisonItem.way1Merit.forEach((way1MeritSingle) {
//      way1MeritDescs.add(Way1MeritRecord(
//        comparisonItemId: way1MeritSingle.comparisonItemId,
//        way1MeritDesc: way1MeritSingle.way1MeritDesc,
//      ));
//    });
//    return way1MeritDescs;
//  }

  ///ComparisonItem=>List<way1Demerit>
  List<Way1DemeritRecord> toWay1DemeritRecordList(ComparisonItem comparisonItem) {
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