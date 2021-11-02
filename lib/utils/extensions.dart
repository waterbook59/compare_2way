//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:uuid/uuid.dart';

///(DB=>model):List<ComparisonOverviewRecord>=>List<ComparisonOverview>
extension ConvertToComparisonOverviewRecords on List<ComparisonOverviewRecord> {
  List<ComparisonOverview> toComparisonOverviews(
      List<ComparisonOverviewRecord> comparisonOverviewRecords) {
    final comparisonOverviews =
    comparisonOverviewRecords.map((comparisonOverviewRecord) {
        return  ComparisonOverview(
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
      );
    }).toList();
    return comparisonOverviews;
  }
}

///保存・単独読込の場合はリスト型でやりとり必要ない
///(model=>DB):ComparisonOverview=>ComparisonOverviewRecordCompanion
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

///読込時(DB=>model):ComparisonOverviewRecordの１行=>ComparisonOverview
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

//way1Merit関連
///新規挿入時(model=>DB):way1Merit=>way1MeritRecord
extension ConvertToWay1MeritRecord on Way1Merit{
  Way1MeritRecord toCreateWay1MeritRecord (Way1Merit initWay1Merit){
    final way1MeritRecord= Way1MeritRecord(
      comparisonItemId: initWay1Merit.comparisonItemId,
      way1MeritDesc: initWay1Merit.way1MeritDesc ?? '',
    );
    return way1MeritRecord;
  }
}
///更新時(model=>DB):way1Merit=>way1MeritRecord
extension ConvertToUpdateWay1MeritRecord on Way1Merit{
  Way1MeritRecord toUpdateWay1MeritRecord (Way1Merit updateWay1Merit){
    final way1MeritRecord= Way1MeritRecord(
      way1MeritId: updateWay1Merit.way1MeritId,
      comparisonItemId: updateWay1Merit.comparisonItemId,
      way1MeritDesc: updateWay1Merit.way1MeritDesc ?? '',
    );
    return way1MeritRecord;
  }
}
///新規登録(model=>DB):List<Way1Merit>=>List<Way1MeritRecord>
extension ConvertToWay1InitMeritRecordList on List<Way1Merit>{
  List<Way1MeritRecord> toWay1InitMeritRecordList(
      List<Way1Merit> way1MeritItems) {
    final way1MeritItemRecords =
    way1MeritItems.map((way1MeritSingle) {
      return Way1MeritRecord(
        comparisonItemId: way1MeritSingle.comparisonItemId,
        way1MeritDesc: way1MeritSingle.way1MeritDesc,
      );
    }).toList();
    return way1MeritItemRecords;
  }
}
///保存時(model=>DB):Lis<Way1Merit>=>List<Way1MeritRecord>//todo 更新時のメソッド使えばいらないかも
extension ConvertToWay1MeritRecordList on List<Way1Merit>{
  List<Way1MeritRecord> toWay1MeritRecordList(List<Way1Merit> way1MeritItems) {
//    way1MeritId:autoIncrementにしてるのでそのまま
    //List<メリット詳細>=>1つずつのメリットへ分解
    final way1MeritItemRecords =
    way1MeritItems.map((way1MeritSingle) {
      return Way1MeritRecord(
        way1MeritId: way1MeritSingle.way1MeritId,
        comparisonItemId: way1MeritSingle.comparisonItemId,
        way1MeritDesc: way1MeritSingle.way1MeritDesc,
      );
    }).toList();
    return way1MeritItemRecords;
  }
}
///読込時(DB=>model):List<Way1MeritRecord>=>Lis<Way1Merit>
extension ConvertToWay1MeritList on List<Way1MeritRecord>{
  List<Way1Merit> toWay1MeritList(List<Way1MeritRecord> way1MeritRecordList){
    final way1MeritList =
    way1MeritRecordList.map((way1MeritRecordSingle) {
      return Way1Merit(
        way1MeritId: way1MeritRecordSingle.way1MeritId,
        comparisonItemId: way1MeritRecordSingle.comparisonItemId,
        way1MeritDesc: way1MeritRecordSingle.way1MeritDesc,
      );
    }).toList();
    return way1MeritList;
  }
}

