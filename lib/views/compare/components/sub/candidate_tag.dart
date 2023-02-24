import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//tagDialogPageの下のタブ候補
class CandidateTag extends StatelessWidget {
  const CandidateTag({Key? key,
    required this.title,
//    this.tagAmount,
//    this.createdAt,
    required this.onTap,
//    this.selectTagIdList,
    required this.listNumber,
  }) : super(key: key);

   final String title;
//  final int tagAmount;
//  final String createdAt;
//  final VoidCallback onTapAddTag;
  final ValueChanged<String> onTap;
//  final List<String> selectTagIdList; //tagTitle編集時に更新するIDリスト
  final int listNumber;



  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        getTitle(context,listNumber);
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

  Future<void> getTitle(
      BuildContext context, int listNumber,) async {
    onTap(title);
    //選択タグへ追加したら表示から削除(tagAllTitleListから選択したもの削除)
  }
}
