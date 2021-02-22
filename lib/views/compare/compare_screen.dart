import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:provider/provider.dart';
import 'components/table_part.dart';

class CompareScreen extends StatelessWidget {
  CompareScreen({this.comparisonItemId});

  final String comparisonItemId;

  static const IconData hand_thumbsup_fill = IconData(
      0xf6b8, fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  static const IconData hand_thumbsdown_fill = IconData(
      0xf6b6, fontFamily:  CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  //todo itemsはList<Merit>に変更
  static List<String> items = [
    'Content 1',
    'Content 2',
    'Content 3',
  ];

  //最初は１つだけ、データが既に入っている場合は取得時に入っている数を出したい
  //データが既に入っている場合は、初期表示として表す
  //List.generate(初期の表示数,(i)=>TextEditingController());
  final List<TextEditingController> _controllers =
      List.generate(items.length, (i) => TextEditingController(text: items[i]));

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    ///ページ冒頭かFutureBuilderどちらかでいい
//    Future(() {
//      viewModel.getOverview(comparisonItemId);
//        },
//      );

    return Scaffold(
      //todo trailing修正時はconst削除
      appBar:  CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      body: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
          ///メリットアイコン
              IconTitle(
                title:'メリット' ,
                iconData: Icons.thumb_up,
                iconColor: accentColor,
              ),

          ///way1 メリット
            FutureBuilder(
                    future: viewModel.getWaitOverview(comparisonItemId),
                    builder: (context,
                        AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container();
                      } else {
                              return GFAccordion(
                              title:
                                  viewModel.way1Title,
                              titleBorderRadius: accordionTopBorderRadius ,
                              contentBorderRadius: accordionBottomBorderRadius,
                              showAccordion: true,
                              collapsedTitleBackgroundColor:  Color(0xFFE0E0E0),
                              contentChild:ListView.builder(
                                    shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _controllers.length,
                                    itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());
                                      return CupertinoTextField(
                                        placeholder: 'メリットを入力してください',
                                        controller: _controllers[index],
                                    style: const TextStyle(color: Colors.black),
                                      );
                                    }),
                                );
                            }
                      }
                  ),
          ///way2 メリット
                    FutureBuilder(
                    future: viewModel.getWaitOverview(comparisonItemId),
                    builder: (context,
                        AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container();
                      } else {
                        return
                          GFAccordion(
                            title:
                              viewModel.way2Title,
                            titleBorderRadius: accordionTopBorderRadius ,
                            contentBorderRadius: accordionBottomBorderRadius,
                            collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                            showAccordion: true,
                            contentChild:ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _controllers.length,
                                itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());
                                return CupertinoTextField(
                                  placeholder: 'メリットを入力してください',
                                  controller: _controllers[index],
                                  style: const TextStyle(color: Colors.black),
                                      );
                                    }),
                                );
                      }
                    },
                  ),
              const SizedBox(height: 8,),
          ///デメリットアイコン
              IconTitle(
                title:'デメリット' ,
                iconData: Icons.thumb_down,
                iconColor: accentColor,
              ),
          ///way1 デメリット

                    FutureBuilder(
                    future: viewModel.getWaitOverview(comparisonItemId),
                    builder: (context,
                        AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container();
                      } else {
                      return
                        GFAccordion(
                            title: viewModel.way1Title,
                            titleBorderRadius: accordionTopBorderRadius ,
                            contentBorderRadius: accordionBottomBorderRadius,
                            collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                            showAccordion: true,
                            contentChild:ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _controllers.length,
                                itemBuilder: (context, index) {
      //              textItems.add(new TextEditingController());
                                  return CupertinoTextField(
                                    placeholder: 'メリットを入力してください',
                                    controller: _controllers[index],
                                    style: const TextStyle(color: Colors.black),
                              );
                            }),
                      );
                      }
                    },
                  ),
          ///way2 デメリット
//              Consumer<CompareViewModel>(
//                builder: (context, compareViewModel, child) {
//                  return
            FutureBuilder(
                    future: viewModel.getWaitOverview(comparisonItemId),
                    builder: (context,
                        AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container();
                      } else {
                        return GFAccordion(
                          title:
                          viewModel.way2Title,
                          collapsedTitleBackgroundColor: Color(0xFFE0E0E0),
                          titleBorderRadius: accordionTopBorderRadius ,
                          contentBorderRadius: accordionBottomBorderRadius,
                          showAccordion: true,
                          contentChild:ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _controllers.length,
                              itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());
                                return CupertinoTextField(
                                  placeholder: 'メリットを入力してください',
                                  controller: _controllers[index],
                                  style: const TextStyle(color: Colors.black),
                                );
                              }),
                        );
                      }
                    },
                  ),
          ///テーブル
                    FutureBuilder(
                    future: viewModel.getWaitOverview(comparisonItemId),
                        builder: (context,
                            AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                          if (snapshot.hasData && snapshot.data.isEmpty) {
                            print('EmptyView通った');
                            return Container();
                          } else {
                            return
                              TablePart(
                            way1Title: viewModel.way1Title,
                            way2Title: viewModel.way2Title,
                            way1MeritEvaluate: viewModel.way1MeritEvaluate,
                            way1DemeritEvaluate: viewModel.way1DemeritEvaluate,
                            way2MeritEvaluate: viewModel.way2MeritEvaluate,
                            way2DemeritEvaluate: viewModel.way2DemeritEvaluate,
                              );
                          }
                        }
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addList(context),
        ),
      ),
    );
  }

  void addList(BuildContext context) {
    //todo viewModelでメソッド実行してnotifyListener
    _controllers.add(TextEditingController());
  }
}