//way1Demerit関連
///新規挿入時(model=>DB):way1Demerit=>way1DemeritRecord
extension ConvertToWay1DemeritRecord on Way1Demerit{
  Way1DemeritRecord toCreateWay1DemeritRecord (Way1Demerit initWay1Demerit){
    final way1DemeritRecord= Way1DemeritRecord(
      comparisonItemId: initWay1Demerit.comparisonItemId,
      way1DemeritDesc: initWay1Demerit.way1DemeritDesc ?? '',
    );
    return way1DemeritRecord;
  }
}
///更新時(model=>DB):way1Demerit=>way1DemeritRecord
extension ConvertToUpdateWay1DemeritRecord on Way1Demerit{
  Way1DemeritRecord toUpdateWay1DemeritRecord (Way1Demerit updateWay1Demerit){
    final way1DemeritRecord= Way1DemeritRecord(
      way1DemeritId: updateWay1Demerit.way1DemeritId,
      comparisonItemId: updateWay1Demerit.comparisonItemId,
      way1DemeritDesc: updateWay1Demerit.way1DemeritDesc ?? '',
    );
    return way1DemeritRecord;
  }
}
///新規登録(model=>DB):List<Way1Demerit>=>List<Way1DemeritRecord>
extension ConvertToWay1InitDemeritRecordList on List<Way1Demerit>{
  List<Way1DemeritRecord> toWay1InitDemeritRecordList(
      List<Way1Demerit> way1DemeritItems) {
    final way1DemeritItemRecords =
    way1DemeritItems.map((way1DemeritSingle) {
      return Way1DemeritRecord(
        comparisonItemId: way1DemeritSingle.comparisonItemId,
        way1DemeritDesc: way1DemeritSingle.way1DemeritDesc,
      );
    }).toList();
    return way1DemeritItemRecords;
  }
}
///読込時(DB=>model):List<Way1DemeritRecord>=>Lis<Way1Demerit>
extension ConvertToWay1DemeritList on List<Way1DemeritRecord>{
  List<Way1Demerit> toWay1DemeritList(
      List<Way1DemeritRecord> way1DemeritRecordList){
    final way1DemeritList =
    way1DemeritRecordList.map((way1DemeritRecordSingle) {
      return Way1Demerit(
        way1DemeritId: way1DemeritRecordSingle.way1DemeritId,
        comparisonItemId: way1DemeritRecordSingle.comparisonItemId,
        way1DemeritDesc: way1DemeritRecordSingle.way1DemeritDesc,
      );
    }).toList();
    return way1DemeritList;
  }
}

//way2Merit関連
///新規挿入時(model=>DB):way2Merit=>way2MeritRecord
extension ConvertToWay2MeritRecord on Way2Merit{
  Way2MeritRecord toCreateWay2MeritRecord (Way2Merit initWay2Merit){
    final way2MeritRecord= Way2MeritRecord(
      comparisonItemId: initWay2Merit.comparisonItemId,
      way2MeritDesc: initWay2Merit.way2MeritDesc ?? '',
    );
    return way2MeritRecord;
  }
}
///更新時(model=>DB):way2Merit=>way2MeritRecord
extension ConvertToUpdateWay2MeritRecord on Way2Merit{
  Way2MeritRecord toUpdateWay2MeritRecord (Way2Merit updateWay2Merit){
    final way2MeritRecord= Way2MeritRecord(
      way2MeritId: updateWay2Merit.way2MeritId,
      comparisonItemId: updateWay2Merit.comparisonItemId,
      way2MeritDesc: updateWay2Merit.way2MeritDesc ?? '',
    );
    return way2MeritRecord;
  }
}
///新規登録(model=>DB):List<Way2Merit>=>List<Way2MeritRecord>
extension ConvertToWay2InitMeritRecordList on List<Way2Merit>{
  List<Way2MeritRecord> toWay2InitMeritRecordList(
      List<Way2Merit> way2MeritItems) {
    ///forEach=>map().toList()へ変更
    final way2MeritItemRecords =
    way2MeritItems.map((way2MeritSingle) {
      return Way2MeritRecord(
        comparisonItemId: way2MeritSingle.comparisonItemId,
        way2MeritDesc: way2MeritSingle.way2MeritDesc,
      );}).toList();
    return way2MeritItemRecords;
  }
}
///読込時(DB=>model) List<Way2MeritRecord>=>Lis<Way2Merit>
extension ConvertToWay2MeritList on List<Way2MeritRecord>{
  List<Way2Merit> toWay2MeritList(List<Way2MeritRecord> way2MeritRecordList){
    final way2MeritList =
    way2MeritRecordList.map((way2MeritRecordSingle) {
      return Way2Merit(
        way2MeritId: way2MeritRecordSingle.way2MeritId,
        comparisonItemId: way2MeritRecordSingle.comparisonItemId,
        way2MeritDesc: way2MeritRecordSingle.way2MeritDesc,
      );
    }).toList();
    return way2MeritList;
  }
}

