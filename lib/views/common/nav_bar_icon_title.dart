import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarIconTitle extends StatelessWidget {

  const NavBarIconTitle({this.tagTitle,this.titleIcon});
  final String tagTitle;
  final IconData titleIcon;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(titleIcon,color: Colors.white,),
            const SizedBox(width: 4,),
            Text(
              tagTitle,
              style: middleTextStyle,
            ),
          ],
        ),
        const SizedBox(width: 48,)
      ],
    );
  }
}
