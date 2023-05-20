import 'package:flutter/material.dart';

//const titleFontJa = 'Hiragino Kaku Gothic w6';
//const titleFontEn = 'SF Pro Display Medium';
///ヒラギノ使う場合はassetsにfontsデータを入れる必要なし
const regularFontJa = 'Regular';

///CupertinoNavigationBar
//NavigationMiddle
const middleTextStyle = TextStyle(fontFamily:regularFontJa,fontSize: 18,
    color: Colors.white,);

const middleJaTextStyle =
    TextStyle(fontFamily: regularFontJa, fontSize: 18, color: Colors.white);

//NavigationTrailing
const trailingTextStyle =
    TextStyle(fontFamily: regularFontJa, fontSize: 16, color: Colors.white);

//ListTitle
const listTitleTextStyle=
TextStyle(fontFamily: regularFontJa,  fontWeight:FontWeight.bold );

const subTitleTextStyle =
TextStyle(fontFamily: regularFontJa, fontSize: 14, color: Colors.black54);

//CupertinoActionSheetの文字
const actionSheetTextStyle =
TextStyle(fontFamily: regularFontJa, fontSize: 18, color: Colors.blue);
const actionSheetCationTextStyle =
TextStyle(fontFamily: regularFontJa, fontSize: 18, color: Colors.red);

//CompareScreenタイトル
const itemTitleTextStyle = TextStyle(
  fontFamily: regularFontJa,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

//アコーディオンの丸み
const accordionTopBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(5), topRight: Radius.circular(5),);
const accordionBottomBorderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5),);

//比較のRaisedButton
//var  createButtonBorderRadius = RoundedRectangleBorder(
//  borderRadius: BorderRadius.circular(5),);

const listDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),);

const accordionBackgroundColor = Color(0xFFE0E0E0);
