import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///変更した値を上を渡すのではなく、ここでDB更新までもっていく
class EditTagTitle extends StatefulWidget {
  const EditTagTitle({Key? key,
    required this.tagTitle,
    // required this.selectTagIdList,
    required this.myFocusNode,
  }) : super(key: key);

  final String tagTitle;
  // final List<String> selectTagIdList;//tagTitle編集時に更新するIDリスト
  final FocusNode myFocusNode;

  @override
  State<EditTagTitle> createState() => _EditTagTitleState();
}

class _EditTagTitleState extends State<EditTagTitle> {
  final _tagTitleController = TextEditingController();

  @override
  void initState() {

    ///controllerとviewModelをaddListerで結びつける
    _tagTitleController
      ..addListener(_onInputChanged)
      ..text = widget.tagTitle;
    super.initState();
  }

  @override
  void dispose() {
    _tagTitleController.dispose();
//    print('tagTitleController dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      //背景をtransparent
      decoration: const BoxDecoration(color: Colors.transparent),
      controller: _tagTitleController,
      focusNode: widget.myFocusNode,
    ///変更したらtagTitle更新
      onChanged: (newTagTitle)=>updateTagTile(context,newTagTitle),
      maxLines: null,
    );
  }

  void _onInputChanged() {
    Provider.of<CompareViewModel>(context, listen: false)
      .tagTitle = _tagTitleController.text;

  }

  Future<void> updateTagTile(
      BuildContext context,String newTagTitle
      ,) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //viewModelに既に値格納されているので、newTagTitleは渡さなくて良い
    await  viewModel.updateTagTitle(newTagTitle);
  }
}
