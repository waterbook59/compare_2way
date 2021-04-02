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

class AlwaysDisabledFocusNode extends FocusNode{
  @override
  bool get hasFocus => false;
}