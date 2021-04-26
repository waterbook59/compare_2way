import 'package:compare_2way/data_models/comparison_item_id.dart';

class Tag{
  Tag({this.comparisonItemId,this.tagId,this.tagTitle});
  final int tagId;
  final String tagTitle;
  final ComparisonItemId comparisonItemId;

}