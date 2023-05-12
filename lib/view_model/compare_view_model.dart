import 'dart:async';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/data_models/dragging_tag_chart.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CompareViewModel extends ChangeNotifier {
  CompareViewModel({
    required CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;
  List<ComparisonOverview> _comparisonOverviews = <ComparisonOverview>[];

  List<ComparisonOverview> get comparisonOverviews => _comparisonOverviews;

  //ListPage編集並び替え後のリスト
  List<ComparisonOverview> newComparisonOverviews = <ComparisonOverview>[];
  late CompareScreenStatus compareScreenStatus;
  late ComparisonOverview overviewDB;
  List<Way1Merit> _way1MeritList = <Way1Merit>[];
  List<Way1Merit> get way1MeritList => _way1MeritList;
  List<Way2Merit> _way2MeritList = <Way2Merit>[];
  List<Way2Merit> get way2MeritList => _way2MeritList;
  List<Way1Demerit> _way1DemeritList = <Way1Demerit>[];
  List<Way1Demerit> get way1DemeritList => _way1DemeritList;
  List<Way2Demerit> _way2DemeritList = <Way2Demerit>[];
  List<Way2Demerit> get way2DemeritList => _way2DemeritList;

//textFieldからviewModelへの変更値登録があるのでカプセル化しない
  String itemTitle = '';
  String way1Title = '';
  String way2Title = '';
  final _titleController = TextEditingController();

  TextEditingController get titleController => _titleController;
  final _way1Controller = TextEditingController();

  TextEditingController get way1Controller => _way1Controller;
  final _way2Controller = TextEditingController();

  TextEditingController get way2Controller => _way2Controller;

  int _way1MeritEvaluate = 0;

  int get way1MeritEvaluate => _way1MeritEvaluate;
  int _way1DemeritEvaluate = 0;

  int get way1DemeritEvaluate => _way1DemeritEvaluate;
  int _way2MeritEvaluate = 0;

  int get way2MeritEvaluate => _way2MeritEvaluate;
  int _way2DemeritEvaluate = 0;

  int get way2DemeritEvaluate => _way2DemeritEvaluate;
  int _way3MeritEvaluate = 0;

  int get way3MeritEvaluate => _way3MeritEvaluate;
  int _way3DemeritEvaluate = 0;

  int get way3DemeritEvaluate => _way3DemeritEvaluate;

  //いらんかも
  final TextEditingController _conclusionController = TextEditingController();

  TextEditingController get conclusionController => _conclusionController;
  String conclusion = '';

  //textFieldからviewModelへの変更値登録があるのでカプセル化しない
  String tagTitle = '';
  String addTagTitle='';

  ///CompareScreenで使用
  //tagDialogPageの下で先に登録のあるタグの候補表示する
  List<String> candidateTagNameList = <String>[];

//  List<String> get candidateTagNameList =>_candidateTagNameList;
  List<Tag> _tagList = <Tag>[]; //CompareScreenでのIDに紐づく選択済リスト
  List<Tag> get tagList => _tagList;
  List<String> _tagNameList = <String>[]; //TagDialogPageでのIDに紐づくDBへの登録用リスト
  List<String> get tagNameList => _tagNameList;
  List<String> _tempoDisplayList = <String>[]; //TagDialogPageでのDB登録前の表示リスト
  List<String> _tempoDeleteList = <String>[]; //削除タグリストをつくる一歩手前のtagTitleリスト
  List<String> get tempoDeleteList => _tempoDeleteList;
  String _tempoInput=''; //TagInputChipに仮入力してるもの
  List<Chip> _displayChipList = <Chip>[]; //CompareScreen表示用
  List<Chip> get displayChipList => _displayChipList;
  List<Tag> _deleteTagList = <Tag>[];

  List<Tag> get deleteTagList => _deleteTagList;
  List<TagChart> _removeTagChartList = <TagChart>[];

  List<TagChart> get removeTagChartList => _removeTagChartList;

  ///TagPageで使用
  List<Tag> _allTagList = <Tag>[]; //TagPageでの表示用全タグリスト
  List<Tag> get allTagList => _allTagList;
  List<TagChart> _tagChartList = <TagChart>[]; //TagPage表示用(タグ名とアイテム数表示)
  List<TagChart> get tagChartList => _tagChartList;
  List<Tag> _selectTagList =
      <Tag>[]; //TagPage=>SelectTagPageへtagTitleで紐づいたタグリスト
  List<Tag> get selectTagList => _selectTagList;
  late TagChart selectTagChart; //TagPageでtagTitle編集時に選択したtagChartを格納
  List<ComparisonOverview>? _selectOverviews = <ComparisonOverview>[];

  List<ComparisonOverview>? get selectOverviews => _selectOverviews;
  String selectTagTitle = '';

//  List<String> idList=[];//ComparisonItemIdのリスト

  ListEditMode editStatus = ListEditMode.display;
  TagEditMode tagEditMode = TagEditMode.normal; //初期設定は通常モード
//  bool editFocus = false; //初期設定はタイトルのみ
  int? selectedIndex; //tagPageでのListTile選択
  int? selectedDescListIndex; //DescFromAndButtonでのListTIle選択
  bool isWay1MeritDeleteIcon = false; //AccordionPart=>DescFormのIconButton表示有無
  bool isWay1DemeritDeleteIcon = false;
  bool isWay2MeritDeleteIcon = false;
  bool isWay2DemeritDeleteIcon = false;
  bool isWay3MeritDeleteIcon = false;
  bool isWay3DemeritDeleteIcon = false;
  bool isWay1MeritFocusList = true; //settingPageでやったisReturnText
  bool isWay1DemeritFocusList = true;
  bool isWay2MeritFocusList = true;
  bool isWay2DemeritFocusList = true;
  bool isWay3MeritFocusList = true;
  bool isWay3DemeritFocusList = true;

  ///ListPage並び替え・削除モード
  List<String> deleteItemIdList = <String>[];
  List<DraggingItemData> draggedItems = <DraggingItemData>[];

  ///TagPage並び替え・削除モード
//  List<String> deleteTagTitleList = <String>[];
  List<DraggingTagChart> draggedTags = <DraggingTagChart>[];

  ///cupertinoSegmentControl用
  String segmentValue = '0';

  ///ここからメソッド
  ///ページ開いた時の取得(notifyListeners(リビルド)あり)
  Future<void> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
        await _compareRepository.getOverview(comparisonItemId);

    ///way1Title強制呼び出し
    way1Title = comparisonOverviews[0].way1Title!;
    way2Title = comparisonOverviews[0].way2Title!;
    notifyListeners();
  }

  ///FutureBuilder用(notifyListeners(リビルド)なし)
  /// //todo getSingle()に変更してすっきり書く
  Future<List<ComparisonOverview>> getWaitOverview(
      String comparisonItemId,) async {
    _comparisonOverviews =
        await _compareRepository.getOverview(comparisonItemId);

    ///強制呼び出し
    itemTitle = comparisonOverviews[0].itemTitle!;
    way1Title = comparisonOverviews[0].way1Title!;
    way2Title = comparisonOverviews[0].way2Title!;
    _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate!;
    _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate!;
    _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate!;
    _way2DemeritEvaluate = comparisonOverviews[0].way2DemeritEvaluate!;
    _conclusionController.text = comparisonOverviews[0].conclusion!;

    /// //todo way3Evaluate
//    print('FutureBuilderのway2のタイトル:$_way2Title');
    return _comparisonOverviews;
  }

  ///AddScreen/InputPartでComparisonOverview新規登録：ComparisonOverview=>ComparisonOverviewRecordでDB登録
  ///createNewItemに変更
//  Future<void> createComparisonOverview(
//      ComparisonOverview comparisonOverview) async {
//    await _compareRepository.createComparisonOverview(comparisonOverview);
////    notifyListeners();
//  }
  ///AddScreen/InputPartでComparisonOverview更新：itemTitle,way1Title,way2Titleのみ変更
  ///updateTitles
//  Future<void> updateComparisonOverView({
//      ComparisonOverview updateOverview,
////    String tagTitle,
////    ItemTitleEditMode itemTitleEditMode,
//  }) async {
//    //更新するプロパティだけ入れてrepositoryでCompanion作成=>更新
////    final updateOverview = ComparisonOverview(
////      comparisonItemId: comparisonOverview.comparisonItemId,
////      itemTitle: itemTitle,
////      way1Title: way1Title,
////      way2Title: way2Title,
////      createdAt: DateTime.now(),
////    );
//    await _compareRepository.updateComparisonOverView(updateOverview);
//  print('comparisonOverviewのタイトル類を更新');
//
////  if(itemTitleEditMode ==ItemTitleEditMode.select){
////    print('viewModel.updateComparison/onSelectTagする前:$tagTitle');
////    //todo 名前付引数でtagTitleを設定=>selectTagPage側から編集の場合はtagTitleを渡し、onSelectTagすることで、selectTagPageはSelectorのみでいいかも
////     return onSelectTag(tagTitle);//todo selectTagTitleでいいのではないか説
////  }else{
//    print('viewModel.updateComparison/onSelectTagする前:$tagTitle');
//    await onSelectTag(selectTagTitle);
////  }
//
//    notifyListeners();
//  }

  /// //todo way1,way2,way3入力
  ///AddScreen/InputPartでWay1Merit,Way2Meritリストを新規登録
  //way1Merit,way2Meritのリストを作って保存
  /// //todo list.add=>DB登録=>list空の流れではなく、
  // initWay1MeritをリストにしてcreateDescListに渡す方がすっきり書ける
  Future<void> createDesc(
    Way1Merit initWay1Merit,
    Way2Merit initWay2Merit,
    Way1Demerit initWay1Demerit,
    Way2Demerit initWay2Demerit,
  ) async {
    _way1MeritList = [initWay1Merit];
    _way2MeritList = [initWay2Merit];
    /// //todo _way3MeritList = [initWay3Merit];
    _way1DemeritList = [initWay1Demerit];
    _way2DemeritList = [initWay2Demerit];
    /// //todo _way3DemeritList = [initWay3Demerit];

    //ここでaddしていくと古いものがだぶる
    ///既存のoverviewでway1リスト追加=>新規でoverview,way1リスト作成,DB登録
    ///=>既存のoverviewが重複して登録されてしまう
//    _way1MeritList.add(initWay1Merit);
//    print('compareViewModel/createDesc/way1MeritList.add$_way1MeritList');
//    _way2MeritList.add(initWay2Merit);
    /// //todo way3追加
    await _compareRepository.createDescList(
        _way1MeritList, _way2MeritList, _way1DemeritList, _way2DemeritList,);
    _way1MeritList = <Way1Merit>[];
    _way2MeritList = <Way2Merit>[];
    _way1DemeritList = <Way1Demerit>[];
    _way2DemeritList = <Way2Demerit>[];
  }

  ///List<ComparisonOverview>ではなく、comparisonItemIdからComparisonOverview１行だけ取ってくる
  Future<void> getComparisonOverview(String comparisonItemId) async {
    overviewDB =
        await _compareRepository.getComparisonOverview(comparisonItemId);
  }

  Future<void> setWay1MeritNewValue(
      String comparisonItemId, int newValue,) async {
    //値を変えた場合だけ更新
    if (_way1MeritEvaluate != newValue) {
      //TablePartでviewModel.way1MeritEvaluateとして表示しないならこのset1行いらない
      _way1MeritEvaluate = newValue;
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        way1MeritEvaluate: newValue,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateWay1MeritEvaluate(updateOverview);
      notifyListeners();
    }
  }

  Future<void> setWay1DemeritNewValue(
      String comparisonItemId, int newValue,) async {
    if (_way1DemeritEvaluate != newValue) {
      _way1DemeritEvaluate = newValue;
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        way1DemeritEvaluate: newValue,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateWay1DemeritEvaluate(updateOverview);
      notifyListeners();
    }
  }

  Future<void> setWay2MeritNewValue(
      String comparisonItemId, int newValue,) async {
    if (_way2MeritEvaluate != newValue) {
      _way2MeritEvaluate = newValue;
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        way2MeritEvaluate: newValue,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateWay2MeritEvaluate(updateOverview);
      notifyListeners();
    }
  }

  Future<void> setWay2DemeritNewValue(
      String comparisonItemId, int newValue,) async {
    if (_way2DemeritEvaluate != newValue) {
      _way2DemeritEvaluate = newValue;
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        way2DemeritEvaluate: newValue,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateWay2DemeritEvaluate(updateOverview);
      notifyListeners();
    }
  }

  /// //todo way3メソッド設定
  Future<void> setWay3MeritNewValue(
      String comparisonItemId, int newValue,) async {
    _way3MeritEvaluate = newValue;
  }

  Future<void> setWay3DemeritNewValue(
      String comparisonItemId, int newValue,) async {
    _way3DemeritEvaluate = newValue;
  }

  ///引数 required
  Future<void> setConclusion(
      {required String comparisonItemId, required String newConclusion,}) async
  {
    if (conclusion != newConclusion) {
      conclusion = newConclusion;
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        conclusion: newConclusion,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateConclusion(updateOverview);
      notifyListeners();
    }
  }

  ///DescFormAndButtonでList<Way1Merit>の入力変更があったとき
  Future<void> setChangeListDesc(ComparisonOverview comparisonOverview,
      DisplayList displayList, String newDesc, int index,) async {
    debugPrint('setNewDesc!:$newDesc/setIndex:$index');

    ///List.generate=>DB更新は変更した行のみ
    // Listの中の[index]の番号のway1MeritDescのプロパティだけnewDescに変えたい
//    _way1MeritList = List.generate(_way1MeritList.length, (i) {
//      if(i == index){
//        return Way1Merit(
//          way1MeritId: _way1MeritList[i].way1MeritId,
//          comparisonItemId: _way1MeritList[i].comparisonItemId,
//          way1MeritDesc: newDesc,
//        );
//      }else{
//        return Way1Merit(
//          way1MeritId: _way1MeritList[i].way1MeritId,
//          comparisonItemId: _way1MeritList[i].comparisonItemId,
//          way1MeritDesc: _way1MeritList[i].way1MeritDesc,
//        );
//      }
//    });
    //    await _compareRepository.setWay1MeritDesc(_way1MeritList,index);
    switch (displayList) {
      case DisplayList.way1Merit:

        ///変更行作成=>DB更新は変更した行のみ
        final changeWay1Merit = Way1Merit(
          way1MeritId: _way1MeritList[index].way1MeritId,
          comparisonItemId: _way1MeritList[index].comparisonItemId,
          way1MeritDesc: newDesc,
        );
        await _compareRepository.setWay1MeritDesc(changeWay1Merit, index);
        _way1MeritList = await _compareRepository
            .getWay1MeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Merit:
        final changeWay2Merit = Way2Merit(
          way2MeritId: _way2MeritList[index].way2MeritId,
          comparisonItemId: _way2MeritList[index].comparisonItemId,
          way2MeritDesc: newDesc,
        );
        await _compareRepository.setWay2MeritDesc(changeWay2Merit, index);
        _way2MeritList = await _compareRepository
            .getWay2MeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way1Demerit:

        ///変更行作成=>DB更新は変更した行のみ
        final changeWay1Demerit = Way1Demerit(
          way1DemeritId: _way1DemeritList[index].way1DemeritId,
          comparisonItemId: _way1DemeritList[index].comparisonItemId,
          way1DemeritDesc: newDesc,
        );
        await _compareRepository.setWay1DemeritDesc(changeWay1Demerit, index);
        _way1DemeritList = await _compareRepository
            .getWay1DemeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:

        ///変更行作成=>DB更新は変更した行のみ
        final changeWay2Demerit = Way2Demerit(
          way2DemeritId: _way2DemeritList[index].way2DemeritId,
          comparisonItemId: _way2DemeritList[index].comparisonItemId,
          way2DemeritDesc: newDesc,
        );
        await _compareRepository.setWay2DemeritDesc(changeWay2Demerit, index);
        _way2DemeritList = await _compareRepository
            .getWay2DemeritList(comparisonOverview.comparisonItemId);
        break;
      /// //todo way3入力
      case DisplayList.way3Merit:
        break;
      case DisplayList.way3Demerit:
        break;
    }

    ///変更時の時間更新
    final updateOverview = ComparisonOverview(
      comparisonItemId: comparisonOverview.comparisonItemId,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateTime(updateOverview);

    notifyListeners();
  }

  ///DescFormAndButtonでリスト行追加
  Future<void> accordionAddList(
      ComparisonOverview comparisonOverview, DisplayList displayList,) async {
    switch (displayList) {
      case DisplayList.way1Merit:
        final initWay1Merit = Way1Merit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way1MeritDesc: '',
        );
        debugPrint('CompareViewModel/addWay1Merit/新規リスト追加前'
            '${_way1MeritList.map((way1Merit) => way1Merit.way1MeritDesc)
            .toList()}');
        await _compareRepository.addWay1Merit(initWay1Merit);
        //1行DBへ追加した後、追加したもの含めて_way1MeritListに取得リスト格納してみる
        _way1MeritList = await _compareRepository
            .getWay1MeritList(comparisonOverview.comparisonItemId);
        debugPrint('CompareViewModel/addWay1Merit/新規リスト追加後'
            '${_way1MeritList.map((way1Merit) => way1Merit.way1MeritDesc)
            .toList()}');
        break;
      case DisplayList.way2Merit:
        final initWay2Merit = Way2Merit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way2MeritDesc: '',
        );
        await _compareRepository.addWay2Merit(initWay2Merit);
        _way2MeritList = await _compareRepository
            .getWay2MeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way1Demerit:
        final initWay1Demerit = Way1Demerit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way1DemeritDesc: '',
        );
        await _compareRepository.addWay1Demerit(initWay1Demerit);
        _way1DemeritList = await _compareRepository
            .getWay1DemeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:
        final initWay2Demerit = Way2Demerit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way2DemeritDesc: '',
        );
        await _compareRepository.addWay2Demerit(initWay2Demerit);
        _way2DemeritList = await _compareRepository
            .getWay2DemeritList(comparisonOverview.comparisonItemId);
        break;
      /// //todo way3入力
      case DisplayList.way3Merit:
      case DisplayList.way3Demerit:
    }

    ///追加時の時間更新
    final updateOverview = ComparisonOverview(
      comparisonItemId: comparisonOverview.comparisonItemId,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateTime(updateOverview);

    notifyListeners();
  }

  ///DescFormAndButtonでリスト削除
  Future<void> accordionDeleteList(DisplayList displayList,
      int accordionIdIndex, ComparisonOverview comparisonOverview,) async {
    switch (displayList) {
      case DisplayList.way1Merit:
        final deleteWay1MeritId = _way1MeritList[accordionIdIndex].way1MeritId;
        await _compareRepository.deleteWay1Merit(deleteWay1MeritId!);
        //再取得しないとDescFormAndButtonでのListViewの認識している長さと削除するindexが異なりエラー
        _way1MeritList = await _compareRepository
            .getWay1MeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Merit:
        final deleteWay2MeritId = _way2MeritList[accordionIdIndex].way2MeritId;
        await _compareRepository.deleteWay2Merit(deleteWay2MeritId!);
        _way2MeritList = await _compareRepository
            .getWay2MeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way1Demerit:
        final deleteWay1DemeritId =
            _way1DemeritList[accordionIdIndex].way1DemeritId;
        await _compareRepository.deleteWay1Demerit(deleteWay1DemeritId!);
        _way1DemeritList = await _compareRepository
            .getWay1DemeritList(comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:
        final deleteWay2DemeritId =
            _way2DemeritList[accordionIdIndex].way2DemeritId;
        await _compareRepository.deleteWay2Demerit(deleteWay2DemeritId!);
        _way2DemeritList = await _compareRepository
            .getWay2DemeritList(comparisonOverview.comparisonItemId);
        break;
      /// //todo way3入力
      case DisplayList.way3Merit:
      case DisplayList.way3Demerit:
    }

    ///削除時の時間更新
    final updateOverview = ComparisonOverview(
      comparisonItemId: comparisonOverview.comparisonItemId,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateTime(updateOverview);
//    notifyListeners();
  }

  ///CompareScreenで表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
  /// //todo favorite,way3追加
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
    //値を変更した時だけ更新=>現状どの項目も変更時自動保存（保存押しても時間だけ変更）
    final saveOverview = ComparisonOverview(
      comparisonItemId: updateOverview.comparisonItemId,
      itemTitle: itemTitle,
      way1Title: way1Title,
      way2Title: way2Title,
      way1MeritEvaluate: _way1MeritEvaluate,
      way1DemeritEvaluate: _way1DemeritEvaluate,
      way2MeritEvaluate: _way2MeritEvaluate,
      way2DemeritEvaluate: _way2DemeritEvaluate,
      conclusion: conclusion,
      createdAt: DateTime.now(),
    );
    await _compareRepository.saveComparisonItem(saveOverview);

    ///updateComparisonOverViewと同じで内容更新されたらonSelectTag実施
    /// //todo 自動更新の場合はキーボード完了ボタンを押したらonSelectTag
    await onSelectTag(selectTagTitle);

    notifyListeners();
  }

  ///データ保存後に再取得
  Future<void> getOverviewList() async {
    debugPrint('getOverviewList発動');
    _comparisonOverviews = await _compareRepository.getOverviewList();
    debugPrint('getOverviewList非同期終了');
    notifyListeners();
  }

  ///ListPageのFutureBuilder用
  Future<List<ComparisonOverview>> getList() async {
//    print('getList発動');
    return _comparisonOverviews = await _compareRepository.getOverviewList();
  }

  //FutureBuilder用
  Future<List<ComparisonOverview>> isOverviewList() async {
    return _comparisonOverviews;
  }


  Future<void> changeEditStatus() async {
    if (editStatus==ListEditMode.edit) {
      editStatus = ListEditMode.display;
      deleteItemIdList = [];
    } else {
      editStatus = ListEditMode.edit;
    }
    notifyListeners();
  }

  //ListPage単一行削除
  Future<void> deleteItem(String comparisonItemId) async {
    ///tagChart更新//todo tagChartのidList格納できればもっとシンプルに書ける
    //itemIdをもとにList<Tag>取得(tagList拝借)=>
    // tagNameからList<tagChartt>取得=>agAmountの数でtagChart更新
    _tagList = await _compareRepository.getTagList(comparisonItemId);
    _tagNameList = _tagList.map((e) => e.tagTitle!).toList();
    final tagChartDBList =
        await _compareRepository.getTagChartList(_tagNameList);
    await Future.forEach(tagChartDBList, (TagChart tagChart) async {
      if (tagChart.tagAmount! > 1) {
        //Value更新
        // final decreaseTagChartList = <TagChart>[]..add(TagChart(
        //   tagTitle: tagChart.tagTitle, tagAmount: tagChart.tagAmount - 1,),);
        final decreaseTagChartList = <TagChart>[TagChart(
          tagTitle: tagChart.tagTitle, tagAmount: tagChart.tagAmount! - 1,)];

        await _compareRepository.updateTagChart(decreaseTagChartList);
      } else {
        //削除
        final removeTagChartList = <TagChart>[TagChart(
            tagTitle: tagChart.tagTitle, tagAmount: tagChart.tagAmount,)];
        await _compareRepository.removeTagChart(removeTagChartList);
      }
    });
    //削除
    await _compareRepository.deleteItem(comparisonItemId);

    _tagList = [];
    _tagNameList = [];
    //データ取得?
    notifyListeners();
  }

  //ListPage削除項目選択
  void checkDeleteIcon(String itemId) {
    ///1.Listにindexの値をupdateするメソッドがないので、map型に変換してupdateする
    ////asMap()するだけで{index:value}のMap型にできる=>map.update(index,(value)=>!value);
    ///2. comparisonItemIDをリストに追加・削除を行う
    if (deleteItemIdList.contains(itemId)) {
      deleteItemIdList.remove(itemId);
      debugPrint('id削除後:$deleteItemIdList');
    } else {
      deleteItemIdList.add(itemId);
     /// //todo deleteItemListが空出ない時だけshowDialog出す
      debugPrint('id追加後:$deleteItemIdList');
    }
    notifyListeners();
  }

  //ListPage選択行削除
  Future<void> deleteItemList() async {
    _tagList = [];
    //アイテムとTagを削除
    await _compareRepository.deleteItemList(deleteItemIdList);
    //idListからList<Tag>取得=>tagNameList変換=>1つずつTag取得=>tagAmountの数でtagChart更新
    await Future.forEach(deleteItemIdList, (String itemId) async {
      final singleIdTagList = await _compareRepository.getTagList(itemId);
      singleIdTagList.map((tag) => _tagList.add(tag)).toList();
    });
    _tagNameList = _tagList.map((e) => e.tagTitle!).toList();

    // tagNameList１つずつgetSingleTagChartして、それぞれtagAmount>1かを判別して更新・削除
    await Future.forEach(_tagNameList, (String tagName) async {
      final selectTag = await _compareRepository.getSingleTagChart(tagName);
      if (selectTag.tagAmount! > 1) {
        //Value更新
        final decreaseTagChartList = <TagChart>[TagChart(
            tagTitle: selectTag.tagTitle, tagAmount: selectTag.tagAmount! - 1,
        )];
        await _compareRepository.updateTagChart(decreaseTagChartList);
      } else {
        //削除
        final removeTagChartList = <TagChart>[TagChart(
            tagTitle: selectTag.tagTitle, tagAmount: selectTag.tagAmount,)];
        await _compareRepository.removeTagChart(removeTagChartList);
      }
    });
    deleteItemIdList = [];
    _tagList = [];
    _tagNameList = [];

    ///NavBarで削除おしてもListView反映されない
    ///=>snapshot<List<DraggingItemData>>を変更しないと通知されない
    ///>comparisonOverviewsを変更するのに同時にgetOverviewListが必要
    await getOverviewList();
  }

  //ListPage編集時の並び替え可能なアイテムリスト変換
  //initStateの役割をここで行う
  Future<List<DraggingItemData>> getItemDataList() async {
    // FutureBuilder呼び出し毎にaddしていくとdraggedItemsが増えていってしまう
    draggedItems = <DraggingItemData>[];
    for (var i = 0; i < _comparisonOverviews.length; ++i) {
      final overView = _comparisonOverviews[i];
      draggedItems.add(DraggingItemData(
          title: overView.itemTitle,
          key: ValueKey(i),
          comparisonItemId: overView.comparisonItemId,
          orderId: i,),);
    }
    return draggedItems;
  }

  ///ListPage編集並び替え後のDBの順番入れ替え、まずdataIdで行ってみる
  Future<void> changeCompareListOrder(
      List<DraggingItemData> draggingItems,) async {
    //draggingItemのcompareItemId順にDBから新たにcomparisonItemのリストを取得
    final draggingIdList =
        draggingItems.map((item) => item.comparisonItemId!).toList();
    final newCompareItemList =
        await _compareRepository.getNewOrderList(draggingIdList);
    //draggingItemsをrepositoryにそのまま渡してcomparisonItemId順にdataIdを更新する
    await _compareRepository.changeCompareListOrder(newCompareItemList);

    ///_comparisonOverviewsを新たな順番で取得できてればOK
    _comparisonOverviews = await _compareRepository.getOverviewList();
  }

  Future<void> backListPage() async {
    notifyListeners();
  }

  /// //todo way3追加
  Future<void> setOverview(ComparisonOverview comparisonOverview) async {
    itemTitle = comparisonOverview.itemTitle!;
    way1Title = comparisonOverview.way1Title!;
    _way1MeritEvaluate = comparisonOverview.way1MeritEvaluate!;
    _way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate!;
    way2Title = comparisonOverview.way2Title!;
    _way2MeritEvaluate = comparisonOverview.way2MeritEvaluate!;
    _way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate!;
    conclusion = comparisonOverview.conclusion!;
//    print('文頭のsetOverview');
//    notifyListeners();
  }

  ///List<Way1Merit>,List<Way2Merit>取得(文頭取得用)
  Future<void> getAccordionList(String comparisonItemId) async {
    _way1MeritList =
        await _compareRepository.getWay1MeritList(comparisonItemId);
    _way2MeritList =
        await _compareRepository.getWay2MeritList(comparisonItemId);
    _way1DemeritList =
        await _compareRepository.getWay1DemeritList(comparisonItemId);
    _way2DemeritList =
        await _compareRepository.getWay2DemeritList(comparisonItemId);
    /// //todo way3入力
//    print('文頭のgetWay1/Way2MeritList');
//    notifyListeners();
  }

  ///List<Way1Merit>取得(FutureBuilder用)
  Future<List<Way1Merit>> getWay1MeritDesc(String comparisonItemId) async {
//    print('FutureBuilderでDBからList<Way1Merit> _way1MeritList取得');
    return _way1MeritList =
        await _compareRepository.getWay1MeritList(comparisonItemId);
  }

  ///List<Way1Mer2t>取得(FutureBuilder用)
  Future<List<Way2Merit>> getWay2MeritDesc(String comparisonItemId) async {
    return _way2MeritList =
        await _compareRepository.getWay2MeritList(comparisonItemId);
  }

  ///List<Way1Demerit>取得(FutureBuilder用)
  Future<List<Way1Demerit>> getWay1DemeritDesc(String comparisonItemId) async {
//    print('FutureBuilderでDBからList<Way1Demerit> _way1DemeritList取得');
    return _way1DemeritList =
        await _compareRepository.getWay1DemeritList(comparisonItemId);
  }

  ///List<Way2Demerit>取得(FutureBuilder用)
  Future<List<Way2Demerit>> getWay2DemeritDesc(String comparisonItemId) async {
//    print('FutureBuilderでDBからList<Way1Merit> _way1MeritList取得');
    return _way2DemeritList =
        await _compareRepository.getWay2DemeritList(comparisonItemId);
  }

  /// //todo way3追加

  ///tagDialogPageでList<tag>を新規登録
  ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
  Future<void> createTag(ComparisonOverview comparisonOverview) async {
    //tagSummary以外のタイトルも増えてしまうのでtagChartList最初空に
    _tagChartList = [];
    //表示用リストだったものを本登録
    ///TagDialogPageで完了ボタン押した時に入力中のタグも登録
    if (_tempoInput == '' || _tempoInput == '　' || _tempoInput == ' ') {
      debugPrint('_tempoInput空の方/_tempoInput：$_tempoInput');
    } else {
      // _tempoInputだけのとき、tagNameListにもtempoInputが追加されてしまう
      debugPrint('_tempoInput入力の方/_tempoInput$_tempoInput');
      _tempoDisplayList.add(_tempoInput);
    }


    // _tagListとしてID固有のタグをCompareScreen開く時のgetTagListで格納済みなので、dgTagListを取らなくていい
    // ID固有のタグが最初にない時に登録するとtagTitle!がどうなるか確認
    final dbTitleList = _tagList.map((tag) => tag.tagTitle!).toList();
    final dbTitleSet = dbTitleList.toSet();
    //TagChart新規登録or更新するものだけ抜き出す
    final extractAddTag = (_tempoDisplayList.toSet()..removeAll(dbTitleSet));
    final extractAddTagList = extractAddTag.toList();
    final extractRemoveTagSet = (dbTitleSet..removeAll(_tempoDisplayList.toSet(
    ),)) ;
    final  extractRemoveTagList = extractRemoveTagSet.toList();
    //ここで場合分け、tagChartDBにtagTitleあり=>update,なし=>新規登録
    ///_allTagList:ID関係なく全タグリスト、dbTitleList:ID固有のタグのタイトル名だけのリスト
    _allTagList = await _compareRepository.getAllTagList();
    final tagAllTitleList = <String>[]; //DBからのTagのタイトル
    //    DBのTagのタイトル取得=>格納
    _allTagList.map((tag) {
      return tagAllTitleList.add(tag.tagTitle!);
    }).toList();

//     DBのTagChartのタイトル取得=>格納
    final tagChartDBTitleList = await _compareRepository.getTagChartDBTitle();
    debugPrint('tagChartDBTitleList:$tagChartDBTitleList');

    //1.追加更新tagChart作成:extractAddTagからtagChartDBTitleにあるタイトルだけ抽出
    //1.1.extractDelete = tagAllTitleList-extractAddTag(更新用タイトルタグ抽出)
    final extractDeleteTitleSet = tagAllTitleList.toSet()
      ..removeAll(extractAddTag);
    final extractDeleteTitle = extractDeleteTitleSet.toList();
    //1.2.extractTagDB = tagAllTitleList-extractDelete(更新タイトルタグを抽出)
    //tagAllTitleListからextractDeleteTitleを1つづつ抜いていく
    for (var i = 0; i < extractDeleteTitle.length; ++i) {
    }
    //1.3.extractNewTitle = extractAddTag-tagChartDBTitleList
    /// //todo extractAddTagは元々Set<String>なのでtoSet()いらない
    final extractNewTitle = extractAddTag.toSet()
      ..removeAll(tagChartDBTitleList.toSet());
    //1.4.extractTempo = extractAddTag-extractNewTitle
    final extractTempo = extractAddTag.toSet()..removeAll(extractNewTitle);
    //1.5.tagChartUpdateList = extractTagDB+extractTempo
    final tagChartUpdateList = tagAllTitleList + extractTempo.toList();

// 更新タイトルの数を数えてTagChartとして更新登録
    final tagSummary = <String, int>{}; //Map<String,int>
    //重複タイトルの数を数えてMap型に格納
    //参照:https://www.fixes.pub/program/268895.html
    //.where参照:https://qiita.com/dennougorilla/items/170deacf178891ced41e
    tagChartUpdateList.toSet().toList().forEach((st) =>
        tagSummary[st] = tagChartUpdateList.where((i) => i == st).length,);
    //Map<String,dynamic> =>List<TagChart>参考:https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    tagSummary.forEach((key, amount) => _tagChartList.add(TagChart(
          tagTitle: key,
          tagAmount: amount,
        ),),);
    debugPrint('tagSummary:$tagSummary');
      await _compareRepository.updateTagChart(_tagChartList);

    //2.削除更新tagChart作成:extractRemoveTagだけTagChartDBのAmountが2以上なら-1、1なら削除する
    ///List<String?>=>List<String>への変換
   /// https://stackoverflow.com/questions/66896648/how-to-convert-a-listt-to-listt-in-null-safe-dart
    final withoutNulls =<String>[for (var s in extractRemoveTagList)if(s!=null)s
    ];
    debugPrint('viewModel/createTag/withoutNulls:$withoutNulls');
      final tagChartDBList =
          await _compareRepository.getTagChartList(withoutNulls);
      await Future.forEach(tagChartDBList, (TagChart tagChart) async {
        if (tagChart.tagAmount! > 1) {
          //Value更新
          final decreaseTagChartList = <TagChart>[TagChart(
              tagTitle: tagChart.tagTitle, tagAmount: tagChart.tagAmount! - 1,
          )];
          await _compareRepository.updateTagChart(decreaseTagChartList);
        } else {
          //削除
          final removeTagChartList = <TagChart>[TagChart(
              tagTitle: tagChart.tagTitle, tagAmount: tagChart.tagAmount,)];
          await _compareRepository.removeTagChart(removeTagChartList);
        }
      });
    //新規tagChart作成:
    final newTagChartTitleList = _tempoDisplayList.toSet()
      ..removeAll(tagChartDBTitleList.toSet())
      ..toList();
    final newTagChartList = newTagChartTitleList
        .map((tagTitle) => TagChart(tagTitle: tagTitle, tagAmount: 1))
        .toList();

    await _compareRepository.createTagChart(newTagChartList);

    //List<Tag>登録は最後に移動
    //List<Tag>作成はDBでの重複削除リスト作成後にrepositoryで行う
    //repo側でupdateOverview作成してDatetime更新(deleteTagメソッドでも同じ)
    await _compareRepository.createTag(
        extractAddTagList, comparisonOverview.comparisonItemId,);

    ///タグを空にして完了おしてもTagがでてくるので追加
    _tempoDisplayList = [];

    ///残っているとtempoDisplayListにaddされ続けてしまう
    _tempoInput = '';
    _tagChartList = []; //編集=>完了でどんどん増えていってしまうので
  }

  ///TagDialogPageでの登録完了(createTag)前の表示用リスト
  //tagChipsでtextField入力内容をviewModelへset
  Future<void> setTempoDisplayList(List<String> tempoDisplayList) async {

    _tempoDisplayList = tempoDisplayList;

    //onSubmitted時にtempoDeleteListから重複しているタグを削除
    // (tempoDisplayListに上がっているものはtempoDeleteListから抜く)
    final tempoDisplaySet = _tempoDisplayList.toSet(); //StringのSet
    final tempoDeleteLabelsSet = _tempoDeleteList.toSet() //Stringのset
      ..removeAll(tempoDisplaySet);
    _tempoDeleteList = tempoDeleteLabelsSet.toList();
    ///  _tempoInputに文字が残っていると消したのにcreateTag時に _tempoDisplayListにaddされてしまう
    _tempoInput = '';
  }

  ///TagInputChipで仮入力したものをset
  void setTempoInput(String tempoInput) {
    if(tempoInput.trim().isEmpty){
    } else {
      _tempoInput = tempoInput;
      debugPrint('viewModel/_tempoInput:$_tempoInput');
    }
  }

  ///CompareScreenでのList<Tag>取得(文頭取得用)
  Future<void> getTagList(String comparisonItemId) async {
    /// //todo 初期は_tagListはnullになる？？
    _tagList = await _compareRepository.getTagList(comparisonItemId);
    ///null safety mapの後ろに型追加、tag.tagTitleは強制呼び出し
    _tagNameList = _tagList.map<String>((tag) => tag.tagTitle!).toList();
    _tempoDisplayList = _tagNameList;
    //List<Tag>=>List<Chips>へ変更
    _displayChipList = _tagList.map((tag) {
      return Chip(
        ///tag.tagTitleは強制呼び出し
        label: Text(tag.tagTitle!),
      );
    }).toList();

    //ここでSelectTaPage更新するとComPareScreenへ映る毎に読み込まれてしまうのでやめる
//    await onSelectTag(selectTagTitle);
    notifyListeners();
  }

  ///tagChipsで削除するTagを登録
  Future<void> createDeleteList(
      List<String> tempoDeleteLabels, List<String> tempoDisplayList,) async {
    //削除候補のdeleteTag名がxボタンを押しただけでtagNameListからも消えているので再度tagListからtagNameList作り直し
    _tagNameList=_tagList.map<String>((tag) => tag.tagTitle!).toList();
    //削除時も_tempoDisplayListに格納=>createTag時に使用
    _tempoDisplayList = tempoDisplayList;
    //削除する項目(tempoDeleteLabels)とDB登録してある項目(_tagNameList)を結合
    final joinList = [...tempoDeleteLabels, ..._tagNameList];
    //重複のみを抜き出す（重複削除はset化してremoveAllすれば良いが、重複抜出はリスト結合&if文しかない）
    // ここではTag化せずにList<String>に留めておいて完了押(deleteTag)したらTag化する方向にもっていく
    final lists = <String>[];
    joinList.map((title) {
      if (lists.contains(title)) {
        _tempoDeleteList.add(title);
        debugPrint('viewModel/createDeleteList/_tempoDeleteList:$_tempoDeleteList');
      } else {
        lists.add(title);
      }
    }).toList();
    //onSubmittedで追加=>onDeleted削除時に_tempoInputに文字があると登録されてしまう
    _tempoInput = '';
  }

  ///tagDialogPageでList<tag>を削除
  Future<void> deleteTag(String comparisonItemId) async {
    //createDeleteListで作成したtempoDeleteListをList<Tag>化してDBへ渡す
    debugPrint('deleteTagメソッドで消すtempoDeleteTagList:$_tempoDeleteList');
    _tempoDeleteList.map((title) {
      final deleteTag = Tag(
        //tagIdがrequiredなのでUuidでとりあえず入力
        tagId: int.parse(
            const Uuid().v1().replaceAll('-', '').substring(0, 9),radix:16,),
        comparisonItemId: comparisonItemId,
        tagTitle: title,
      );
      deleteTagList.add(deleteTag);
    }).toList();
//    print('deleteTagメソッドで消すリスト:'
//        '${deleteTagList.map((e) => e.tagTitle).toList()}');
    await _compareRepository.deleteTag(deleteTagList);

    ///deleteTagListが空じゃない時、更新日時を更新(createTagはrepoで実施)
    if (deleteTagList.isNotEmpty) {
      final updateOverview = ComparisonOverview(
        comparisonItemId: comparisonItemId,
        createdAt: DateTime.now(),
      );
      await _compareRepository.updateTime(updateOverview);
    }

    _tempoDeleteList = [];
    _deleteTagList = [];
  }

  //tagDialogPageで左上でキャンセルした時に_tempoDisplayListを空に
  void clearTempoList() {
    _tempoDisplayList = [];
    _tempoDeleteList = [];
    //キャンセル時に_tempoInputに文字があると次の入力時に残る
    _tempoInput = '';
  }

  ///TagPageのFutureBuilder用
  Future<List<TagChart>> getAllTagChartList() async {
    _tagChartList = await _compareRepository.getAllTagChartList();
    debugPrint(
        'getAllTagChartList/tagChart:${_tagChartList.map((tagChart) => tagChart.tagTitle)}',);

    //TagPageを表示する手順
    ///方法1. List<Tag>の内容を全てList<TagChart>として取得して表示する:難
    ///重複タイトルを削除&重複タイトルのcomparisonItemIdをリスト化する
    ///List<Tag> => List<Map<String,dynamic>> =>同じタイトル数とそのidを抽出 =>List<TagChart>

    ///方法2. List<Tag>から最低限必要なタイトルとアイテム数だけをList<TagChart>に格納して表示する:簡単
//    final tagAllTitleList = <String>[];
//    _tagChartList =[];//編集=>完了でどんどん増えていってしまうので
//    _allTagList.map((tag) {
//     return tagAllTitleList.add(tag.tagTitle);
//    }).toList();

//    final tagSummary =<String, int>{};//Map<String,int>
//    tagAllTitleList.toSet().toList().forEach(
//            (st)=> tagSummary[st]=
//            tagAllTitleList.where((i)=> i== st).length);
////    final tagChartList = <TagChart>[];
//    tagSummary.forEach((key, amount) =>
//        _tagChartList.add(TagChart(
//            tagTitle: key,
//            tagAmount: amount,
//            myFocusNode: FocusNode(),//タップした時focusする用に追加
//        )));
    ///focusNodeだけ加えて返す//todo mapに変換
    final tagDisplayList = <TagChart>[];
    for (final tagChart in _tagChartList) {
      tagDisplayList.add(TagChart(
        dataId: tagChart.dataId,
        tagTitle: tagChart.tagTitle,
        tagAmount: tagChart.tagAmount,
        // itemIdList: tagChart.itemIdList,
        myFocusNode: FocusNode(),),);
    }

//    _tagChartList.map((tagChart){
//      TagChart(dataId: tagChart.dataId,
//        tagTitle: tagChart.tagTitle,
//        tagAmount: tagChart.tagAmount,
//      myFocusNode: FocusNode());
//    }).toList();

//    print('getAllTagChartList/FocusNode追加/tagChart:${_tagChartList.map((tagChart) => tagChart.tagTitle)}');
    debugPrint(
        'getAllTagChartList/FocusNode追加/tagDisplayList:${tagDisplayList.map((tagChart) => tagChart.tagTitle)}',);
    return tagDisplayList;
  }

  // ignore: duplicate_ignore
  ///TagPage=>SelectTagPage
  // ignore: lines_longer_than_80_chars
  Future<void> onSelectTag(String tagTitle) async {
    ///tag名を元にDBからList<Tag>=>comparisonIdのリスト
    ///=>idリストを元にDBからList<Overview>をviewModelに格納
    selectTagTitle = tagTitle;
    _selectOverviews = [];
    //tagTitleを元にList<Tag>を取得(更新順)
    //ListPage(_comparisonOverviews)も
    // SelectTagPage(_selectOverviews)もcreatedAtはidを元にDBからとってくるので同じ
    //タグが追加された順になっている(一方で更新されたものほど上に来た方が使い勝手いいかも(ascでなくてdesc))
    _selectTagList = await _compareRepository.onSelectTag(tagTitle);
    debugPrint('viewModel/onSelectTag:${_selectTagList.map((e) => e.tagTitle)}');
    debugPrint(
        'viewModel/onSelectTag:${_selectTagList.map((e) => e.createAtToString)}',);
    //[Tag(),Tag(),Tag()]みたいなイメージ

    // Tag内のcomparisonItemIdを元にoverViewを取得しリスト化
    final idList = _selectTagList.map((tag) => tag.comparisonItemId).toList();

    ///https://zenn.dev/ttskch/articles/4cee05c400b4d8
    // final results=
    // await Future.wait([getSelect(idList)]);

  //List<String?>=>List<String>へ変換してFuture.forEach使用
    final withoutNulls =<String>[for (var s in idList)if(s!=null)s];
    await Future.forEach(withoutNulls, (String id) async{
      final selectOverView = await _compareRepository.getComparisonOverview(id);
      _selectOverviews!.add(selectOverView);
    });
    debugPrint(
           'Future.forEach/id:${_selectOverviews!.map((e) => e.comparisonItemId).toList()}',);
    notifyListeners();
  }


  /// //todo =>使わないので削除して良い
  ///SelectTagPageのFutureBuilder用
  Future<List<ComparisonOverview>> getSelectList(String tagTitle) async {
    _selectOverviews = [];
    _selectTagList = await _compareRepository.onSelectTag(tagTitle);
    final idList = _selectTagList.map((tag) => tag.comparisonItemId).toList();
    await Future.forEach<dynamic>(idList, (String id) async {
      final selectOverView = await _compareRepository.getComparisonOverview(id);
      _selectOverviews!.add(selectOverView);
    } as FutureOr<dynamic> Function(dynamic element),);
    return _selectOverviews!;
  }

  ///onSelectTagを実施してSelectTagPageのSelectorを更新するだけのメソッド
  //TagDialogPageの完了ボタンで追加=>削除=>このメソッド=>読み込み(notifyListeners)するので
  //notifyListenersはなし
  Future<void> updateSelectTagPage() async {
    await onSelectTag(selectTagTitle);
  }

  //TagPageでの通常モード(編集)<=>編集モード(完了)の切替
