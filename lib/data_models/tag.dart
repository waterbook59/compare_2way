import 'package:compare_2way/data_models/comparison_item_id.dart';

class Tag{
  Tag({this.comparisonItemIds,this.tagId,this.tagTitle});
  final int tagId;
  final String tagTitle;
  final List<ComparisonItemId> comparisonItemIds;

}