import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';

class NavBarIconTitle extends StatelessWidget {
  const NavBarIconTitle(
      {Key? key,
      required this.tagTitle,
      this.titleIcon,
      required this.leftFlex,
      required this.centerFlex,
      required this.rightFlex,})
      : super(key: key);
  final String tagTitle;
  final IconData? titleIcon;
  final int leftFlex;
  final int centerFlex;
  final int rightFlex;

  @override
  Widget build(BuildContext context) {
    //Flexibleで左右に空き1:2(タイトル):1https://qiita.com/kalupas226/items/5aa41ca409730606000f
    return Row(
      children: [
        Expanded(
          flex: leftFlex,
          child: Container(),
        ),
        Icon(
          titleIcon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          ///右側が広がるので文字が左寄りになってしまう
          flex: centerFlex,
          child: Text(
            tagTitle,
            style: middleTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: rightFlex,
          child: Container(),
        ),
      ],
    );
  }
}
