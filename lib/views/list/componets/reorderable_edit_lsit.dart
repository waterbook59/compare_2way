import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/edit_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart' as pk;
import 'package:provider/provider.dart';

class ReorderableEditList extends StatefulWidget {

  const ReorderableEditList({required this.draggedItems});
//   final List<ComparisonOverview> allItemList;
  final List<DraggingItemData> draggedItems;

  @override
  _ReorderableEditListState createState() => _ReorderableEditListState();
}

class _ReorderableEditListState extends State<ReorderableEditList> {

  @override
  Widget build(BuildContext context) {
    return pk.ReorderableList(
      onReorder: _reorderCallback,
      onReorderDone: _reorderDone,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.draggedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(
              data: widget.draggedItems[index],
              // first and last attributes affect border drawn during dragging
              isFirst: index == 0,
              isLast: index == widget.draggedItems.length - 1,
              onTap: (){
        Provider.of<CompareViewModel>(context, listen: false)
                .checkDeleteIcon(widget.draggedItems[index].comparisonItemId!);
              },

            );

          }
      ,),
    );
  }

  int _indexOfKey(Key key) {
    return widget.draggedItems.indexWhere((DraggingItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    final draggingIndex = _indexOfKey(item);
    final newPositionIndex = _indexOfKey(newPosition);

    final draggedItem =  widget.draggedItems[draggingIndex];
    //リストの位置を変更した形でDBへ保存が必要(comparisonItemIdからDB検索してdataIdを書き換えする)
    setState(() {
//      debugPrint('Reordering $item -> $newPosition');
      widget.draggedItems.removeAt(draggingIndex);
      widget.draggedItems.insert(newPositionIndex, draggedItem);
    });

    return true;
  }

  void _reorderDone(Key item) {
//    final draggedItem = widget.draggedItems[_indexOfKey(item)];
//    debugPrint('Reordering finished for ${draggedItem.title}&$item}');
    Provider.of<CompareViewModel>(context, listen: false)
    .changeCompareListOrder(widget.draggedItems);
  }

}


class Item extends StatelessWidget {
  const Item({
    required this.data,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final DraggingItemData data;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  Widget _buildChild(BuildContext context, pk.ReorderableItemState state) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    BoxDecoration decoration;

    if (state == pk.ReorderableItemState.dragProxy ||
        state == pk.ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      final placeholder = state == pk.ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context),),
          color: placeholder ? null : Colors.white,);
    }

    ///ListTile右側の並び替え部
    final dragHandle =
    pk.ReorderableListener(
      child: Container(
        padding: const EdgeInsets.only(right: 18, left: 18),
        color: const Color(0x08000000),
        child: const Center(
          child: Icon(Icons.reorder, color: Color(0xFF888888)),
        ),
      ),
    );

    final content = DecoratedBox(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == pk.ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              ///ListTile部分
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: EditListTile(
                        title: data.title!,
                        onTap: onTap,
                        icon:
                      viewModel.deleteItemIdList.contains(data.comparisonItemId)
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
                      ,),
                    ),
                  ),
                  ///ListTile右側の並び替え部
                  dragHandle,
                ],
              ),
            ),
          ),),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return pk.ReorderableItem(
        key: data.key!, //
        childBuilder: _buildChild,);
  }
}
