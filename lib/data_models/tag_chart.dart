class TagChart{
  TagChart({
    this.tagTitle,
    this.tagAmount,
    this.itemIdList,
//    this.createdAt,
  });

  final String tagTitle;
  final int tagAmount;//同じタグをもつリストの総数
  final List<String> itemIdList;//同じタグをもつcomparisonItemIdのリスト
//  final DateTime createdAt;


  factory TagChart.fromMap(Map<String, dynamic> map) {
    return  TagChart(
      tagTitle: map['tagTitle'] as String,
      tagAmount: map['tagAmount'] as int,
      itemIdList: map['comparisonItemId'] as List<String>,
//          ?.map(( dynamic e ) =>
//      e == null ? null : Product.fromMap(e as Map<String, dynamic>))
//          ?.toList(),


    );
  }


}