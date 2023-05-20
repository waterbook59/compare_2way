import 'package:compare_2way/style.dart';
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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {onDelete();},
            backgroundColor: Colors.red,
            icon: Icons.remove_circle_outline,
            label: 'アイテムを削除',)
        ],
      ),
      child: DecoratedBox(
        decoration: listDecoration,
        child: ListTile(
          onTap: onTap,
          title: Text(title,
            style: listTitleTextStyle,
          ),
          //conclusionはConsumerで初回描画されない
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8,),
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical:1),
                      child: Text(
                        '結論',
                        style: TextStyle(fontSize: 14,
                          color: Colors.white,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),

                  Text(conclusion!,style: const TextStyle(
                    color: Colors.black,),),
                ],
              ),
              const SizedBox(height: 4,),
              Text(createdAt,style: const TextStyle(fontSize: 12),),
            ],
          ),
          trailing:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_forward_ios),
            ],
          ),
//          isThreeLine: true,
        ),
      ),
    );
  }
}