//  Future<void> changeTagEditMode() {
//     tagEditMode = !tagEditMode;
//     ///"完了"押した時に_selectedIndexをデフォルトに(次に編集押した時に前の選択状態にならないようにする)
//       selectedIndex =null;
//    notifyListeners();
//  }

  ///TagPageでの編集モード変更
  void changeToTagTitleEdit() {
    tagEditMode = TagEditMode.tagTitleEdit;

    ///"完了"押した時に_selectedIndexをデフォルトに(次に編集押した時に前の選択状態にならないようにする)
    selectedIndex = null;
    notifyListeners();
  }

  //TagPage編集=>削除・並び替え画面=>「完了」=>選択行削除実行
  void changeToTagDelete() {
    tagEditMode = TagEditMode.tagDelete;

    ///"完了"押した時に_selectedIndexをデフォルトに(次に編集押した時に前の選択状態にならないようにする)
    selectedIndex = null; /// //todo 選択削除できたらいらない?
    _tempoDeleteList = [];
    debugPrint('changeToTagDelete/$tempoDeleteList');

    notifyListeners();
  }

  void changeToNormal() {
    tagEditMode = TagEditMode.normal;
    notifyListeners();
  }

  //TagListでの通常モード(タイトル)<=>フォーカスモードの切替
  Future<void> changeEditFocus(int listNumber) async {
    selectedIndex = listNumber;
    notifyListeners();
//  selectedIndex =null;//ここでデフォルトにするとリストタップしても変更しなくなる
  }

  ///TagPageの１つだけのタグ削除
  Future<void> onDeleteTag(String tagTitle) async {
    //tagTitleで紐づけて削除するのでcomparisonItemIdいらない
    //一応Tag形式にしてやりとりしてるが、tagTitleだけあれば削除可能(のはず)
    //もうTag変換せずにtagTitleだけ渡す
    // final deleteTag = Tag(tagTitle: tagTitle);
    await _compareRepository.onDeleteTag(tagTitle);
    //削除してtagPage更新
    selectedIndex = null;
    /// //todo 削除したアイテム全ての日時更新(タグ名変更と同じで変えるのは変かも)
    final removeTagChartList = <TagChart>[TagChart(tagTitle: tagTitle)];
    await _compareRepository.removeTagChart(removeTagChartList);
    notifyListeners();
  }

  void unFocusTagPageList() {
    //考え方はchangeToNormalメソッドみたいな感じ
    selectedIndex = null;
    notifyListeners();
  }

  ///タグ名の編集時にタグ選択した時にcomparisonIdを取得する タグ名変えてもcreatedAtは更新しない
  //updateTagTitleと２こ１
  /// //todo getAllTagListの方法1でList<TagChart>内にcomparisonItemId格納できればこのメソッドいらない
  Future<void> getTagTitleId(String tagTitle) async {
    //tagTitleからList<Tag>読取
    _selectTagList = await _compareRepository.onSelectTag(tagTitle);
    debugPrint(
        'viewModel/getTagTitled/_selectTagList:${_selectTagList.map((e) => e.tagTitle)}',);
    selectTagChart = await _compareRepository.getSingleTagChart(tagTitle);
  }

  ///タグ名編集画面でtextFieldに変更があればDBを更新
  Future<void> updateTagTitle(String newTagTitle) async {
    //タグが1つのcomparisonItemIdに複数ある場合があるので、comparisonItemId&tagIdで更新
    _selectTagList = _selectTagList.map((tag) {
      return Tag(
        comparisonItemId: tag.comparisonItemId,
        tagId: tag.tagId,
        tagTitle: newTagTitle,
        createdAt: tag.createdAt,
        createAtToString: tag.createAtToString,
      );
    }).toList();
    await _compareRepository.updateTagTitle(_selectTagList, newTagTitle);
    //tagChartのタグ名も更新
    await _compareRepository.updateTagChartTitle(selectTagChart, newTagTitle);
  }

  //TagPageの削除・並び替え画面時切り替え  //initStateの役割をここで行う
  Future<List<DraggingTagChart>> getTagChartList() async {
    // FutureBuilder呼び出し毎にaddしていくとdraggedItemsが増えていってしまう
    draggedTags = <DraggingTagChart>[];
    for (var i = 0; i < _tagChartList.length; ++i) {
      final tagOverView = _tagChartList[i];
      draggedTags.add(DraggingTagChart(
          tagTitle: tagOverView.tagTitle,
          key: ValueKey(i),
          tagAmount: tagOverView.tagAmount,
          orderId: i,),);
    }
    return draggedTags;
  }

  ///TagPage編集=>選択削除・並び替え画面での削除候補のチェック
  //方法1.Tapしてチェック=>deleteTagListへ格納、
  //     チェック済=>tagTitleが重複しているTagをdeleteTagListから削除:難
  //方法2.Tapしてチェック=>tempoDeleteListへtagTitleのみ格納
  //tagTitleでDBからdeleteItemIdListにcomparisonItemId格納
  //deleteSelectTagListで削除=>deleteItemIdListの重複削除し、List<Tag>に変換して削除
  Future<void> checkDeleteTag(String tagTitle) async {
    ///tagTitleをリストに追加・削除を行う
    ///comparisonItemIdをリストに追加・削除を行う(ListPage削除用のdeleteItemIdListを借りる)
    debugPrint('checkDeleteTag/$tempoDeleteList');
    if (_tempoDeleteList.contains(tagTitle)) {
      //tagTitleチェック外す
      _tempoDeleteList.remove(tagTitle);
      //tagTitleが同じのTagをdeleteTagListから削除:難
      //deleteItemIdListからitemIdList全て削除(同じid全て消す)set化してremoveAll
      _selectTagList = await _compareRepository.onSelectTag(tagTitle);
      final updateIdSet =
          _selectTagList.map((tag) => tag.comparisonItemId).toSet();
      final deleteIdSet = deleteItemIdList.toSet()..removeAll(updateIdSet);
      deleteItemIdList = deleteIdSet.toList();
      debugPrint('tagTitle削除後:$_tempoDeleteList');
    } else {
      //tagTitle新たにチェック
      _tempoDeleteList.add(tagTitle);
      /// //todo getAllTagListでitemIdListに格納することでDBからとらなくていい
      //tagChartList内にidList格納できないとonSelectTagみたいにtagTitleを使ってDBからとるしかない
      _selectTagList = await _compareRepository.onSelectTag(tagTitle);
      _selectTagList
          .map((tag) => deleteItemIdList.add(tag.comparisonItemId!))
          .toList();
      //完了押した時にdeleteItemIdList内の同じ値削除(id一つだけ残す)set化してList化
      debugPrint('tagTitle追加後:$_tempoDeleteList');
    }
    notifyListeners();
  }

  ///TagPage編集=>削除・並び替え画面=>「削除」=>選択行削除実行
  Future<void> deleteSelectTagList() async {
    //重複id削除(id一つだけ残す)set化してList化
    final idSet = deleteItemIdList.toSet();
    deleteItemIdList = idSet.toList(); //日時更新用
    //Tag削除
    _tempoDeleteList.map((title) {
      final deleteTag = Tag(
        tagId: int.parse(
          const Uuid().v1().replaceAll('-', '').substring(0, 9),radix:16,),
        tagTitle: title,
      );
      deleteTagList.add(deleteTag);
    }).toList();

    //TagChart削除
    _tempoDeleteList.map((title) {
      final deleteTagChart = TagChart(
        tagTitle: title,
      );
      _removeTagChartList.add(deleteTagChart);
    }).toList();
    await _compareRepository.deleteSelectTagList(deleteTagList);
    /// //todo tagDialogの_removeTagChartListにおきかえてもいい
    await _compareRepository.removeTagChart(_removeTagChartList);
    _removeTagChartList = [];

    //削除時、紐づいたitemIdの更新日時を更新(mapでやるとListでrepoに渡す必要あり)
    if (deleteTagList.isNotEmpty) {
      await Future.forEach(deleteItemIdList, (String id) {
        final updateOverview = ComparisonOverview(
          comparisonItemId: id,
          createdAt: DateTime.now(),
        );
        _compareRepository.updateTime(updateOverview);
      });
    }
    //_tempoDeleteListとdeleteTagList,deleteItemIdList空に
    deleteItemIdList = [];
    _tempoDeleteList = [];
    _deleteTagList = [];
    _selectTagList = [];
    await getAllTagChartList(); //_tagChartListの更新
    notifyListeners(); //tagPageのFutureBuilderでList<DraggingTagChart>の更新
  }

  ///TagPage並び替え後のDBの順番入れ替え
  Future<void> changeTagListOrder(List<DraggingTagChart> draggingTags) async {
    //draggingTags順にdataIdを更新する
    await _compareRepository.changeTagListOrder(draggingTags);
    _tagChartList = await _compareRepository.getAllTagChartList();
  }

  ///TagDialogPageのFutureBuilderで候補タグ格納(全タグから選択タグを削除)
  Future<List<String>> getCandidateTagList() async {
    //全タグリストから選択されたタグリストを比較して重複を削除
    _allTagList = await _compareRepository.getAllTagList();
    final candidateTitleSet = <String>{};
    _allTagList.map((tag) {
      ///null safety tagTitle初回はnullになるはず、、、
      return candidateTitleSet.add(tag.tagTitle!);
    }).toSet();
    final choiceTitleSet = <String>{};
    tagList.map((tag) {
      return choiceTitleSet.add(tag.tagTitle!);
    }).toSet();

    ///removeAll使うにはListはダメでSetを用いる
    candidateTitleSet.removeAll(choiceTitleSet);
    return candidateTagNameList = candidateTitleSet.toList();

  }

  ///AddScreen/InputPartでComparisonOverview新規登録：ComparisonOverview=>ComparisonOverviewRecordでDB登録
  Future<void> createNewItem(ComparisonOverview newComparisonOverview) async {
    await _compareRepository.createComparisonOverview(newComparisonOverview);
    notifyListeners();
  }

  /// //todo way3追加
  Future<void> updateTitles(ComparisonOverview comparisonOverview) async {
    //compareScreenのSelectorまわすので入力
    itemTitle = _titleController.text;
    way1Title = _way1Controller.text;
    way2Title = _way2Controller.text;

    //引数はcomparisonItemIdしか使わず、テキスト入力はviewModelの値
    final updateOverview = ComparisonOverview(
      comparisonItemId: comparisonOverview.comparisonItemId,
      itemTitle: _titleController.text,
      way1Title: _way1Controller.text,
      way2Title: _way2Controller.text,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateTitles(updateOverview);
    await onSelectTag(selectTagTitle);
    notifyListeners();
    _titleController.clear();
    _way1Controller.clear();
    _way2Controller.clear();
  }

  //タイトル更新時(AddScreenMode.edit)、
  // inputPartの初期表示(CompareScreeのSelectorで表示されているものを表示)
  void setEditController() {
    _titleController.text = itemTitle;
    _way1Controller.text = way1Title;
    _way2Controller.text = way2Title;
  }

  //タイトル作成時(AddScreenMode.add)、
  // addScreenでの初期表示、cancelするときとDB登録したあと
  Future<void> itemControllerClear() async {
    _titleController.clear();
    _way1Controller.clear();
    _way2Controller.clear();
  }

  //AddScreenでのボタン押せる・押せないの判定のため、TextField入力に変更があったらnotifyListeners
  void itemTitleChanged() {
    notifyListeners();
  }

  //way1MeritListをtapしたら他のリストのTextFieldはTextに戻る
  void focusWay1MeritList() {
    isWay1MeritDeleteIcon = true;
    isWay1MeritFocusList = true;
    //isWay1MeritFocusList以外false
    isWay1DemeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3MeritFocusList = false;
    isWay3DemeritFocusList = false;
    notifyListeners();
  }

  void focusWay2MeritList() {
    isWay2MeritDeleteIcon = true;
    isWay2MeritFocusList = true;
    //isWay2MeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay1DemeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3MeritFocusList = false;
    isWay3DemeritFocusList = false;
    notifyListeners();
  }

  void focusWay1DemeritList() {
    isWay1DemeritDeleteIcon = true;
    isWay1DemeritFocusList = true;
    //isWay1MeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3MeritFocusList = false;
    isWay3DemeritFocusList = false;
    notifyListeners();
  }

  void focusWay2DemeritList() {
    isWay2DemeritDeleteIcon = true;
    isWay2DemeritFocusList = true;
    //isWay1MeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay1DemeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay3MeritFocusList = false;
    isWay3DemeritFocusList = false;
    notifyListeners();
  }

  void focusWay3MeritList() {
    isWay3MeritDeleteIcon = true;
    isWay3MeritFocusList = true;
    //isWay3MeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay1DemeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3DemeritFocusList = false;
    notifyListeners();
  }

  void focusWay3DemeritList() {
    isWay3DemeritDeleteIcon = true;
    isWay3DemeritFocusList = true;
    //isWay3DemeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay1DemeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3MeritFocusList = false;
    notifyListeners();
  }

  Future<void> selectSegment(String newValue) async {
    segmentValue = newValue;
    notifyListeners();
  }
}
