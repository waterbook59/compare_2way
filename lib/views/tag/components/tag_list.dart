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
        this.selectTagIdList,
      this.listNumber,
      this.myFocusNode,});

  final String title;
  final int tagAmount;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;
//  final Function(FocusNode) onTap;
  final List<String> selectTagIdList;//tagTitle編集時に更新するIDリスト
  final int listNumber;
  final FocusNode myFocusNode;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return
      Slidable(
      actionPane: const SlidableScrollActionPane(),
          secondaryActions: [
          IconSlideAction(
          caption: 'タグを削除',
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
            color:
            viewModel.tagEditMode
            ?Colors.transparent
            :viewModel.selectedIndex == listNumber
                ?Colors.grey[400]
                :Colors.transparent,
              border:const Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey)),
        ),
          child: ListTile(
            leading: Icon(CupertinoIcons.tag_solid,
              size: 40,color: primaryColor,),
            title:
            viewModel.tagEditMode
                ? Text(title)
                : viewModel.selectedIndex == listNumber
                  ? EditTagTitle(
                    tagTitle: title,
                    selectTagIdList:selectTagIdList,
                    myFocusNode: myFocusNode,)
                  :Text(title),//tagTitleの編集
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('アイテム数：$tagAmountアイテム'),
                ],
                ),
                trailing:const Icon(Icons.arrow_forward_ios) ,
            ///getTagTitleIdしつlistTileのonTapでfocusNode設定(tagEditModeで場合わけ)
            ///ListTileだけを再ビルドしても反映されない(notifyListenersしてListView含め再ビルド)
            onTap:(){
            getTitleAndFocus(
                context,onTap,myFocusNode,listNumber);
            },
            //          isThreeLine: true,
          ),
          ),
          );

  }

  Future<void> getTitleAndFocus(BuildContext context,
      VoidCallback onTap, FocusNode myFocusNode, int listNumber) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
   await viewModel.changeEditFocus(listNumber);
    onTap();
  }

}