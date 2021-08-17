import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/edit_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';

class ReorderableEditList extends StatefulWidget {

  const ReorderableEditList({this.draggedItems});
//   final List<ComparisonOverview> allItemList;
  final List<DraggingItemData> draggedItems;

  @override
  _ReorderableEditListState createState() => _ReorderableEditListState();
}


class ItemData {
  ItemData(this.title, this.key,this.id);
  final String title;
  // Each item in reorderable list needs stable and unique key
  final Key key;
  final String id;
}

//enum DraggingMode {
//  iOS,
//  Android,
//}


class _ReorderableEditListState extends State<ReorderableEditList> {

  //List<CompareViewModel>の内容をList<ItemData>へ変換
  final List<ItemData> _items =<ItemData>[];

//  _ReorderableEditListState(){
//    _items = [];
//    widget.allItemList.map((overview){
//      return ItemData(overview.itemTitle,ValueKey());
//    }).toList();


    //todo allItemListに変更するとThe getter 'allItemList' was called on null.
//    for (int i = 0; i < widget.allItemList.length; ++i) {
//      final overView = widget.allItemList[i];
//      String label = "List item $i";
//      if (i == 5) {
//        label += ". This item has a long label and will be wrapped.";
//      }
//      _items.add(ItemData(overView.itemTitle, ValueKey(i)));
//    }
//  }

  int _indexOfKey(Key key) {
//    return _items.indexWhere((ItemData d) => d.key == key);
    return widget.draggedItems.indexWhere((DraggingItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);


//    final draggedItem = _items[draggingIndex];
//    setState(() {
//      debugPrint("Reordering $item -> $newPosition");
//      _items.removeAt(draggingIndex);
//      _items.insert(newPositionIndex, draggedItem);

      final draggedItem =  widget.draggedItems[draggingIndex];
      setState(() {
        debugPrint("Reordering $item -> $newPosition");
        widget.draggedItems.removeAt(draggingIndex);
        widget.draggedItems.insert(newPositionIndex, draggedItem);

    });
    return true;
  }

  void _reorderDone(Key item) {
//    final draggedItem = _items[_indexOfKey(item)];
    final draggedItem = widget.draggedItems[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

//  DraggingMode _draggingMode = DraggingMode.iOS;

//  @override
//  void initState() {
//    for (int i = 0; i < widget.allItemList.length; ++i) {
//      final overView = widget.allItemList[i];
//      _items.add(ItemData(overView.itemTitle, ValueKey(i),
//          overView.comparisonItemId));
//    }
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: _reorderCallback,
      onReorderDone: _reorderDone,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
          itemCount:
//          _items.length,
          widget.draggedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(
              data:
//            _items[index],
    widget.draggedItems[index],
              // first and last attributes affect border drawn during dragging
              isFirst: index == 0,
//              isLast: index == _items.length - 1,
              isLast: index == _items.length - 1,
              onTap: (){
                print('onTap!!!');
                final viewModel = Provider.of<CompareViewModel>(context, listen: false)
                  ..checkDeleteIcon( widget.draggedItems[index].id);
              },
//              draggingMode: _draggingMode,
            );

          }
      ),
//      CustomScrollView(
//        shrinkWrap: true,
//        physics: const NeverScrollableScrollPhysics(),
//        // cacheExtent: 3000,
//        slivers: <Widget>[
//          SliverAppBar(
//            actions: <Widget>[
//              PopupMenuButton<DraggingMode>(
//                child: Container(
//                  alignment: Alignment.center,
//                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                  child: Text("Options"),
//                ),
//                initialValue: _draggingMode,
//                onSelected: (DraggingMode mode) {
//                  setState(() {
//                    _draggingMode = mode;
//                  });
//                },
//                itemBuilder: (BuildContext context) =>
//                <PopupMenuItem<DraggingMode>>[
//                  const PopupMenuItem<DraggingMode>(
//                      value: DraggingMode.iOS,
//                      child: Text('iOS-like dragging')),
//                  const PopupMenuItem<DraggingMode>(
//                      value: DraggingMode.Android,
//                      child: Text('Android-like dragging')),
//                ],
//              ),
//            ],
//            pinned: true,
//            expandedHeight: 150.0,
//            flexibleSpace: const FlexibleSpaceBar(
//              title: const Text('Demo'),
//            ),
//          ),
//          SliverPadding(
//              padding: EdgeInsets.only(
//                  bottom: MediaQuery.of(context).padding.bottom),
//              sliver: SliverList(
//                delegate: SliverChildBuilderDelegate(
//                      (BuildContext context, int index) {
//                    return Item(
//                      data: _items[index],
//                      // first and last attributes affect border drawn during dragging
//                      isFirst: index == 0,
//                      isLast: index == _items.length - 1,
//                      draggingMode: _draggingMode,
//                    );
//                  },
//                  childCount: _items.length,
//                ),
//              )),
//        ],
//      ),
    );
  }
}


class Item extends StatelessWidget {
  const Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.onTap,
//    this.draggingMode,
  });

//  final ItemData data;
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