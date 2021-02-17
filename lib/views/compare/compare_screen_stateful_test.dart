import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class CompareScreenStatefulTest extends StatefulWidget {
  @override
  _CompareScreenStatefulTestState createState() =>
      _CompareScreenStatefulTestState();
}

class _CompareScreenStatefulTestState extends State<CompareScreenStatefulTest> {
  //初期表示は出しながら、ボタンおしたらリストの中身をどんどん追加していけるか
  //テキストフィールドをリスト形式で表す
  //初期表示のデータをTextEditingControllerとして出せるか
  // 適当なリスト用データ
  List<String> items = [
    'Content 1',
    'Content 2',
    'Content 3',
  ];

  //最初は１つだけ出したい
  List<TextEditingController> _controllers =
      List.generate(1, (i) => TextEditingController());

//  List<TextEditingController> textItems = [
//    TextEditingController(),
////    'Content 1',
////    'Content 2',
////    'Content 3',
//  ];

//  List<TextEditingController> textFieldControllers = <TextEditingController>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

    return CupertinoPageScaffold(
      //todo trailing修正時はconst削除
      navigationBar: const CupertinoNavigationBar(
        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: ListView.builder(
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());

              return CupertinoTextField(
                placeholder: 'メリットを入力してください',
                controller: _controllers[index],
                style: TextStyle(color: Colors.black),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addListItem(context),
        ),
      ),
    );
  }

  void addListItem(BuildContext context) {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }
}
