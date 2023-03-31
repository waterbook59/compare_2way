import 'package:flutter/material.dart';

class SelectItemList extends StatelessWidget {
  const SelectItemList(
      {Key? key, required this.title,
        required this.conclusion,
        required this.createdAt,
        this.onDelete,
        required this.onTap,
        required this.listDecoration,}) : super(key: key);

  final String title;
  final String conclusion;
  final String createdAt;
  final VoidCallback? onDelete;
  final VoidCallback onTap;
  final BoxDecoration listDecoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}
