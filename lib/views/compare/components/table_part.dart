import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePart extends StatelessWidget {

  TablePart({this.way1Title,this.way2Title});
  final String  way1Title;
  final String way2Title;

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Container(),
            IconTitle(
                title: 'メリット',
                iconData: Icons.thumb_up ,
                iconColor: accentColor,
              ),
              IconTitle(
                title:'デメリット' ,
                iconData: Icons.thumb_down,
                iconColor: accentColor,
              ),
            ]
          ),
          TableRow(
            children: [
              Text(way1Title),
              Text('◎'),
              Text('✖️'),
            ]
          ),
          TableRow(
            children: [
              Text(way2Title),
            Text('○'),
            Text('△️'),
            ]

          ),
        ],
      ),
    );
  }
}
