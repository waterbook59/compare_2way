import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagChips extends StatefulWidget {

  const TagChips({this.onSubmitted});
  final ValueChanged<List<String>> onSubmitted;

  @override
  _TagChipsState createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {

  final  _testChips =<Chip>[];
  final _chipLabels =<String>[];

  @override
  Widget build(BuildContext context) {
    // Row[tagChipList,TagInputChip]
  return Wrap(
    alignment: WrapAlignment.start,
    direction: Axis.horizontal,
    spacing: 8,
    runSpacing: 0,
    children:
    [
//      Row(
//        children:List<Widget>.generate(_chipLabel.length, (int index){
//          return Chip(label: Text(_chipLabel[index]));
//        }).toList(),
//      ),

          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 0,
            direction: Axis.horizontal,
            children:_testChips,),

              TagInputChip(
                onSubmitted: (input){
                  ///chipsリストへ追加
                  final inputChip = Chip(label: Text(input),);
                  _testChips.add(inputChip);
                  _chipLabels.add(input);
                  //tag_dialog_pageへタグタイトルのリスト上げる
                  widget.onSubmitted(_chipLabels);
                  setState(() {
                  });
                },),


//        ],
//      ),
    ],
  );
  }
}

