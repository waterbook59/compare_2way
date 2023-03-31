import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_tag_chart.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:compare_2way/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';

class CompareRepository {
  CompareRepository({required ComparisonItemDao comparisonItemDao})
      : _comparisonItemDao = comparisonItemDao;

  final ComparisonItemDao _comparisonItemDao;

  //コンストラクタ初期化でもlateでもOK //todo get＆set
  // List<ComparisonOverview> _overviewResults = <ComparisonOverview>[];
  late ComparisonOverview _overviewResult;
  late List<Way1Merit> _way1MeritList;

  List<Way2Merit> _way2MeritList = <Way2Merit>[];
  List<Way1Demerit> _way1DemeritList = <Way1Demerit>[];
  List<Way2Demerit> _way2DemeritList = <Way2Demerit>[];
  List<Tag> _tagList = <Tag>[];
  List<Tag> _selectTagList = <Tag>[];
  List<TagChart> _tagChartList = <TagChart>[];
  TagChart? _selectTagChart;

  set _overviewResults(List<ComparisonOverview> _overviewResults) {}

  ///新規作成 comparisonOverview
  Future<void> createComparisonOverview(
    ComparisonOverview newOverview,
  ) async {
    try {
      //comparisonOverview=>ComparisonOverviewRecordへ変換保存
      // final comparisonOverviewRecord =
      // newOverview.toComparisonOverviewRecord(newOverview);

      //新規作成時はcomparisonOverviewRecordへそのまま変換&insertではなく(dataIdがnullで変換できない)、
      // Companionを使ってinsert
      final newCompanion = newOverview.toOverviewNewRecordsCompanion(
        newOverview,
      );
      await _comparisonItemDao.insertComparisonOverviewDB(
          newCompanion: newCompanion,);
      debugPrint('comparisonOverviewを新規登録');
    } on SqliteException catch (e) {
      debugPrint('repositoryエラー:$e');
    }
  }

