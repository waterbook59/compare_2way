import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TagList extends StatelessWidget {
  const TagList(
      {this.title,
        this.tagAmount,
        this.createdAt,
        this.onDelete,
        this.onTap,
        this.listDecoration});

  final String title;
  final int tagAmount;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final BoxDecoration listDecoration;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

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
          leading: Icon(CupertinoIcons.tag_solid,size: 40,color: primaryColor,),
          onTap: onTap,
          title: Text(title),
          //conclusionはConsumerで初回描画されない
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('アイテム数：$tagAmountアイテム'),
//              Text(createdAt),
            ],
          ),
          trailing:Icon(Icons.arrow_forward_ios) ,
//          isThreeLine: true,
        ),
      ),
    );
  }
}
