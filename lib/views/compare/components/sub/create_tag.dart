import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//tagDialogPageの下のタブ候補
class CreateTag extends StatelessWidget {
  const CreateTag({Key? key,
    required this.title,
    required this.onTapAddTag,
  }) : super(key: key);

  final String title;
  final VoidCallback onTapAddTag;


  @override
  Widget build(BuildContext context) {
    final accentColor = Theme
        .of(context)
        .colorScheme.secondary;
    return GestureDetector(
      onTap:
      //タップ時_tempoDisplayListに追加
      onTapAddTag,
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 8,),
                Icon(CupertinoIcons.plus_circled, size: 24,
                  color: accentColor,),
                const SizedBox(width: 8,),
                Expanded(
                    child: Text(
                      'タグを追加"$title"',
                      style: TextStyle(fontSize: 16, color: accentColor),
                    ),),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 16,
              indent: 8,
            ),
          ],
        ),
      ),
    );
  }
}