  ///タイトル更新 comparisonOverview
  Future<void> updateTitles(ComparisonOverview updateOverview) async {
    try {
      //更新プロパティ以外のdataIdとかは値入ってないのでnull
      final overviewCompanion =
          updateOverview.toCompanionUpdateTitles(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー:$e');
    }
  }

  Future<List<ComparisonOverview>> getOverview(String comparisonItemId) async {
    ///resultComparisonOverviewRecordsはList<ComparisonOverviewRecord>
    final resultComparisonOverviewRecords =
        await _comparisonItemDao.getOverview(comparisonItemId);

    ///comparisonOverviewRecords=>comparisonOverview
    return _overviewResults = resultComparisonOverviewRecords
        .toComparisonOverviews(resultComparisonOverviewRecords);
  }

  ///保存 comparisonOverview
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
    try {
      ///ComparisonOverview=>ComparisonOverviewRecord
      final overviewCompanion =
          updateOverview.toCompanionUpdateOverview(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
      debugPrint('comparisonOverviewRecord保存完了');
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  ///Read comparisonOverview
  Future<List<ComparisonOverview>> getOverviewList() async {
    final comparisonOverviewRecords = await _comparisonItemDao.allOverviews;
    return _overviewResults = comparisonOverviewRecords
        .toComparisonOverviews(comparisonOverviewRecords);
  }

  ///Delete ListPage単一行
  Future<void> deleteItem(String comparisonItemId) async {
    // Merit/Demeritも同時に削除必要(transaction)
//    await _comparisonItemDao.deleteListAll(comparisonItemId);
    await _comparisonItemDao.deleteItem(comparisonItemId);
    await _comparisonItemDao.deleteWay1MeritList(comparisonItemId);
    await _comparisonItemDao.deleteWay2MeritList(comparisonItemId);
    await _comparisonItemDao.deleteWay1DemeritList(comparisonItemId);
    await _comparisonItemDao.deleteWay2DemeritList(comparisonItemId);

    /// //todo way3List削除
//    await _comparisonItemDao.deleteWay3MeritList(comparisonItemId);
//    await _comparisonItemDao.deleteWay3DemeritList(comparisonItemId);
    await _comparisonItemDao.deleteAllTagList(comparisonItemId);
    debugPrint('データ削除完了');
  }

  ///Delete ListPage選択行
  /// //todo forEach修正
  void deleteItemList(List<String> deleteItemIdList) {
    deleteItemIdList.forEach((id) async {
      await _comparisonItemDao.deleteItem(id);
      await _comparisonItemDao.deleteWay1MeritList(id);
      await _comparisonItemDao.deleteWay2MeritList(id);
      await _comparisonItemDao.deleteWay1DemeritList(id);
      await _comparisonItemDao.deleteWay2DemeritList(id);

      /// //todo way3List削除
//    await _comparisonItemDao.deleteWay3MeritList(comparisonItemId);
//    await _comparisonItemDao.deleteWay3DemeritList(comparisonItemId);
      await _comparisonItemDao.deleteAllTagList(id);
      debugPrint('データ削除完了');
    });
  }

  ///List<ComparisonOverview>ではなく、comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<ComparisonOverview> getComparisonOverview(
    String comparisonItemId,
  ) async {
    final comparisonOverviewRecord =
        await _comparisonItemDao.getComparisonOverview(comparisonItemId);

    ///ComparisonOverviewRecord=>ComparisonOverview
    return _overviewResult =
        comparisonOverviewRecord.toComparisonOverview(comparisonOverviewRecord);
  }

  ///ComparisonItem=>ComparisonOverviewRecord,List<Way1Merit>に分解登録

  ///TablePart自動更新
  //way1Merit
  Future<void> updateWay1MeritEvaluate(
      ComparisonOverview updateOverview,) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateWay1MeritEvaluate(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  //way1Demerit
  Future<void> updateWay1DemeritEvaluate(
      ComparisonOverview updateOverview,) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateWay1DemeritEvaluate(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  //way2Merit
  Future<void> updateWay2MeritEvaluate(
      ComparisonOverview updateOverview,) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateWay2MeritEvaluate(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  //way2Demerit
  Future<void> updateWay2DemeritEvaluate(
      ComparisonOverview updateOverview,) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateWay2DemeritEvaluate(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  ///ConclusionPart自動更新
  Future<void> updateConclusion(ComparisonOverview updateOverview) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateConclusion(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  ///時間だけ更新
  Future<void> updateTime(ComparisonOverview updateOverview) async {
    try {
      final overviewCompanion =
          updateOverview.toCompanionUpdateTime(updateOverview);
      await _comparisonItemDao.saveComparisonOverviewDB(
        overviewCompanion: overviewCompanion,
        comparisonItemId: updateOverview.comparisonItemId,
      );
    } on SqliteException catch (e) {
      debugPrint('repository保存エラー:$e');
    }
  }

  /// //todo createComparisonOverviewと結合,way3List追加
  ///新規作成 way1MeritList,way2MeritList
  Future<void> createDescList(
    List<Way1Merit> way1MeritList,
    List<Way2Merit> way2MeritList,
    List<Way1Demerit> way1DemeritList,
    List<Way2Demerit> way2DemeritList,
  ) async {
    try {
      ///way1Merit 1行の場合
//      final way1MeritRecord = way1Merit.toWay1MeritRecord(way1Merit);
      ///List<way1Merit>の場合
      //way1MeritIdはautoIncrementなので、companion使う
      final way1MeritItemRecords =
          way1MeritList.toWay1InitMeritRecordList(way1MeritList);

      /// //todo companion使用
      final way2MeritItemRecords =
          way2MeritList.toWay2InitMeritRecordList(way2MeritList);
//      final way3MeritItemRecords =
//      way3MeritList.toWay3InitMeritRecordList(way3MeritList);
      final way1DemeritItemRecords =
          way1DemeritList.toWay1InitDemeritRecordList(way1DemeritList);
      final way2DemeritItemRecords =
          way2DemeritList.toWay2InitDemeritRecordList(way2DemeritList);
//      final way3DemeritItemRecords =
//      way3DemeritList.toWay3InitDemeritRecordList(way3DemeritList);

      await _comparisonItemDao.insertWay1MeritRecordDB(way1MeritItemRecords);
      await _comparisonItemDao.insertWay2MeritRecordDB(way2MeritItemRecords);
//    await _comparisonItemDao.insertWay3MeritRecordDB(way3MeritItemRecords);
      await _comparisonItemDao.insertWay1DemeritRecordDB(
        way1DemeritItemRecords,
      );
      await _comparisonItemDao.insertWay2DemeritRecordDB(
        way2DemeritItemRecords,
      );
//    await _comparisonItemDao.insertWay3DemeritRecordDB(
//          way3DemeritItemRecords);

      debugPrint('List<Way1Merit>を新規登録');
    } on SqliteException catch (e) {
      debugPrint('repositoryエラー:$e');
    }
  }

  ///Read List<Way1Merit>
  Future<List<Way1Merit>> getWay1MeritList(String comparisonItemId) async {
    //comparisonItemIdを元に得られたList<Way1MeritRecord>をList<Way1Merit>へ変換する
    final way1MeritRecordList =
        await _comparisonItemDao.getWay1MeritList(comparisonItemId);
    return _way1MeritList =
        way1MeritRecordList.toWay1MeritList(way1MeritRecordList);
  }

  ///Read List<Way2Merit>
  Future<List<Way2Merit>> getWay2MeritList(String comparisonItemId) async {
    final way2MeritRecordList =
        await _comparisonItemDao.getWay2MeritList(comparisonItemId);
    return _way2MeritList =
        way2MeritRecordList.toWay2MeritList(way2MeritRecordList);
  }

  ///Read List<Way3Merit>
//  Future<List<Way3Merit>> getWay3MeritList(String comparisonItemId) async {
//    final way3MeritRecordList =
//    await _comparisonItemDao.getWay3MeritList(comparisonItemId);
//    return _way3MeritList =
//        way3MeritRecordList.toWay3MeritList(way3MeritRecordList);
//  }
  ///Read List<Way1DeMerit>
  Future<List<Way1Demerit>> getWay1DemeritList(String comparisonItemId) async {
    final way1DemeritRecordList =
        await _comparisonItemDao.getWay1DemeritList(comparisonItemId);
    return _way1DemeritList =
        way1DemeritRecordList.toWay1DemeritList(way1DemeritRecordList);
  }

  ///Read List<Way2DeMerit>
  Future<List<Way2Demerit>> getWay2DemeritList(String comparisonItemId) async {
    final way2DemeritRecordList =
        await _comparisonItemDao.getWay2DemeritList(comparisonItemId);
    return _way2DemeritList =
        way2DemeritRecordList.toWay2DemeritList(way2DemeritRecordList);
  }

  ///Read List<Way3DeMerit>
//  Future<List<Way3Demerit>> getWay3DemeritList(String comparisonItemId) async
//  {
//    final way3DemeritRecordList =
//    await _comparisonItemDao.getWay3DemeritList(comparisonItemId);
//    return _way3DemeritList =
//        way1DemeritRecordList.toWay1DemeritList(way3DemeritRecordList);
//  }

  ///保存 変更したWay1Merit=>変更したWay1Meritだけ更新
  //変更前：List<Way1Merit>=>変更したWay1Meritだけ更新
  Future<void> setWay1MeritDesc(Way1Merit updateWay1Merit, int index) async {
    try {
      ///List<way1Merit>=>List<Way1MeritRecord>の場合
//      final way1MeritItemRecords = way1MeritList.toWay1MeritRecordList(
//          way1MeritList);
      ///Way1Merit=>Way1MeritRecordの場合
      final way1MeritRecord =
          updateWay1Merit.toUpdateWay1MeritRecord(updateWay1Merit);
      await _comparisonItemDao.updateWay1MeritRecordDB(
//          way1MeritItemRecords[index]);
        way1MeritRecord,
      );
    } on SqliteException catch (e) {
      debugPrint('repositoryエラー:$e');
    }
  }

  ///保存 Way2Merit一部変更=>変更行だけ更新
  Future<void> setWay2MeritDesc(Way2Merit updateWay2Merit, int index) async {
    try {
      final way2MeritRecord =
          updateWay2Merit.toUpdateWay2MeritRecord(updateWay2Merit);
      await _comparisonItemDao.updateWay2MeritRecordDB(
        way2MeritRecord,
      );
    } on SqliteException catch (e) {
      debugPrint('repository/setWay2MeritDescエラー:$e');
    }
  }

  ///保存 Way3Merit一部変更=>変更行だけ更新
//  Future<void> setWay3MeritDesc(Way3Merit updateWay3Merit, int index) async{
//    try{
//      final way3MeritRecord =
//      updateWay3Merit.toUpdateWay3MeritRecord(updateWay3Merit);
//      await _comparisonItemDao.updateWay3MeritRecordDB(
//          way3MeritRecord);
//    }on SqliteException catch (e) {
//      print('repository/setWay2MeritDescエラー:${e.toString()}');
//    }
//  }
  ///保存 Way1Demerit一部変更=>変更行だけ更新
  Future<void> setWay1DemeritDesc(
      Way1Demerit updateWay1Demerit, int index,) async {
    try {
      final way1DemeritRecord =
          updateWay1Demerit.toUpdateWay1DemeritRecord(updateWay1Demerit);
      await _comparisonItemDao.updateWay1DemeritRecordDB(
        way1DemeritRecord,
      );
    } on SqliteException catch (e) {
      debugPrint('repositoryエラー:$e');
    }
  }

  ///保存 Way2Demerit一部変更=>変更行だけ更新
  Future<void> setWay2DemeritDesc(
      Way2Demerit updateWay2Demerit, int index,) async {
    try {
      final way2DemeritRecord =
          updateWay2Demerit.toUpdateWay2DemeritRecord(updateWay2Demerit);
      await _comparisonItemDao.updateWay2DemeritRecordDB(
        way2DemeritRecord,
      );
    } on SqliteException catch (e) {
      debugPrint('repositoryエラー:$e');
    }
  }

  ///保存 Way3Demerit一部変更=>変更行だけ更新
//  Future<void> setWay3DemeritDesc(Way3Demerit updateWay3Demerit, int index)
//  async {
//    try {
//      final way3DemeritRecord =
//      updateWay3Demerit.toUpdateWay3DemeritRecord(updateWay3Demerit);
//      await _comparisonItemDao.updateWay3DemeritRecordDB(
//          way3DemeritRecord);
//    } on SqliteException catch (e) {
//      print('repositoryエラー:${e.toString()}');
//    }
//  }

  ///リスト１行追加：Way1Merit
  Future<void> addWay1Merit(Way1Merit initWay1Merit) async {
    //1行だけ差し込めるか
    try {
      final way1MeritCompanion =
          initWay1Merit.toWay1MeritNewCompanion(initWay1Merit);
      await _comparisonItemDao.insertWay1MeritRecordSingle(way1MeritCompanion);
      debugPrint('repository:リスト１行新規追加');
    } on SqliteException catch (e) {
      debugPrint('Way1Merit追加エラー:$e');
    }
  }

  ///リスト１行追加：Way2Merit
  Future<void> addWay2Merit(Way2Merit initWay2Merit) async {
    try {
      final way2MeritCompanion =
          initWay2Merit.toWay2MeritNewCompanion(initWay2Merit);
      await _comparisonItemDao.insertWay2MeritRecordSingle(way2MeritCompanion);
      debugPrint('repository:リストWay2Merit１行新規追加');
    } on SqliteException catch (e) {
      debugPrint('Way2Merit追加エラー:$e');
    }
  }

  ///リスト１行追加：Way3Merit
//  Future<void> addWay3Merit(Way3Merit initWay3Merit) async {
//    try {
//      final way3MeritRecord =
//      initWay3Merit.toCreateWay3MeritRecord(initWay3Merit);
//      await _comparisonItemDao.insertWay3MeritRecordSingle(way3MeritRecord);
//      print('repository:リストWay2Merit１行新規追加');
//    } on SqliteException catch (e) {
//      print('Way3Merit追加エラー:${e.toString()}');
//    }
//  }
  ///リスト１行追加：Way1Demerit
  Future<void> addWay1Demerit(Way1Demerit initWay1Demerit) async {
    //1行だけ差し込めるか
    try {
      final way1DemeritCompanion =
          initWay1Demerit.toWay1DemeritNewCompanion(initWay1Demerit);
      await _comparisonItemDao.insertWay1DemeritRecordSingle(
        way1DemeritCompanion,
      );
      debugPrint('repository:リスト１行新規追加');
    } on SqliteException catch (e) {
      debugPrint('Way1Demerit追加エラー:$e');
    }
  }

  ///リスト１行追加：Way2Demerit
  Future<void> addWay2Demerit(Way2Demerit initWay2Demerit) async {
    //1行だけ差し込めるか
    try {
      final way2DemeritCompanion =
          initWay2Demerit.toWay2DeMeritNewCompanion(initWay2Demerit);
      await _comparisonItemDao.insertWay2DemeritRecordSingle(
        way2DemeritCompanion,
      );
      debugPrint('repository:リスト１行新規追加');
    } on SqliteException catch (e) {
      debugPrint('Way3Demerit追加エラー:$e');
    }
  }

  ///リスト１行追加：Way3Demerit
//  Future<void> addWay3Demerit(Way3Demerit initWay3Demerit) async {
//    //1行だけ差し込めるか
//    try {
//      final way3DemeritRecord =
//      initWay3Demerit.toCreateWay3DemeritRecord(initWay3Demerit);
//      await _comparisonItemDao.insertWay3DemeritRecordSingle
//      (way3DemeritRecord);
//      print('repository:リスト１行新規追加');
//    } on SqliteException catch (e) {
//      print('Way3Demerit追加エラー:${e.toString()}');
//    }
//  }

  /// //todo way1~3追加

  ///リスト1行削除:Way1Merit
  Future<void> deleteWay1Merit(int way1MeritId) async {
    await _comparisonItemDao.deleteWay1Merit(way1MeritId);
  }

  ///リスト1行削除:Way2Merit
  Future<void> deleteWay2Merit(int way2MeritId) async {
    await _comparisonItemDao.deleteWay2Merit(way2MeritId);
  }

  ///リスト1行削除:Way3Merit
//  Future<void> deleteWay3Merit(int way3MeritId) async {
//    await _comparisonItemDao.deleteWay3Merit(way3MeritId);
//  }
  ///リスト1行削除:Way1Demerit
  Future<void> deleteWay1Demerit(int way1DemeritId) async {
    await _comparisonItemDao.deleteWay1Demerit(way1DemeritId);
  }

  ///リスト1行削除:Way2Merit
  Future<void> deleteWay2Demerit(int way2DemeritId) async {
    await _comparisonItemDao.deleteWay2Demerit(way2DemeritId);
  }

  ///リスト1行削除:Way3Demerit
//  Future<void> deleteWay3Demerit(int way3MeritId) async {
//    await _comparisonItemDao.deleteWay3Demerit(way3DemeritId);
//  }

  ///新規作成 List<Tag>
  // repo側でupdateOverview作成してDatetime更新(deleteTagメソッドでも同じ)
  ///同一comparisonItemId & 同一tagTitleは登録しないが、同一tagTitleは登録できるように変更
  Future<void> createTag(
    List<String> extractionDisplayTag,
    String comparisonItemId,
  ) async {
    try {
//      ///既に登録されているTagListをgetし、Setへ変換
//      final dbTagList = await _comparisonItemDao.getTagList(comparisonItemId);
//      final dbTitleSet = dbTagList.map((dbTag)=>dbTag.tagTitle).toSet();
//      print('dbTitleSet:$dbTitleSet');
//
//      //tagNameListをSetへ変換し、DB登録しているタグを削除
//      ///2つのリストから重複削除removeAllはSetでしか使えない
//      final tempoDisplaySet = tempoDisplayList.toSet()
//      ..removeAll(dbTitleSet);
//      print('extractionSet:$tempoDisplaySet');
      //DBと重複のない抽出したtagNameSetをList<Tag>へ変換
      ///extractionSet(tagNameSet)=>List<Tag>に変換して登録
      debugPrint('repo/createTag/extractionDisplayTag:$extractionDisplayTag');
      final tagList = extractionDisplayTag.map((name) {
        return Tag(
          comparisonItemId: comparisonItemId,
          tagTitle: name,
          createdAt: DateTime.now(),
          createAtToString: DateTime.now().toIso8601String(),
        );
      }).toList();

      //最終的に登録するList<Tag>ができたらList<TagRecord>へ変換する(tagIdはここで付与)
      final tagRecordList = tagList.toTagRecordList(tagList);

      //2つのリストを比較しようとしてforEach内でforEachしようとしたけど、動かない
      ///(別のリストのタグにも使うのでtagTitleの重複登録は必要)
      //primaryKeyで弾かれるものも含めての登録は、insertよりも
      // insertOnConflictUpdateが良い(毎回UNIQUE constraint failedエラー発生するので)
      await _comparisonItemDao.insertTagRecordList(tagRecordList);

      ///tag新規登録したら時間更新(tagListに新規追加がある場合)
      if (tagList.isNotEmpty) {
        final updateOverview = ComparisonOverview(
          comparisonItemId: comparisonItemId,
          createdAt: DateTime.now(),
        );
        await updateTime(updateOverview);
      }
      debugPrint('repository:tagListを新規登録');
    } on SqliteException catch (e) {
      debugPrint('tagList登録時repositoryエラー:$e');
    }
  }

  ///Read List<Tag>
  Future<List<Tag>> getTagList(String comparisonItemId) async {
    //comparisonItemIdを元に得られたList<TagRecord>をList<Tag>へ変換する
    final tagRecordList = await _comparisonItemDao.getTagList(comparisonItemId);
    debugPrint(
        'repo/getTagList/tagRecordList${tagRecordList.map((e) => e.tagTitle)}',);
    return _tagList = tagRecordList.toTagList(tagRecordList);
  }

  ///Delete List<Tag>
  Future<void> deleteTag(List<Tag> deleteTagList) async {
    try {
      //List<Tag>=>List<TagRecord>へ変換保存
      final deleteTagRecordList = deleteTagList.toTagRecordList(deleteTagList);
      await _comparisonItemDao.deleteTagList(deleteTagRecordList);
    } on SqliteException catch (e) {
      debugPrint('tagList削除時repositoryエラー:$e');
    }
  }

  ///Read List<Tag>
  Future<List<Tag>> getAllTagList() async {
    final tagRecordList = await _comparisonItemDao.getAllTagList();
    return _tagList = tagRecordList.toTagList(tagRecordList);
  }

  Future<List<Tag>> onSelectTag(String tagTitle) async {
    final selectTagRecordList = await _comparisonItemDao.onSelectTag(tagTitle);
//        print('repo/onSelectTag/selectTagRecordList:$selectTagRecordList');
    //List<TagRecord>=>List<Tag>
    return _selectTagList = selectTagRecordList.toTagList(selectTagRecordList);
  }

  ///新規作成 List<TagChart>
  Future<void> createTagChart(List<TagChart> tagChartList) async {
    try {
      //List<TagChart>=>List<TagChartDB>
      final tagChartRecordList =
          tagChartList.toTagChartRecordsCompanion(tagChartList);
      await _comparisonItemDao.createTagChart(tagChartRecordList);
      debugPrint('repository/createTagChartも作成');
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー/createTagChart:$e');
    }
  }

  ///Read List<TagChart>
  Future<List<TagChart>> getAllTagChartList() async {
    final tagChartRecordList = await _comparisonItemDao.getAllTagChartList();
    return _tagChartList =
        tagChartRecordList.toTagChartList(tagChartRecordList);
  }

  ///Update List<TagChart>=>TagChartRecordsCompanion
  Future<void> updateTagChart(List<TagChart> tagChartList) async {
    ///daoに直接tagChartList渡すのは好ましくない
    ///tagChartRecordへの変換=>data.idエラー=>titleリスト作成しdaoへ渡す
    final tagTitleList =
        tagChartList.map((tagChart) => tagChart.tagTitle).toList();
    try {
      //TagChartRecordsCompanionのリストで数量更新
      tagChartList.map((tagChart) {
        final updateCompanion = tagChart.toUpdateAmountTagCompanion(tagChart);

        //tagTitleList:DBからtitleで検索、updateCompanion:DBの数量更新
        _comparisonItemDao.updateTagChart(
          tagTitleList,
          updateCompanion,
        );
      }).toList();
      debugPrint('repository/updateTagChart:更新完了');
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー/updateTagChart:$e');
    }
  }

  ///Update List<TagChart>=>TagChartRecordsCompanion
  Future<void> updateTagChartTitle(
      TagChart tagChart, String newTagTitle,) async {
    //TagChart=>TaChartRecord
    final tagChartRecord = tagChart.toTagChartRecord(tagChart);
    try {
      //TagChartRecordsCompanionのリストで数量更新
//      tagChartRecordList.map((tagChartRecord){
      final updateTagRecordCompanion = TagChartRecordsCompanion(
        tagTitle: Value(newTagTitle),
      );
      await _comparisonItemDao.updateTagChartTitle(
        tagChartRecord,
        updateTagRecordCompanion,
      );
//      }).toList();
      debugPrint('repository/updateTagChart:更新完了');
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー/updateTagChart:$e');
    }
  }

  ///Read List<TagChart>のtitleのみ(vieModel側で書くと行数多くなるので)
  Future<List<String>> getTagChartDBTitle() async {
    final tagChartRecordList = await _comparisonItemDao.getAllTagChartList();
    final tagChartDBTitle =
        tagChartRecordList.map((tagChart) => tagChart.tagTitle).toList();
    return tagChartDBTitle;
  }

  ///Read List<TagChart>編集用にtitle検索からtagChartList読み込み
  Future<TagChart> getSingleTagChart(String title) async {
//    final tagChartRecordList = <TagChartRecord>[];
    final tagChartRecord = await _comparisonItemDao.getTagChart(title);
//      tagChartRecordList.add(tagChartRecord);

//    print('repo/getTagChartList:${tagChartRecordList.map((e) => e.tagTitle)}');
    return _selectTagChart = tagChartRecord.toTagChart(tagChartRecord);
  }

  ///Read List<TagChart>削除更新用にtitle検索からtagChartList読み込み
  Future<List<TagChart>> getTagChartList(List<String> titleList) async {
    final tagChartRecordList = <TagChartRecord>[];
    /// //todo 1行ずつ読み取る
    await Future.forEach(titleList, (String title) async {
      final tagChartRecord = await _comparisonItemDao.getTagChart(title);
      tagChartRecordList.add(tagChartRecord);
    });
    debugPrint('repo/getTagChartList:${tagChartRecordList.map((e) => e.tagTitle)}');
    return _tagChartList =
        tagChartRecordList.toTagChartList(tagChartRecordList);
  }

  ///Delete List<TagChart>タイトルから削除
  Future<void> removeTagChart(List<TagChart> removeTagChartList) async {
    final tagTitleList = removeTagChartList
        .map(
          (tagChart) => tagChart.tagTitle,
        )
        .toList();
    try {
      //List<TagChart>=>List<TagChartRecord>へ変換保存
      // final removeTagChartRecordList =
      // removeTagChartList.toTagChartRecordsCompanion(removeTagChartList);
      await _comparisonItemDao.removeTagChart(tagTitleList);
    } on SqliteException catch (e) {
      debugPrint('tagChartList削除時repositoryエラー:$e');
    }
  }

  ///更新 Tag List<Tag>=>TagRecordsCompanion
  Future<void> updateTagTitle(
    List<Tag> selectTagList,
    String newTagTitle,
  ) async {
    //List<Tag>=>List<TagRecord>
    final selectTagRecordList =
        selectTagList.toUpdateTagRecordList(selectTagList);

    try {
      final updateTagRecordCompanion = TagRecordsCompanion(
        tagTitle: Value(newTagTitle),
      );
      //saveComparisonOverviewDB参考 idとcompanion渡し
      await _comparisonItemDao.updateTagTitle(
        selectTagRecordList,
        updateTagRecordCompanion,
      );
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー:$e');
    }
  }

  ///削除 Tag
  Future<void> onDeleteTag(Tag deleteTag) async {
    try {
      //List<Tag>=>List<TagRecord>へ変換保存
      final deleteTagRecord = deleteTag.toTagRecord(deleteTag);
      await _comparisonItemDao.onDeleteTag(deleteTagRecord);
    } on SqliteException catch (e) {
      debugPrint('tagList削除時repositoryエラー:$e');
    }
  }

  /// ListPage編集並び替え後のDBの順番入れ替え、dataIdで行う
  //順番入れ替えは全削除・全登録の方法に変更
  Future<void> changeCompareListOrder(
    List<ComparisonOverview> newCompareItemList,
  ) async {
    //comparisonOverviewsのdataIdとdaragginItemsのorderIdが同じものをComparisonOverviewに
    try {
      final newOrderOverviews = <ComparisonOverview>[];
      //draggingItemsをrepositoryにそのまま渡してcomparisonItemId順にdataIdを更新する
      for (var i = 0; i < newCompareItemList.length; ++i) {
        newOrderOverviews.add(
          ComparisonOverview(
            dataId: i,
            //ここだけdraggingItemから
            comparisonItemId: newCompareItemList[i].comparisonItemId,
            itemTitle: newCompareItemList[i].itemTitle,
            way1Title: newCompareItemList[i].way1Title,
            way1MeritEvaluate: newCompareItemList[i].way1MeritEvaluate,
            way1DemeritEvaluate: newCompareItemList[i].way1DemeritEvaluate,
            way2Title: newCompareItemList[i].way2Title,
            way2MeritEvaluate: newCompareItemList[i].way2MeritEvaluate,
            way2DemeritEvaluate: newCompareItemList[i].way1DemeritEvaluate,
            /// //todo favorite,way3追加
//          way3Title: newCompareItemList[i].way3Title,
//          way3MeritEvaluate: newCompareItemList[i].way3MeritEvaluate,
//          way3DemeritEvaluate: newCompareItemList[i].way3DemeritEvaluate,
            createdAt: newCompareItemList[i].createdAt,
            conclusion: newCompareItemList[i].conclusion,
          ),
        );

        final itemRecordList =
            newOrderOverviews.toComparisonOverviewRecords(newOrderOverviews);
        //並び替えだけなので、comparisonOverviewRecordsの削除だけで良い
        await _comparisonItemDao.allDeleteItemtList();
        await _comparisonItemDao.allCreateItemList(itemRecordList);
      }
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー:$e');
    }
  }

  /// TagPage編集並び替え後のDBの順番入れ替え
  Future<void> changeTagListOrder(List<DraggingTagChart> draggingTags) async {
    try {
      //タイトル順にorderIdわりあて
      final newOrderTags = <DraggingTagChart>[];
      for (var i = 0; i < draggingTags.length; ++i) {
        final draggingTag = draggingTags[i];
        newOrderTags.add(
          DraggingTagChart(
            tagTitle: draggingTag.tagTitle,
            key: ValueKey(i),
            tagAmount: draggingTag.tagAmount,
            orderId: i,
          ),
        );
      }
      //idのみの更新はやめて、draggingTagsとしてList全てを削除=>再登録する
      //draggingTags=>TagChartRecordList
      final tagChartRecordList =
          draggingTags.dragToTagChartRecordList(newOrderTags);
      await _comparisonItemDao.allDeleteTagChartList();
      await _comparisonItemDao.allCreateTagChartList(tagChartRecordList);
    } on SqliteException catch (e) {
      debugPrint('repository更新エラー:$e');
    }
  }

  /// TagPage選択行削除 //todo deleteItemList,deleteTag参照
  Future<void> deleteSelectTagList(List<Tag> deleteTagList) async {
    try {
      //List<Tag>=>List<TagRecord>へ変換保存
      final deleteTagRecordList = deleteTagList.toTagRecordList(deleteTagList);
      await _comparisonItemDao.deleteSelectTagList(deleteTagRecordList);
    } on SqliteException catch (e) {
      debugPrint('tagList削除時repositoryエラー:$e');
    }
  }

  Future<List<ComparisonOverview>> getNewOrderList(
    List<String> deleteItemIdList,
  ) async {
    final itemRecordList = <ComparisonOverviewRecord>[];

    await Future.forEach(deleteItemIdList, (String id) async {
      final itemRecord = await _comparisonItemDao.getOverviewRecord(id);
      itemRecordList.add(itemRecord);
    });
    debugPrint('repo/getNewOrderList:${itemRecordList.map((e) => e.itemTitle)}');
    return _overviewResults =
        itemRecordList.toComparisonOverviews(itemRecordList);
  }
}
