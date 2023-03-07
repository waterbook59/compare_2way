//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_tag_chart.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

///(DB=>model):List<ComparisonOverviewRecord>=>List<ComparisonOverview>
extension ConvertToComparisonOverviewRecords on List<ComparisonOverviewRecord> {
  List<ComparisonOverview> toComparisonOverviews(
      List<ComparisonOverviewRecord> comparisonOverviewRecords,) {
    final comparisonOverviews =
    comparisonOverviewRecords.map((comparisonOverviewRecord) {
        return  ComparisonOverview(
        dataId: comparisonOverviewRecord.dataId ,
        comparisonItemId: comparisonOverviewRecord.comparisonItemId,
        itemTitle: comparisonOverviewRecord.itemTitle ,
        way1Title: comparisonOverviewRecord.way1Title ,
        way1MeritEvaluate: comparisonOverviewRecord.way1MeritEvaluate ,
        way1DemeritEvaluate: comparisonOverviewRecord.way1DemeritEvaluate ,
        way2Title: comparisonOverviewRecord.way2Title ,
        way2MeritEvaluate: comparisonOverviewRecord.way2MeritEvaluate ,
        way2DemeritEvaluate: comparisonOverviewRecord.way2DemeritEvaluate ,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
        favorite: comparisonOverviewRecord.favorite ,
        conclusion: comparisonOverviewRecord.conclusion ?? '',
        ///取得時のcreatedAt追加
        createdAt: comparisonOverviewRecord.createdAt! ,
      );
    }).toList();
    return comparisonOverviews;
  }
}

///(model=>DB):List<ComparisonOverview>=>List<ComparisonOverviewRecord>
extension ConvertToComparisonOverviews on List<ComparisonOverview> {
  List<ComparisonOverviewRecord> toComparisonOverviewRecords(
      List<ComparisonOverview> comparisonOverviews,) {
    final comparisonOverviewRecords =
    comparisonOverviews.map((comparisonOverview) {
      return  ComparisonOverviewRecord(
        dataId: comparisonOverview.dataId ?? 0,
        comparisonItemId: comparisonOverview.comparisonItemId ,
        itemTitle: comparisonOverview.itemTitle ?? '',
        way1Title: comparisonOverview.way1Title ?? '',
        way1MeritEvaluate: comparisonOverview.way1MeritEvaluate ?? 0,
        way1DemeritEvaluate: comparisonOverview.way1DemeritEvaluate ?? 0,
        way2Title: comparisonOverview.way2Title ?? '',
        way2MeritEvaluate: comparisonOverview.way2MeritEvaluate ?? 0,
        way2DemeritEvaluate: comparisonOverview.way2DemeritEvaluate ?? 0,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
        favorite: comparisonOverview.favorite ?? false,
        conclusion: comparisonOverview.conclusion ?? '',
        ///取得時のcreatedAt追加
        createdAt: comparisonOverview.createdAt ,
      );
    }).toList();
    return comparisonOverviewRecords;
  }
}

