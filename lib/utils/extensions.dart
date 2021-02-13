


//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

import 'package:compare_2way/data_models/comparison_item.dart';

extension ConvertToComparisonItemRecord on ComparisonItem{

  ComparisonItemRecord toRecord(ComparisonItem comparisonItem){
    // var wordRecord = WordRecord();のインスタンスは作らず直接代入
    //varではなくfinalでも良い
    final  comparisonItemRecord = ComparisonItemRecord(
      dataId:comparisonItem.detaId,
      itemTitle:comparisonItem.itemTitle ?? '',

      way1Title:comparisonItem.way1Title ?? '',
      way1Merit: comparisonItem.way1Merit ?? '',//List[]?
      way1DeMerit: comparisonItem.way1Demerit?? '',
      way1Evaluate:comparisonItem.way1Evaluate ?? 0,

      way2Title:comparisonItem.way2Title ?? '',
      way2Merit: comparisonItem.way2Merit ?? '',//List[]?
      way2DeMerit: comparisonItem.way2Demerit?? '',
      way2Evaluate:comparisonItem.way2Evaluate ?? 0,

      way3Title:comparisonItem.way3Title ?? '',
      way3Merit: comparisonItem.way3Merit ?? '',//List[]?
      way3DeMerit: comparisonItem.way3Demerit?? '',
      way3Evaluate:comparisonItem.way3Evaluate ?? 0,

      tags:comparisonItem.tags??'',
      favorite:comparisonItem.favorite ?? false,
      conclusion comparisonItem.conclusion ?? '',
    );
    return comparisonItemRecord;
  }
}

