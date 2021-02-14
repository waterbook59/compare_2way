import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/utils/extensions.dart';
import 'package:moor/ffi.dart';

class CompareRepository {
  CompareRepository({ComparisonItemDao comparisonItemDao})
      : _comparisonItemDao = comparisonItemDao;
  final ComparisonItemDao _comparisonItemDao;

  Future<void> createComparisonItems(ComparisonItem comparisonItem) async {
    try {
      final comparisonOverviewRecord =
          comparisonItem.toOverviewRecord(comparisonItem);
      final way1MeritDescs = comparisonItem.toWay1MeritRecord(comparisonItem);

      await _comparisonItemDao.addItem(
          comparisonOverviewRecord, way1MeritDescs);
    } on SqliteException catch (e) {
      //ここでエラーを返さずにviewとviewModelのvalidationの条件に同じタイトルを弾くようにしてみる
      print('repositoryエラー:この問題はすでに登録${e.toString()}');
    }
  }
//  CompareRepository({})
}
