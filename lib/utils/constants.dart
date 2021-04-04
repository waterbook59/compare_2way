import 'package:flutter/material.dart';

enum ListEditMode{
  display,
  edit
}

enum ItemEditMode{
  add,
  edit
}

enum CompareScreenStatus {
  set,
  update,
}

enum DisplayList {
  way1Merit,
  way1Demerit,
  way2Merit,
  way2Demerit,
  way3Merit,
  way3Demerit,
}
//CompareScreenのHeaderの編集ボタン
enum CompareEditMenu{
  titleEdit,
  allListDelete,
}

//AddScreenの表示モード
enum AddScreenMode{
  add,
  edit,
}