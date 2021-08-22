//ReorderableListのアイテムの情報格納

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DraggingItemData {
  DraggingItemData({this.title, this.key,this.comparisonItemId,this.orderId});
  final String title;
  // Each item in reorderable list needs stable and unique key
  final Key key;
  final String comparisonItemId;
  final int orderId;
}