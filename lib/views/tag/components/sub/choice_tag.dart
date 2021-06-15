import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//tagDialogPageの下のタブ候補
class ChoiceTag extends StatelessWidget {
  const ChoiceTag({
    this.title,
//    this.tagAmount,
//    this.createdAt,
    this.onTap,
//    this.selectTagIdList,
    this.listNumber,
  });

  final String title;
//  final int tagAmount;
//  final String createdAt;
  final VoidCallback onTap;
//  final List<String> selectTagIdList; //tagTitle編集時に更新するIDリスト
  final int listNumber;



  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        getTitle(context, onTap, listNumber);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  CupertinoIcons.tag_solid,
                  size: 24,
                  color: primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                )),
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

  Future<void> getTitle(
      BuildContext context, VoidCallback onTap, int listNumber) async {
    print('getTitle!:$title');
  }
}
