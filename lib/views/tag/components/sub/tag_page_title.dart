import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagPageTitle extends StatelessWidget {
  const TagPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CompareViewModel,TagEditMode>(
      selector: (context, viewModel) => viewModel.tagEditMode,
      builder:(context, tagEditMode, child){
        switch(tagEditMode){
          case TagEditMode.normal:
            return  const Text('タグリスト', style: middleJaTextStyle);
          case TagEditMode.tagTitleEdit:
            return  const Text('タグ名を編集', style: middleJaTextStyle);
          case TagEditMode.tagDelete:
            return const Text('タグを削除', style: middleJaTextStyle);
        }
        // return null;//null safety有効にするとエラー出ない
        ///https://zenn.dev/mono/articles/082dde5601ab4de858a1

      },
    );
  }
}
