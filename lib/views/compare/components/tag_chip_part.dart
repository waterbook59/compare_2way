import 'package:compare_2way/views/compare/dialog_page/tag_dialog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagChipPart extends StatefulWidget {
  @override
  _TagChipPartState createState() => _TagChipPartState();
}

class _TagChipPartState extends State<TagChipPart>{


  final _testChipList =<Chip>[];



  @override
  Widget build(BuildContext context) {
    return Padding(//cupertino
      padding: const EdgeInsets.symmetric(horizontal:25),
      child: Column(
        children: [
          Row(//cupertino
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Expanded(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 0,
                direction: Axis.horizontal,
                children: _testChipList,
          )
          ),
            ],
          ),

          ActionChip(
            avatar: const Icon(Icons.add_circle_outline),
            label: const Text('タグを追加'),
            onPressed: _addChip,
          ),
        ],
      ),
    );
  }

  void _addChip() {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) =>TagDialogPage(),
      fullscreenDialog: true,//下から
    )
    );

    setState(() {
      _testChipList.add(
        Chip(label: Text('追加チップ'),
      ),
      );
    });
  }
}
