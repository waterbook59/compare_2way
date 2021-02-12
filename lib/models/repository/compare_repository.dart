import 'package:compare_2way/data_models/comparison_item.dart';

class CompareRepository{


  Future<void> createComparisonItems(ComparisonItem comparisonItem) async{
    try{
      final comparisonItemRecord = comparisonItem.toRecord(comparisonItem);
      await _dao.addItem();
    }on SqliteException catch (e) {
      //ここでエラーを返さずにviewとviewModelのvalidationの条件に同じタイトルを弾くようにしてみる
      print('repositoryエラー:この問題はすでに登録${e.toString()}');
    }
  }
//  CompareRepository({})
}