//way2Demerit関連
///新規挿入時(model=>DB):way2Demerit=>way2DemeritRecord
extension ConvertToWay2DemeritRecord on Way2Demerit{
  Way2DemeritRecord toCreateWay2DemeritRecord (Way2Demerit initWay2Demerit){
    final way2DemeritRecord= Way2DemeritRecord(
      comparisonItemId: initWay2Demerit.comparisonItemId,
      way2DemeritDesc: initWay2Demerit.way2DemeritDesc ?? '',
    );
    return way2DemeritRecord;
  }
}
///更新時(model=>DB):way2Demerit=>way2DemeritRecord
extension ConvertToUpdateWay2DemeritRecord on Way2Demerit{
  Way2DemeritRecord toUpdateWay2DemeritRecord (Way2Demerit updateWay2Demerit){
    final way2DemeritRecord= Way2DemeritRecord(
      way2DemeritId: updateWay2Demerit.way2DemeritId,
      comparisonItemId: updateWay2Demerit.comparisonItemId,
      way2DemeritDesc: updateWay2Demerit.way2DemeritDesc ?? '',
    );
    return way2DemeritRecord;
  }
}
///新規登録(model=>DB):List<Way2Demerit>=>List<Way2DemeritRecord>
extension ConvertToWay2InitDemeritRecordList on List<Way2Demerit>{
  List<Way2DemeritRecord> toWay2InitDemeritRecordList(
      List<Way2Demerit> way2DemeritItems) {
    final way2DemeritItemRecords =
    way2DemeritItems.map((way2DemeritSingle) {
      return Way2DemeritRecord(
        comparisonItemId: way2DemeritSingle.comparisonItemId,
        way2DemeritDesc: way2DemeritSingle.way2DemeritDesc,
      );
    }).toList();
    return way2DemeritItemRecords;
  }
}
///読込時(DB=>model):List<Way2DemeritRecord>=>Lis<Way2Demerit>
extension ConvertToWay2DemeritList on List<Way2DemeritRecord>{
  List<Way2Demerit> toWay2DemeritList(
      List<Way2DemeritRecord> way2DemeritRecordList){
    final way2DemeritList =
    way2DemeritRecordList.map((way2DemeritRecordSingle) {
      return Way2Demerit(
        way2DemeritId: way2DemeritRecordSingle.way2DemeritId,
        comparisonItemId: way2DemeritRecordSingle.comparisonItemId,
        way2DemeritDesc: way2DemeritRecordSingle.way2DemeritDesc,
      );
    }).toList();
    return way2DemeritList;
  }
}

//todo way3Merit関連
//todo way3Demerit関連

