import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';

///モデルクラスのイメージは取得するときのリスト１行分に何の項目を入れるか
class ComparisonItem {
  ComparisonItem(
      {this.dataId,
      this.itemTitle,
      this.way1Title,
      this.way1Merit,
      this.way1Demerit,
        this.way1Evaluate,
      this.way2Title,
      this.way2Merit,
      this.way2Demerit,
        this.way2Evaluate,
      this.way3Title,
      this.way3Merit,
      this.way3Demerit,
        this.way3Evaluate,
      this.tags,
      this.favorite,
      this.conclusion});

  final int dataId;
  final int itemTitle;

  final String way1Title;
  final List<Way1Merit> way1Merit;
  final List<Way1Demerit> way1Demerit;
  final int way1Evaluate;

  final String way2Title;
  final List<Way2Merit> way2Merit;
  final List<Way2Demerit> way2Demerit;
  final int way2Evaluate;

  final String way3Title;
  final List<Way3Merit> way3Merit;
  final List<Way3Demerit> way3Demerit;
  final int way3Evaluate;

  final List<Tag> tags;
  final bool favorite;

  final String conclusion;
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