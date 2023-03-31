import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';

///モデルクラスのイメージは取得するときのリスト１行分に何の項目を入れるか
class ComparisonItem {
  ComparisonItem(
      { this.dataId,
        this.comparisonItemId,
        this.itemTitle,
      this.way1Title,
      this.way1Merit,
      this.way1Demerit,
        this.way1MeritEvaluate,
        this.way1DemeritEvaluate,
      this.way2Title,
      this.way2Merit,
      this.way2Demerit,
        this.way2MeritEvaluate,
        this.way2DemeritEvaluate,
      this.way3Title,
      this.way3Merit,
      this.way3Demerit,
        this.way3MeritEvaluate,
        this.way3DemeritEvaluate,
      this.tagTitles,//dataIdに紐づくタグのタイトルだけ
      this.favorite,
      this.conclusion,
        this.createdAt,});

  /// //todo dataIdはrequiredでもいい？
  final int? dataId;
  final String? comparisonItemId;
  final String? itemTitle;

  final String? way1Title;
  /// //todo リストなのでway1Meritsにリファクタリング
  final List<Way1Merit>? way1Merit;
  final List<Way1Demerit>? way1Demerit;
  final int? way1MeritEvaluate;
  final int? way1DemeritEvaluate;

  final String? way2Title;
  final List<Way2Merit>? way2Merit;
  final List<Way2Demerit>? way2Demerit;
  final int? way2MeritEvaluate;
  final int? way2DemeritEvaluate;

  final String? way3Title;
  final List<Way3Merit>? way3Merit;
  final List<Way3Demerit>? way3Demerit;
  final int? way3MeritEvaluate;
  final int? way3DemeritEvaluate;

  final List<Tag>? tagTitles;
  final bool? favorite;

  final String? conclusion;
  final DateTime? createdAt;
}

//List<CompareItem>取得できれば下記いらないはず
//class CompareItemList{
//
//  CompareItemList({this.id,this.title,this.tags,this.compareItems});
//  final int id;
//  final String title;
//  final List<Tag> tags;
//  final List<CompareItem> compareItems;
//}
