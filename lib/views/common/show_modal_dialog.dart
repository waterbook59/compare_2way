import 'package:flutter/material.dart';

///共通で使えるトップレベル関数
///戻り値、showModalBottomSheet<T>の型をvoid,showModalDialogの文頭はs
void showModalDialog(
    {required BuildContext context,
    required Widget dialogWidget,
      //画面の半分以上いく場合はtrue
    required bool isScrollable,}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (context) => dialogWidget,
    isScrollControlled: isScrollable,
//    backgroundColor: dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10), //topだけならタテだけ
    ),),
  );
}
