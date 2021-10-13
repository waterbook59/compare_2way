import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/tag/components/sub/edit_tag_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TagList extends StatelessWidget {
  const TagList({
    this.title,
    this.tagAmount,
    this.createdAt,
    this.onDelete,
    this.onTap,
    this.selectTagIdList,
    this.listNumber,
    this.myFocusNode,
  });

  final String title;
  final int tagAmount;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;

//  final Function(FocusNode) onTap;
  final List<String> selectTagIdList; //tagTitle編集時に更新するIDリスト
  final int listNumber;
  final FocusNode myFocusNode;//todo 完了押した時にfocusNodeのdispose必要かも

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return Slidable(
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
        //todo Container内部の余白調整でListTile幅をタイトに
        //flutterのverが低いのでListTileのtileColorなし
        decoration: BoxDecoration(
          color: //ここでswitch使えない=>即時関数:https://yumanoblog.com/flutter-if-switch/
              (() {
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return Colors.transparent;
                break;
              case TagEditMode.tagTitleEdit:
                return viewModel.selectedIndex == listNumber
                    ? Colors.grey[300]
                    : const Color(0xFFFBE9E7);
                break;
              case TagEditMode.tagDelete:
                return viewModel.selectedIndex == listNumber
                    ? Colors.grey[300]
                    : const Color(0xFFFBE9E7);
                break;
            }
          })(),

//          viewModel.tagEditMode
//              ? Colors.transparent
//              : viewModel.selectedIndex == listNumber
//                  ? Colors.grey[300]
//                  : const Color(0xFFFBE9E7),
          border:
              const Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        child: ListTile(
          leading: Icon(
            CupertinoIcons.tag_solid,
            size: 36,
            color: primaryColor,
          ),
          title: (() {
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return Text(title);
                break;
              case TagEditMode.tagTitleEdit:
                return viewModel.selectedIndex == listNumber
                    ? EditTagTitle(
                        tagTitle: title,
                        selectTagIdList: selectTagIdList,
                        myFocusNode: myFocusNode,
                      )
                    : Text(title);
              case TagEditMode.tagDelete:
              ///編集必要ないので、Text(title)に変更
              return Text(title);
            }
          })(),
//          viewModel.tagEditMode
//              ? Text(title)
//              : viewModel.selectedIndex == listNumber
//                  ? EditTagTitle(
//                      tagTitle: title,
//                      selectTagIdList: selectTagIdList,
//                      myFocusNode: myFocusNode,
//                    )
//                  : Text(title),
          //tagTitleの編集
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('アイテム数：$tagAmountアイテム'),
            ],
          ),
          trailing: (() {
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return const Icon(Icons.arrow_forward_ios);
                break;
              case TagEditMode.tagTitleEdit:
                return Container(
                  width: 24,
                );
                break;
              case TagEditMode.tagDelete:
                return Container(
                  width: 24,
                );
            }
          })(),
//          viewModel.tagEditMode
//              ? const Icon(Icons.arrow_forward_ios)
//              : Container(width: 24,),//編集時>出さない

          ///getTagTitleIdしつlistTileのonTapでfocusNode設定(tagEditModeで場合わけ)
          ///ListTileだけを再ビルドしても反映されない(notifyListenersしてListView含め再ビルド)
          onTap: () {
            getTitleAndFocus(context, onTap, myFocusNode, listNumber);
          },
          //          isThreeLine: true,
        ),
      ),
    );
  }

  Future<void> getTitleAndFocus(BuildContext context, VoidCallback onTap,
      FocusNode myFocusNode, int listNumber) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditFocus(listNumber);
    onTap();
  }
}
