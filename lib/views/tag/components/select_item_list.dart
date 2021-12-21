import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SelectItemList extends StatelessWidget {
  const SelectItemList(
      {this.title,
        this.conclusion,
        this.createdAt,
        this.onDelete,
        this.onTap,
        this.listDecoration});

  final String title;
  final String conclusion;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final BoxDecoration listDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: listDecoration,
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        //conclusionはConsumerで初回描画されない
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('結論：$conclusion'),
            Text(createdAt),
          ],
        ),
        trailing:const Icon(Icons.arrow_forward_ios),
//          isThreeLine: true,
      ),
    );
  }
}
