import 'package:compare_2way/views/compare/add_tag_dialog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChip extends StatefulWidget {
  @override
  _AddChipState createState() => _AddChipState();
}

class _AddChipState extends State<AddChip>{


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
    PageRouteBuilder<void>(
      opaque: false,
      pageBuilder: (context,_, __){
        return AddTagDialogPage();
      }
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

