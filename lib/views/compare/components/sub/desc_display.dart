import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DescDisplay extends StatelessWidget {

   const DescDisplay({this.description,this.textColor});

  final String description;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return             Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        padding:const EdgeInsets.only(left: 4,top: 16,right: 4),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[ Text(description, style: TextStyle(color: textColor),),
              const SizedBox(height: 4,)
            ]));
  }
}
