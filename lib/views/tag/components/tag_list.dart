import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/tag/components/sub/edit_tag_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TagList extends StatelessWidget {
  const TagList(
      {this.title,
        this.tagAmount,
        this.createdAt,
        this.onDelete,
        this.onTap,
        this.listDecoration,
        this.selectTagIdList});

  final String title;
  final int tagAmount;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;
//  final Function(String) onTap;
  final BoxDecoration listDecoration;
  final List<String> selectTagIdList;//tagTitle編集時に更新するIDリスト

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

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
          title: viewModel.tagEditMode
            ? Text(title)
            : EditTagTitle(
            tagTitle: title,selectTagIdList: selectTagIdList,),//tagTitleの編集
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('アイテム数：$tagAmountアイテム'),
//              Text(createdAt),
            ],
          ),
          trailing:const Icon(Icons.arrow_forward_ios) ,
//          isThreeLine: true,
        ),
      ),
    );
  }
}
