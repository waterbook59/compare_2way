import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/edit_list_tile.dart';
//Itemクラス引っ張ってきている
//import 'package:compare_2way/views/list/componets/reorderble_edit_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';

class ReorderableStatelessList extends StatelessWidget {

  const ReorderableStatelessList({this.draggedItems});
  final List<DraggingItemData> draggedItems;

  //List<CompareViewModel>の内容をList<ItemData>へ変換
//  final List<ItemData> _items =<ItemData>[];


  @override
  Widget build(BuildContext context) {

    return ReorderableList(
      onReorder: (item,newPosition)=>_reorderCallback(item,newPosition,context),
      onReorderDone: _reorderDone,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: draggedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(
              data: draggedItems[index],
              // first and last attributes affect border drawn during dragging
              isFirst: index == 0,
              isLast: index == draggedItems.length - 1,
              onTap: (){
                print('onTap!!!');
                final viewModel = Provider.of<CompareViewModel>(context, listen: false)
                  ..checkDeleteIcon(draggedItems[index].id);
              },
//              draggingMode: _draggingMode,
            );

          }
      ),
    );
  }

  int _indexOfKey(Key key) {
    return draggedItems.indexWhere((DraggingItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition,BuildContext context) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);
    final draggedItem = draggedItems[draggingIndex];
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //todo viewModelのdraggedItemsの位置変更メソッド&notifyListeners
    viewModel.dragItem(draggingIndex,newPositionIndex,draggedItem);
//    setState(() {
//      debugPrint("Reordering $item -> $newPosition");
//      _items.removeAt(draggingIndex);
//      _items.insert(newPositionIndex, draggedItem);
//    });
    //todo 常にtrue返しだと入れ替わらない？？？
    return true;
  }



  void _reorderDone(Key item) {
    final draggedItem = draggedItems[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }
}


//class ItemData {
//  ItemData(this.title, this.key,this.id);
//  final String title;
//  // Each item in reorderable list needs stable and unique key
//  final Key key;
//  final String id;
//}

//todo data_modelsへwidget分割
class Item extends StatelessWidget {
  const Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.onTap,
//    this.draggingMode,
  });

  final DraggingItemData data;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;
//  final DraggingMode draggingMode;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
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
//    Widget
    final dragHandle =
//    draggingMode == DraggingMode.iOS
//        ?
    ReorderableListener(
      child: Container(
        padding: EdgeInsets.only(right: 18.0, left: 18.0),
        color: Color(0x08000000),
        child: Center(
          child: Icon(Icons.reorder, color: Color(0xFF888888)),
        ),
      ),
    );
//        : Container();

//    Widget
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
                      child: EditListTile(
                          title: data.title,
                          onTap: onTap,
//                            checkDeleteIcon(context,data.id),
                          icon:
                          viewModel.deleteItemIdList.contains(data.id)
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
//                  Expanded(
//                      child: Padding(
//                        padding:
//                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
//                        child: Text(data.title,
//                            style: Theme
//                                .of(context)
//                                .textTheme
//                                .subtitle1),
//                      )),
                  // Triggers the reordering
                  ///ListTile右側の並び替え部
                  dragHandle,
                ],
              ),
            ),
          )),
    );


//    if (draggingMode == DraggingMode.Android) {
//      content = DelayedReorderableListener(
//        child: content,
//      );
//    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }

//  void checkDeleteIcon(BuildContext context, String itemId) {
//    print('タップで削除アイコン切替');
//    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
//      ..checkDeleteIcon(itemId);
//  }
}