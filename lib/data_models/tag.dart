import 'package:compare_2way/data_models/comparison_item_id.dart';

class Tag{
  Tag({
    this.comparisonItemId,
    this.tagId,
    this.tagTitle,
    this.createdAt,
    this.createAtToString});
  //tagTitleをprimaryKeyに使用しない
  final int tagId;
  final String comparisonItemId;
  final String tagTitle;
  final DateTime createdAt;
  //登録順でデータ取得のためcreateAtToString追加
  final String createAtToString;

//Map型への変換
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comparisonItemId': comparisonItemId,
      'tagId':tagId,
      'tagTitle':tagTitle,
      'createdAt': createdAt,
      'createAtToString':createAtToString,
    };
  }


}