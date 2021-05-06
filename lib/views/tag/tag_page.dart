import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/tag_view_model.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:compare_2way/views/tag/components/sub/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'components/tag_list.dart';

///List<Tag>で一覧のデータ取得しつつ、tagTitleで重複するものを削除するのにtoSet()を使う
///削除したlistをタグ一覧として表示する（tagChips参照）

class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;
//    final viewModel = Provider.of<TagViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          'タグ',
          style: middleTextStyle,
        ),
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Consumer<TagViewModel>(
          builder: (context, tagViewModel, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTitle(
                    title: 'タグ',
                  ),
                  FutureBuilder(
                    future: tagViewModel.getAllTagList(),
                    builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
                      if (snapshot.data == null) {
                        print('AsyncSnapshot<List<Tag>> snapshotがnull');
                        return Container();
                      }
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView側通って描画');
                        return Container(
                            child:
                                const Center(child: Text('タグづけされたリストはありません')));
                      } else {
                        return ListView.builder(
                          //ListView.builderの高さを自動指定
                          shrinkWrap: true,
                          //リストが縦方向にスクロールできるようになる
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final overview = snapshot.data[index];
                            //DateTime=>String変換
                            return TagList(
                              title: overview.tagTitle,
                              conclusion: overview.comparisonItemId,
                              createdAt: '登録時間',
                              onDelete: (){},
                              onTap: (){},
                              listDecoration: listDecoration,
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            backgroundColor: accentColor,
            child: const Icon(Icons.add, color: Colors.black, size: 40),
            onPressed: () => print('押したぜFAB'),
          ),
        ),
      ),
    );
  }
}
