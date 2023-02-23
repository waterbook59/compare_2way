import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/tag/components/sub/edit_tag_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TagList extends StatelessWidget {
  const TagList({Key? key,
    required this.title,
    required this.tagAmount,
    this.createdAt,
    required this.onDelete,
    required this.onTap,
    required this.selectTagIdList,
    required this.listNumber,
    required this.myFocusNode,
  }) : super(key: key);

  final String title;
  final int tagAmount;
  final String? createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;

//  final Function(FocusNode) onTap;
  final List<String> selectTagIdList; //tagTitle編集時に更新するIDリスト
  final int listNumber;
  final FocusNode myFocusNode; //todo 完了押した時にfocusNodeのdispose必要かも

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    // final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
///onPressedがSlidableActionCallback = void Function(BuildContext context);なので
            ///()空だとNG=>(_):void Function(BuildContext)?に変更
            onPressed: (_) {
              print('削除します');
              onDelete();
            },
            backgroundColor: Colors.red,
            icon: Icons.remove_circle_outline,
            label: 'タグを削除',
          ),
        ],
      ),
      ///ver.0.6.0以下で使用
      // actionPane: const SlidableScrollActionPane(),
      // secondaryActions: [
      //   IconSlideAction(
      //     caption: 'タグを削除',
      //     color: Colors.red,
      //     icon: Icons.remove_circle_outline,
      //     onTap: () {
      //       print('削除します');
      //       onDelete();
      //     },
      //   )
      // ],
      child: DecoratedBox(
        decoration: listDecoration,
        child: ListTile(
          tileColor: (() {
            //ここでswitch使えない=>即時関数:https://yumanoblog.com/flutter-if-switch/
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return Colors.transparent;
              case TagEditMode.tagTitleEdit:
                return viewModel.selectedIndex == listNumber
                    ? Colors.grey[300]
                    : const Color(0xFFFBE9E7);
              case TagEditMode.tagDelete:
                return viewModel.selectedIndex == listNumber
                    ? Colors.grey[300]
                    : const Color(0xFFFBE9E7);
            }
          })(),
          leading: Icon(
            CupertinoIcons.tag_solid,
            size: 32,
            color: primaryColor,
          ),
          title: (() {
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return Text(title);
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
          //tagTitleの編集
          /// ListTile幅をタイトにするのにsubtitle=>Columnへ変更
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '',
                style: TextStyle(fontSize: 9),
              ),
              Text('アイテム数：$tagAmountアイテム'),
              const SizedBox(
                height: 4,
              ),
            ],
          ),

          trailing: (() {
            switch (viewModel.tagEditMode) {
              case TagEditMode.normal:
                return const Icon(Icons.arrow_forward_ios);
              case TagEditMode.tagTitleEdit:
                return Container(
                  width: 24,
                );
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
      ), //Container
    );
  }

  Future<void> getTitleAndFocus(BuildContext context, VoidCallback onTap,
      FocusNode myFocusNode, int listNumber,) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditFocus(listNumber);
    onTap();
  }
}
