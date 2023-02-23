import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OverViewList extends StatelessWidget {
  const OverViewList(
      {Key? key, required this.title,
      this.conclusion,
      required this.createdAt,
      required this.onDelete,
      required this.onTap,
      required this.listDecoration,}) : super(key: key);

  final String title;
  final String? conclusion;
  final String createdAt;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final BoxDecoration listDecoration;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(onPressed: (_) {
          print('削除します');
          onDelete();
          },
            backgroundColor: Colors.red,
            icon: Icons.remove_circle_outline,
            label: '削除',)
        ],
      ),
      ///ver.0.6.0以下で使用
      // actionPane: const SlidableScrollActionPane(),
      // secondaryActions: [
      //   IconSlideAction(
      //     caption: '削除',
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
          onTap: onTap,
          title: Text(title),
          //conclusionはConsumerで初回描画されない
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('結論：$conclusion'),
              Text(createdAt),
            ],
          ),
          trailing:const Icon(Icons.arrow_forward_ios),
//          isThreeLine: true,
        ),
      ),
    );
  }
}
