import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OverViewList extends StatelessWidget {
  const OverViewList(
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
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: '削除',
          color: Colors.red,
          icon: Icons.remove_circle_outline,
          onTap: () {
            print('削除します');
            onDelete();
          },
        )
      ],
      child: Container(
        //todo decorationはインスタンス設定してすっきり書く
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
//          isThreeLine: true,
        ),
      ),
    );
  }
}
