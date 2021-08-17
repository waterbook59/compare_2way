//ReorderableListのアイテムの情報格納

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DraggingItemData {
  DraggingItemData(this.title, this.key,this.id);
  final String title;
  // Each item in reorderable list needs stable and unique key
  final Key key;
  final String id;
}