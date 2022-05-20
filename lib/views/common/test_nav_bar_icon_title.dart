import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestNavBarIconTitle extends StatelessWidget {

  const TestNavBarIconTitle({this.tagTitle,this.titleIcon});
  final String tagTitle;
  final IconData titleIcon;

  @override
  Widget build(BuildContext context) {
    //Flexibleで左右に空き1:2(タイトル):1https://qiita.com/kalupas226/items/5aa41ca409730606000f
    return
      Row(
         children: [
           Expanded(
             flex: 1,
             child: Container(),
           ),
           Icon(titleIcon,color: Colors.white,),
           const SizedBox(width: 4,),
           Expanded(///右側が広がるので文字が左寄りになってしまう
             flex: 2,
             child: Container(
               child:   Text(
                 tagTitle,
                 style: middleTextStyle,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
           ),
           Expanded(
             flex: 1,
             child: Container(),
           ),
         ],
       );
  }
}
