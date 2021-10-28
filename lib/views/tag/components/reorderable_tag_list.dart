import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/data_models/dragging_tag_chart.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/edit_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';

class ReorderableTagList extends StatefulWidget {

  const ReorderableTagList({this.draggedTags});
//   final List<ComparisonOverview> allItemList;
  final List<DraggingTagChart> draggedTags;

  @override
  _ReorderableTagListState createState() => _ReorderableTagListState();
}

class _ReorderableTagListState extends State<ReorderableTagList> {

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: _reorderCallback,
      onReorderDone: _reorderDone,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.draggedTags.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(
              data: widget.draggedTags[index],
              // first and last attributes affect border drawn during dragging
              isFirst: index == 0,
              isLast: index == widget.draggedTags.length - 1,
              onTap: (){
                final viewModel = Provider.of<CompareViewModel>(
                    context, listen: false)
                  ..checkDeleteTag(widget.draggedTags[index].tagTitle,
//                      widget.draggedTags[index].itemIdList IdList中は空
                  );
              },

            );

          }
      ),
    );
  }

  int _indexOfKey(Key key) {
    return widget.draggedTags.indexWhere((DraggingTagChart d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    final draggingIndex = _indexOfKey(item);
    final newPositionIndex = _indexOfKey(newPosition);

    final draggedTab =  widget.draggedTags[draggingIndex];
    //リストの位置を変更した形でDBへ保存が必要(comparisonItemIdからDB検索してdataIdを書き換えする)
    setState(() {
//      debugPrint('Reordering $item -> $newPosition');
      widget.draggedTags.removeAt(draggingIndex);
      widget.draggedTags.insert(newPositionIndex, draggedTab);
    });

    return true;
  }

  void _reorderDone(Key item) {
//    final draggedItem = widget.draggedItems[_indexOfKey(item)];
//    debugPrint('Reordering finished for ${draggedItem.title}&$item}');
    ///TagPage並び替え後のDBの順番入れ替え、まずdataIdで行ってみる
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..changeTagListOrder(widget.draggedTags);
  }

}


class Item extends StatelessWidget {
  const Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.onTap,
  });

  final DraggingTagChart data;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      final placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    ///ListTile右側の並び替え部
    final dragHandle =
    ReorderableListener(
      child: Container(
        padding: const EdgeInsets.only(right: 18, left: 18),
        color: const Color(0x08000000),
        child: const Center(
          child: Icon(Icons.reorder, color: Color(0xFF888888)),
        ),
      ),
    );

    final content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              ///ListTile部分
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      //todo 表示用編集(tagAmount項目を加える)
                      child: EditListTile(
                          title: data.tagTitle,
                          onTap: onTap,
                          icon:
                          viewModel.tempoDeleteList.contains(data.tagTitle)
                              ? Icon(
                            CupertinoIcons.checkmark_circle_fill,
                            size: 30,
                            color: accentColor,
                          )
                              :Icon(
                            CupertinoIcons.circle,
                            size: 30,
                            color: primaryColor,
                          )
                      ),
                    ),
                  ),
                  ///ListTile右側の並び替え部
                  dragHandle,
                ],
              ),
            ),
          )),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }
}