///ComparisonOverview_新規挿入(model=>DB):ComparisonOverview=>Companion
extension RegisterNewOverviewCompanion on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toOverviewNewRecordsCompanion(
      ComparisonOverview updateOverview,)  {
    final companion=
   ComparisonOverviewRecordsCompanion(
     comparisonItemId: Value(updateOverview.comparisonItemId),
     itemTitle: Value(updateOverview.itemTitle!),
     way1Title:Value(updateOverview.way1Title!),
     way2Title: Value(updateOverview.way2Title!),
     //conclusionはnullableにしているが、addScreenで初期値''を入れているので、入力
         conclusion: Value(updateOverview.conclusion),
         createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

///ComparisonOverview_タイトル更新(model=>DB):ComparisonOverview=>Companion
extension UpdateTitlesDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateTitles(
      ComparisonOverview updateOverview,)  {
    final companion=
    ComparisonOverviewRecordsCompanion(
//アップデート要素がないものを入れるとnullでエラー(Companionに入れるのは値が更新できるものだけ)
      comparisonItemId: Value(updateOverview.comparisonItemId),
      itemTitle: Value(updateOverview.itemTitle!),
      way1Title: Value(updateOverview.way1Title!),
      way2Title: Value(updateOverview.way2Title!),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

///ComparisonOverview_テーブル値更新(model=>DB):ComparisonOverview=>Companion
/// //todo updateEvaluateでスッキリ書く
//way1Merit
extension UpdateWay1MeritEvaluateDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateWay1MeritEvaluate(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      way1MeritEvaluate: Value(updateOverview.way1MeritEvaluate!),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

//way1DeMerit
extension UpdateWay1DemeritEvaluateDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateWay1DemeritEvaluate(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      way1DemeritEvaluate:Value(updateOverview.way1DemeritEvaluate!),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

//way2Merit
extension UpdateWay2MeritEvaluateDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateWay2MeritEvaluate(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      way1MeritEvaluate: Value(updateOverview.way2MeritEvaluate!),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

//way2DeMerit
extension UpdateWay2DemeritEvaluateDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateWay2DemeritEvaluate(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      way1DemeritEvaluate:Value(updateOverview.way2DemeritEvaluate!),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}
//way3Merit
//way3Demerit

///ComparisonOverview_結論更新(model=>DB):ComparisonOverview=>Companion
extension UpdateConclusionDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateConclusion(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      conclusion:Value(updateOverview.conclusion),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}
///ComparisonOverview_時間更新(model=>DB):ComparisonOverview=>Companion
extension UpdateTimeDB on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateTime(
      ComparisonOverview updateOverview,)  {
    final companion= ComparisonOverviewRecordsCompanion(
      comparisonItemId: Value(updateOverview.comparisonItemId),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

///ComparisonOverview_保存(model=>DB):ComparisonOverview=>Companion
extension SaveOverviewCompanion on ComparisonOverview {
  ComparisonOverviewRecordsCompanion toCompanionUpdateOverview(
      ComparisonOverview updateOverview,)  {
    //todo extensionsの中で一気にやる,way3・お気に入り追加
    ///ComparisonOverviewRecord=>ComparisonOverviewRecordsCompanion
    final companion = ComparisonOverviewRecordsCompanion(
      //アップデート要素がないものを入れるとnullでエラー(Companionに入れるのは値が更新できるものだけ)
//        dataId: Value(comparisonOverviewRecord.dataId),
      comparisonItemId: Value(updateOverview.comparisonItemId),
      itemTitle: Value(updateOverview.itemTitle!),
      way1Title: Value(updateOverview.way1Title!),
      way1MeritEvaluate: Value(updateOverview.way1MeritEvaluate!),
      way1DemeritEvaluate:
      Value(updateOverview.way1DemeritEvaluate!),
      way2Title: Value(updateOverview.way2Title!),
      way2MeritEvaluate: Value(updateOverview.way2MeritEvaluate!),
      way2DemeritEvaluate:
      Value(updateOverview.way2DemeritEvaluate!),
//        favorite: Value(comparisonOverviewRecord.favorite),
      conclusion: Value(updateOverview.conclusion),
      createdAt: Value(updateOverview.createdAt),
    );
    return companion;
  }
}

///保存・単独読込の場合はリスト型でやりとり必要ない
///(model=>DB):ComparisonOverview=>ComparisonOverviewRecordCompanion
extension ConvertToComparisonOverview on ComparisonOverview {
  ComparisonOverviewRecord toComparisonOverviewRecord(
      ComparisonOverview updateOverview,) {
    final comparisonOverviewRecord =
        ComparisonOverviewRecord(
          //初期はnull=>0挿入すると重複でUNIQUEエラー
      dataId: updateOverview.dataId!,
      comparisonItemId: updateOverview.comparisonItemId,
      itemTitle: updateOverview.itemTitle! ,
      way1Title: updateOverview.way1Title! ,
      way1MeritEvaluate: updateOverview.way1MeritEvaluate ?? 0,
      way1DemeritEvaluate:updateOverview.way1DemeritEvaluate ?? 0,
      way2Title: updateOverview.way2Title!,
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

///ComparisonOverview_読込(DB=>model):ComparisonOverviewRecord=>ComparisonOverview
extension ConvertToComparisonOverviewRecord on ComparisonOverviewRecord {
  ComparisonOverview toComparisonOverview(
      ComparisonOverviewRecord overviewRecord,) {
    final comparisonOverview =
    ComparisonOverview(
      dataId: overviewRecord.dataId,
      comparisonItemId: overviewRecord.comparisonItemId,
      itemTitle: overviewRecord.itemTitle ,
      way1Title: overviewRecord.way1Title ,
      way1MeritEvaluate: overviewRecord.way1MeritEvaluate ,
      way1DemeritEvaluate:overviewRecord.way1DemeritEvaluate ,
      way2Title: overviewRecord.way2Title,
      way2MeritEvaluate: overviewRecord.way2MeritEvaluate ,
      way2DemeritEvaluate: overviewRecord.way2DemeritEvaluate ,
//todo way3追加
//            way3Title:  comparisonOverviewRecord.way3Title ?? '',
//            way3Evaluate: comparisonOverviewRecord.way3Evaluate ?? 0,
      favorite: overviewRecord.favorite ,
      conclusion: overviewRecord.conclusion ?? '',
      createdAt: overviewRecord.createdAt!,
    );
    return comparisonOverview;
  }
}

//way1Merit関連
///新規挿入時(model=>DB):way1Merit=>way1MeritRecord
extension ConvertToWay1MeritRecord on Way1Merit{
  Way1MeritRecord toCreateWay1MeritRecord (Way1Merit initWay1Merit){
    final way1MeritRecord= Way1MeritRecord(
      //autoIncrementでway1MeritIdがnull=>0挿入だと新規挿入で同idが多くなる？
      way1MeritId: initWay1Merit.way1MeritId??5,
      comparisonItemId: initWay1Merit.comparisonItemId!,
      way1MeritDesc: initWay1Merit.way1MeritDesc ?? '',
    );
    return way1MeritRecord;
  }
}
///更新時(model=>DB):way1Merit=>way1MeritRecord
extension ConvertToUpdateWay1MeritRecord on Way1Merit{
  Way1MeritRecord toUpdateWay1MeritRecord (Way1Merit updateWay1Merit){
    final way1MeritRecord= Way1MeritRecord(
      way1MeritId: updateWay1Merit.way1MeritId!,
      comparisonItemId: updateWay1Merit.comparisonItemId!,
      way1MeritDesc: updateWay1Merit.way1MeritDesc ?? '',
    );
    return way1MeritRecord;
  }
}
///新規登録(model=>DB):List<Way1Merit>=>List<Way1MeritRecord>
//companionへ変更way1MeritIdがautoIncrementなので
extension ConvertToWay1InitMeritRecordList on List<Way1Merit>{
  List<Way1MeritRecordsCompanion> toWay1InitMeritRecordList(
      List<Way1Merit> way1MeritItems,) {
    final way1MeritItemRecords =
    way1MeritItems.map((way1MeritSingle) {
      return Way1MeritRecordsCompanion(
        // way1MeritId: way1MeritSingle.way1MeritId!,
        comparisonItemId: Value(way1MeritSingle.comparisonItemId!),
        way1MeritDesc: Value(way1MeritSingle.way1MeritDesc??''),
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
        way1MeritId: way1MeritSingle.way1MeritId!,
        comparisonItemId: way1MeritSingle.comparisonItemId!,
        way1MeritDesc: way1MeritSingle.way1MeritDesc??'',
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

//way1Demerit関連 //todo 使用なければ削除
///新規挿入時(model=>DB):way1Demerit=>way1DemeritRecord
extension ConvertToWay1DemeritRecord on Way1Demerit{
  Way1DemeritRecord toCreateWay1DemeritRecord (Way1Demerit initWay1Demerit){
    final way1DemeritRecord= Way1DemeritRecord(
      way1DemeritId: initWay1Demerit.way1DemeritId??5,
      comparisonItemId: initWay1Demerit.comparisonItemId!,
      way1DemeritDesc: initWay1Demerit.way1DemeritDesc ?? '',
    );
    return way1DemeritRecord;
  }
}
///更新時(model=>DB):way1Demerit=>way1DemeritRecord
extension ConvertToUpdateWay1DemeritRecord on Way1Demerit{
  Way1DemeritRecord toUpdateWay1DemeritRecord (Way1Demerit updateWay1Demerit){
    final way1DemeritRecord= Way1DemeritRecord(
      way1DemeritId: updateWay1Demerit.way1DemeritId!,
      comparisonItemId: updateWay1Demerit.comparisonItemId!,
      way1DemeritDesc: updateWay1Demerit.way1DemeritDesc ?? '',
    );
    return way1DemeritRecord;
  }
}
///新規登録(model=>DB):List<Way1Demerit>=>List<Way1DemeritRecord>
extension ConvertToWay1InitDemeritRecordList on List<Way1Demerit>{
  List<Way1DemeritRecordsCompanion> toWay1InitDemeritRecordList(
      List<Way1Demerit> way1DemeritItems,) {
    final way1DemeritItemRecords =
    way1DemeritItems.map((way1DemeritSingle) {
      return Way1DemeritRecordsCompanion(
        // way1DemeritId: way1DemeritSingle.way1DemeritId!,
        comparisonItemId: Value(way1DemeritSingle.comparisonItemId!),
        way1DemeritDesc: Value(way1DemeritSingle.way1DemeritDesc?? ''),
      );
    }).toList();
    return way1DemeritItemRecords;
  }
}
///読込時(DB=>model):List<Way1DemeritRecord>=>Lis<Way1Demerit>
extension ConvertToWay1DemeritList on List<Way1DemeritRecord>{
  List<Way1Demerit> toWay1DemeritList(
      List<Way1DemeritRecord> way1DemeritRecordList,){
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
      way2MeritId: initWay2Merit.way2MeritId??5,
      comparisonItemId: initWay2Merit.comparisonItemId!,
      way2MeritDesc: initWay2Merit.way2MeritDesc ?? '',
    );
    return way2MeritRecord;
  }
}
///更新時(model=>DB):way2Merit=>way2MeritRecord
extension ConvertToUpdateWay2MeritRecord on Way2Merit{
  Way2MeritRecord toUpdateWay2MeritRecord (Way2Merit updateWay2Merit){
    final way2MeritRecord= Way2MeritRecord(
      way2MeritId: updateWay2Merit.way2MeritId!,
      comparisonItemId: updateWay2Merit.comparisonItemId!,
      way2MeritDesc: updateWay2Merit.way2MeritDesc ?? '',
    );
    return way2MeritRecord;
  }
}
///新規登録(model=>DB):List<Way2Merit>=>List<Way2MeritRecord>
extension ConvertToWay2InitMeritRecordList on List<Way2Merit>{
  List<Way2MeritRecordsCompanion> toWay2InitMeritRecordList(
      List<Way2Merit> way2MeritItems,) {
    ///forEach=>map().toList()へ変更
    final way2MeritItemRecords =
    way2MeritItems.map((way2MeritSingle) {
      return Way2MeritRecordsCompanion(
        // way2MeritId: way2MeritSingle.way2MeritId !,
        comparisonItemId:Value(way2MeritSingle.comparisonItemId!),
        way2MeritDesc: Value(way2MeritSingle.way2MeritDesc?? ''),
      );}).toList();
    return way2MeritItemRecords;
  }
}
///読込時(DB=>model) List<Way2MeritRecord>=>List<Way2Merit>
extension ConvertToWay2MeritList on List<Way2MeritRecord>{
  List<Way2Merit> toWay2MeritList(List<Way2MeritRecord> way2MeritRecordList){
    final way2MeritList =
    way2MeritRecordList.map((way2MeritRecordSingle) {
      return Way2Merit(
        way2MeritId: way2MeritRecordSingle.way2MeritId,
        comparisonItemId: way2MeritRecordSingle.comparisonItemId,
        way2MeritDesc: way2MeritRecordSingle.way2MeritDesc?? '',
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
      way2DemeritId: initWay2Demerit.way2DemeritId??5,
      comparisonItemId: initWay2Demerit.comparisonItemId!,
      way2DemeritDesc: initWay2Demerit.way2DemeritDesc ?? '',
    );
    return way2DemeritRecord;
  }
}
///更新時(model=>DB):way2Demerit=>way2DemeritRecord
extension ConvertToUpdateWay2DemeritRecord on Way2Demerit{
  Way2DemeritRecord toUpdateWay2DemeritRecord (Way2Demerit updateWay2Demerit){
    final way2DemeritRecord= Way2DemeritRecord(
      way2DemeritId: updateWay2Demerit.way2DemeritId!,
      comparisonItemId: updateWay2Demerit.comparisonItemId!,
      way2DemeritDesc: updateWay2Demerit.way2DemeritDesc ?? '',
    );
    return way2DemeritRecord;
  }
}
///新規登録(model=>DB):List<Way2Demerit>=>List<Way2DemeritRecord>
extension ConvertToWay2InitDemeritRecordList on List<Way2Demerit>{
  List<Way2DemeritRecordsCompanion> toWay2InitDemeritRecordList(
      List<Way2Demerit> way2DemeritItems,) {
    final way2DemeritItemRecords =
    way2DemeritItems.map((way2DemeritSingle) {
      return Way2DemeritRecordsCompanion(
        // way2DemeritId: way2DemeritSingle.way2DemeritId!,
        comparisonItemId: Value(way2DemeritSingle.comparisonItemId!),
        way2DemeritDesc: Value(way2DemeritSingle.way2DemeritDesc?? ''),
      );
    }).toList();
    return way2DemeritItemRecords;
  }
}
///読込時(DB=>model):List<Way2DemeritRecord>=>Lis<Way2Demerit>
extension ConvertToWay2DemeritList on List<Way2DemeritRecord>{
  List<Way2Demerit> toWay2DemeritList(
      List<Way2DemeritRecord> way2DemeritRecordList,){
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
      List<Tag> tagList,){
    final tagRecordList =
        tagList.map((tag) {
          return TagRecord(
            //tagIdはautoIncrementなので新規作成時入れない
//            tagId:tag.tagId ?? 0,
          tagId: const Uuid().hashCode,
            tagTitle:tag.tagTitle ?? '',
            comparisonItemId:tag.comparisonItemId ?? '',
            createdAt: tag.createdAt,
            createAtToString: tag.createAtToString!,
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
      List<Tag> tagList,){
    final tagRecordList =
    tagList.map((tag) {
      return TagRecord(
        //tagIdは更新時はそのまま変換
        tagId: tag.tagId,
        tagTitle:tag.tagTitle ?? '',
        comparisonItemId:tag.comparisonItemId ?? '',
        createdAt: tag.createdAt,
        createAtToString: tag.createAtToString!,
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
        comparisonItemId: tagRecordSingle.comparisonItemId,
        tagTitle: tagRecordSingle.tagTitle,
        createdAt: tagRecordSingle.createdAt,
        createAtToString: tagRecordSingle.createAtToString,
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

//todo removeTagChartで使用しなければ削除
///List<TagChart>_新規挿入(model=>DB):List<TagChart>=>List<TagChartRecord>
extension RegisterNewTagChartRecordList on List<TagChart>{
  // tagTitleをprimaryKeyに設定した場合、tagIdのautoIncrement効かないかも
  //=>tagIdがint型なのでUuid.hashCodeを使う
  List<TagChartRecordsCompanion> toTagChartRecordsCompanion(
      List<TagChart> tagChartList,){
    final tagChartRecordList =
    tagChartList.map((tagChart) {
      return TagChartRecordsCompanion(
          // dataId: tagChart.dataId!,
          tagTitle:Value(tagChart.tagTitle) ,
          tagAmount:Value(tagChart.tagAmount ?? 0),
      );
    }).toList();
    return tagChartRecordList;
  }
}

///TagChart_tagAmount更新
extension UpdateTagChartRecordList on TagChart{
  TagChartRecordsCompanion toUpdateAmountTagCompanion(
      TagChart tagChart,){
    final tagCompanion =TagChartRecordsCompanion(
      tagAmount: Value(tagChart.tagAmount ),);
    return tagCompanion;
  }
}

///読込時(DB=>model) List<TagChartRecord>=>List<TagChart>
extension ConvertToTagChartList on List<TagChartRecord>{
  List<TagChart> toTagChartList(List<TagChartRecord> tagChartRecordList){
    final tagChartList =
    tagChartRecordList.map((tagChartRecord) {
      return TagChart(
        dataId: tagChartRecord.dataId ,
        tagTitle: tagChartRecord.tagTitle ,
        tagAmount: tagChartRecord.tagAmount ?? 0,
      );
    }).toList() ;
    return tagChartList;
  }
}

///読込時(DB=>model) TagChartRecord=>TagChart
extension ConvertToTagChart on TagChartRecord{
  TagChart toTagChart(TagChartRecord tagChartRecord){
      return TagChart(
        dataId: tagChartRecord.dataId ,
        tagTitle: tagChartRecord.tagTitle ,
        tagAmount: tagChartRecord.tagAmount ?? 0,
      );
  }
}

///更新時(model=>DB) TagChart=>TagChartRecord
extension ConvertToTagChartRecord on TagChart{
  TagChartRecord toTagChartRecord(TagChart tagChart){
    return TagChartRecord(
      dataId: tagChart.dataId ?? 0,
      tagTitle: tagChart.tagTitle ,
      tagAmount: tagChart.tagAmount ?? 0,
    );
  }
}



///新規挿入時(model=>DB):List<draggingTag>=>List<TagChartRecord>
extension FromDraggingTagConvertToTagChartRecordList on List<DraggingTagChart>{
  List<TagChartRecord> dragToTagChartRecordList(
      List<DraggingTagChart> draggingTags,){
    final tagChartRecordList =
    draggingTags.map((draggingTag) {
      return TagChartRecord(
          dataId: draggingTag.orderId!,
          tagTitle:draggingTag.tagTitle ?? '',
          tagAmount:draggingTag.tagAmount ?? 0,
      );
    }).toList();
    return tagChartRecordList;
  }
}
