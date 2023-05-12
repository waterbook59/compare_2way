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
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;
    return DecoratedBox(
      decoration: listDecoration,
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        //conclusionはConsumerで初回描画されない
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4,),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
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

                Text(conclusion),
              ],
            ),
            Text(createdAt,style: TextStyle(fontSize: 12),),
          ],
        ),
        trailing:const Icon(Icons.arrow_forward_ios),
//          isThreeLine: true,
      ),
    );
  }
}
