import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//tagDialogPageの下のタブ候補
class ChoiceTag extends StatelessWidget {

  const ChoiceTag
      ({this.title,
    this.tagAmount,
    this.createdAt,
//    this.onDelete,
    this.onTap,
    this.selectTagIdList,
    this.listNumber,
//  this.myFocusNode,
  });

  final String title;
  final int tagAmount;
  final String createdAt;
//  final VoidCallback onDelete;
  final VoidCallback onTap;

//  final Function(FocusNode) onTap;
  final List<String> selectTagIdList; //tagTitle編集時に更新するIDリスト
  final int listNumber;

//  final FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return  ListTile(
      leading: Icon(CupertinoIcons.tag_solid,
        size: 24,color: primaryColor,),
      title: Text(title),//tagTitleの編集
      ///getTagTitleIdしつlistTileのonTapでfocusNode設定(tagEditModeで場合わけ)
      ///ListTileだけを再ビルドしても反映されない(notifyListenersしてListView含め再ビルド)
      onTap:(){
        getTitle(context,onTap,listNumber);
      },
      //          isThreeLine: true,
    );
  }

  Future<void> getTitle(BuildContext context,
      VoidCallback onTap, int listNumber) async{
    print('getTitle!:$title');
  }
}
