import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

//const titleFontJa = 'Hiragino Kaku Gothic w6';
//const titleFontEn = 'SF Pro Display Medium';
///ヒラギノ使う場合はassetsにfontsデータを入れる必要なし
const regularFontJa = 'Hiragino Kaku Gothic ProN';

///CupertinoNavigationBar
//NavigationMiddle
const middleTextStyle = TextStyle(fontSize: 18, color: Colors.white);

const middleJaTextStyle =
    TextStyle(fontFamily: regularFontJa, fontSize: 18, color: Colors.white);

//NavigationTrailing
const trailingTextStyle =
    TextStyle(fontFamily: regularFontJa, fontSize: 14, color: Colors.white);

//アコーディオンの丸み
const accordionTopBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight:Radius.circular(5));
const accordionBottomBorderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(5),
    bottomRight:Radius.circular(5));



