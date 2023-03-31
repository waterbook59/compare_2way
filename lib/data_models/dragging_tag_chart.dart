//ReorderableTagListのアイテムの情報格納

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// //todo TagChartの要素必要(itemIdList)削除時の時間更新のとき使う
class DraggingTagChart {
  DraggingTagChart({
    this.tagTitle, this.key,this.tagAmount,this.itemIdList,this.orderId,});
  final String? tagTitle;
  // Each item in reorderable list needs stable and unique key
  final Key? key;
  final int? tagAmount;//同じタグをもつリストの総数
  final List<String>? itemIdList;//同じタグをもつcomparisonItemIdのリスト(たぶん表示には使わない)
  final int? orderId;
}
