import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/utils/extensions.dart';

class CompareRepository{

  CompareRepository({ComparisonItemDao comparisonItemDao})
    : _comparisonItemDao = comparisonItemDao;
  final ComparisonItemDao _comparisonItemDao;

  Future<void> createComparisonItems(ComparisonItem comparisonItem) async{
    try{
      final comparisonItemRecord = comparisonItem.toRecord(comparisonItem);
      await _comparisonItemDao.addItem(comparisonItemRecord);
    }on SqliteException catch (e) {
      //ここでエラーを返さずにviewとviewModelのvalidationの条件に同じタイトルを弾くようにしてみる
      print('repositoryエラー:この問題はすでに登録${e.toString()}');
    }
  }
//  CompareRepository({})
}