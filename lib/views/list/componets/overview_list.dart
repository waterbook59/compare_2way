import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OverViewList extends StatelessWidget {
   OverViewList(
      {this.title, this.conclusion, this.createdAt, this.onDelete,});

  final String title;
  final String conclusion;
  final String createdAt;
  final VoidCallback onDelete;


  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
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
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Colors.grey))),
        child: ListTile(
          title: Text(title),
          //conclusionはConsumerで初回描画されない
          subtitle: Text(conclusion),
        ),
      ),
    );
  }
}