///新規挿入時(model=>DB):List<Tag>=>List<TagRecord>
extension ConvertToTagRecordList on List<Tag>{
  // tagTitleをprimaryKeyに設定した場合、tagIdのautoIncrement効かないかも
  //=>tagIdがint型なのでUuid.hashCodeを使う
  List<TagRecord> toTagRecordList(
      List<Tag> tagList){
    final tagRecordList =
        tagList.map((tag) {
          return TagRecord(
            //tagIdはautoIncrementなので新規作成時入れない
//            tagId:tag.tagId ?? 0,
          tagId: Uuid().hashCode,
            tagTitle:tag.tagTitle ?? '',
            comparisonItemId:tag.comparisonItemId ?? '',
            createdAt: tag.createdAt,
            createAtToString: tag.createAtToString,
          );
    }).toList();
    return tagRecordList;
  }
}
///更新時(model=>DB):List<Tag>=>List<TagRecord>
extension ConvertToUpdateTagRecordList on List<Tag>{
  // tagTitleをprimaryKeyに設定した場合、tagIdのautoIncrement効かないかも
  //=>tagIdがint型なのでUuid.hashCodeを使う
  List<TagRecord> toUpdateTagRecordList(
      List<Tag> tagList){
    final tagRecordList =
    tagList.map((tag) {
      return TagRecord(
        //tagIdは更新時はそのまま変換
        tagId: tag.tagId,
        tagTitle:tag.tagTitle ?? '',
        comparisonItemId:tag.comparisonItemId ?? '',
        createdAt: tag.createdAt,
        createAtToString: tag.createAtToString,
      );
    }).toList();
    return tagRecordList;
  }
}
///読込時(DB=>model) List<TagRecord>=>List<Tag>
extension ConvertToTagList on List<TagRecord>{
  List<Tag> toTagList(List<TagRecord> tagRecordList){
    final tagList =
    tagRecordList.map((tagRecordSingle) {
      return Tag(
        tagId: tagRecordSingle.tagId ??0,
        comparisonItemId: tagRecordSingle.comparisonItemId ??'',
        tagTitle: tagRecordSingle.tagTitle ?? '',
        createdAt: tagRecordSingle.createdAt,
        createAtToString: tagRecordSingle.createAtToString ??'',
      );
    }).toList() ;
    return tagList;
  }
}
///削除時(model=>DB) Tag=>TagRecord
extension ConvertToTagRecord on Tag{
  TagRecord toTagRecord(Tag tag){
    final tagRecord =
    TagRecord(
        tagId: tag.tagId ??0,
        comparisonItemId: tag.comparisonItemId ??'',
        tagTitle: tag.tagTitle ?? '',
        createdAt: tag.createdAt,
        createAtToString: tag.createAtToString ??'',
      );
    return tagRecord;
  }
}

///新規挿入時(model=>DB):List<TagChart>=>List<TagChartRecord>
extension ConvertToTagChartRecordList on List<TagChart>{
  // tagTitleをprimaryKeyに設定した場合、tagIdのautoIncrement効かないかも
  //=>tagIdがint型なのでUuid.hashCodeを使う
  List<TagChartRecord> toTagChartRecordList(
      List<TagChart> tagChartList){
    final tagChartRecordList =
    tagChartList.map((tagChart) {
      return TagChartRecord(
          dataId: tagChart.dataId,
          tagTitle:tagChart.tagTitle ?? '',
          tagAmount:tagChart.tagAmount ?? 0,
      );
    }).toList();
    return tagChartRecordList;
  }
}

///読込時(DB=>model) List<TagChartRecord>=>List<TagChart>
extension ConvertToTagChartList on List<TagChartRecord>{
  List<TagChart> toTagChartList(List<TagChartRecord> tagChartRecordList){
    final tagChartList =
    tagChartRecordList.map((tagChartRecord) {
      return TagChart(
        dataId: tagChartRecord.dataId ?? 0,
        tagTitle: tagChartRecord.tagTitle ??'',
        tagAmount: tagChartRecord.tagAmount ?? 0,
      );
    }).toList() ;
    return tagChartList;
  }
}