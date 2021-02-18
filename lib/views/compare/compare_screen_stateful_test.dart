import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class CompareScreenStatefulTest extends StatefulWidget {
  CompareScreenStatefulTest({this.comparisonItemId});
  final String comparisonItemId;



  @override
  _CompareScreenStatefulTestState createState() =>
      _CompareScreenStatefulTestState();
}

class _CompareScreenStatefulTestState extends State<CompareScreenStatefulTest> {
  ComparisonItemDB comparisonItemDB = ComparisonItemDB();
  ComparisonItemDao comparisonItemDao = ComparisonItemDao(
      ComparisonItemDB()
  );
  List<ComparisonOverviewRecord> comparisonOverviewRecord =
  <ComparisonOverviewRecord>[];
  String way1Title = 'way1のタイトル';
  String way2Title = 'way2のタイトル';

  //初期表示は出しながら、ボタンおしたらリストの中身をどんどん追加してく
  //テキストフィールドをリスト形式で表す
  //初期表示のデータをTextEditingControllerとして出す
  // 適当なリスト用データ
  //ここをList<Way1Merit>とかにすれば良い
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
  void initState() {
    _getWayTitle(widget.comparisonItemId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme
        .of(context)
        .primaryContrastingColor;

    return CupertinoPageScaffold(
      //todo trailing修正時はconst削除
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height:8 ,),
                const Text('メリット'),
            const SizedBox(height:8 ,),
                Text(way1Title,style: TextStyle(color: Colors.black),),
            const SizedBox(height:8 ,),
            Text(way2Title,style: TextStyle(color: Colors.black),),
                ListView.builder(
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
//              textItems.add(new TextEditingController());

                  return CupertinoTextField(
                    placeholder: 'メリットを入力してください',
                    controller: _controllers[index],
                    style: const TextStyle(color: Colors.black),
                  );
                }),
              ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: accentColor,
          child: const Icon(Icons.add, color: Colors.black, size: 40),
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

  Future<void> _getWayTitle(String comparisonItemId) async{
    //comparisonItemIdをキーにしてComparisonOverviewRecordからway1Title,way2Titleとってくる
    //todo リストからway1タイトルのみ取り出し
     comparisonOverviewRecord = comparisonItemDao.getOverview(comparisonItemId)
    as List<ComparisonOverviewRecord>;
    way1Title = comparisonOverviewRecord[0].way1Title;
    way2Title = comparisonOverviewRecord[0].way2Title;
    print(way1Title);
//    setState(() {});
  }
}
