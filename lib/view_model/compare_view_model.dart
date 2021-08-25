import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:flutter/material.dart';

class CompareViewModel extends ChangeNotifier {
  CompareViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;
  List<ComparisonOverview> _comparisonOverviews = <ComparisonOverview>[];
  List<ComparisonOverview> get comparisonOverviews => _comparisonOverviews;
  //ListPage編集並び替え後のリスト
  List<ComparisonOverview>  newComparisonOverviews= <ComparisonOverview>[];
  CompareScreenStatus compareScreenStatus;
  ComparisonOverview overviewDB;
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
  TextEditingController _conclusionController = TextEditingController();
  TextEditingController get conclusionController => _conclusionController;
  String conclusion = '';

  //textFieldからviewModelへの変更値登録があるのでカプセル化しない
  String tagTitle= '';
  String addTagTitle;

 ///CompareScreenで使用
  List<String> candidateTagNameList = <String>[];
//  List<String> get candidateTagNameList =>_candidateTagNameList;
  List<Tag> _tagList = <Tag>[];//CompareScreenでのIDに紐づく選択済リスト
  List<Tag> get tagList => _tagList;
  List<String> _tagNameList = <String>[];//TagDialogPageでのIDに紐づくDBへの登録用リスト
  List<String> get tagNameList =>_tagNameList;
  List<String> _tempoDisplayList =<String>[];//TagDialogPageでのDB登録前の表示リスト
  List<String> _tempoDeleteList = <String>[];//削除タグリストをつくる一歩手前のStringリスト
  String _tempoInput;//TagInputChipに仮入力してるもの
  List<Chip> _displayChipList = <Chip>[];//CompareScreen表示用
  List<Chip> get displayChipList =>_displayChipList;
  List<Tag> _deleteTagList = <Tag>[];
  List<Tag> get deleteTagList => _deleteTagList;
  ///TagPageで使用
  List<Tag> _allTagList = <Tag>[];//TagPageでの表示用全タグリスト
  List<Tag> get allTagList => _tagList;
  List<Tag> _selectTagList = <Tag>[];//TagPage=>SelectTagPageへtagTitleで紐づいたタグリスト
  List<Tag> get selectTagList => _selectTagList;
  List<ComparisonOverview> _selectOverviews = <ComparisonOverview>[];
  List<ComparisonOverview> get selectOverviews => _selectOverviews;
  String selectTagTitle= '';
  TagChart updateTagChart;
//  List<String> idList=[];//ComparisonItemIdのリスト



  ListEditMode editStatus = ListEditMode.display;
  TagEditMode tagEditMode = TagEditMode.normal; //初期設定は通常モード
//  bool editFocus = false; //初期設定はタイトルのみ
  int selectedIndex;//tagPageでのListTile選択
  int selectedDescListIndex;//DescFromAndButtonでのListTIle選択
  bool isWay1MeritDeleteIcon =false;//AccordionPart=>DescFormのIconButton表示有無
  bool isWay1DemeritDeleteIcon =false;
  bool isWay2MeritDeleteIcon =false;
  bool isWay2DemeritDeleteIcon =false;
  bool isWay3MeritDeleteIcon =false;
  bool isWay3DemeritDeleteIcon =false;
  bool isWay1MeritFocusList = true;//settingPageでやったisReturnText
  bool isWay1DemeritFocusList = true;
  bool isWay2MeritFocusList = true;
  bool isWay2DemeritFocusList = true;
  bool isWay3MeritFocusList = true;
  bool isWay3DemeritFocusList = true;

  ///ListPage並び替え・削除モード
  List<String> deleteItemIdList = <String>[];
  List<DraggingItemData> draggedItems = <DraggingItemData>[];



  ///ページ開いた時の取得(notifyListeners(リビルド)あり)
  Future<void> getOverview(String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    way1Title = comparisonOverviews[0].way1Title;
    way2Title = comparisonOverviews[0].way2Title;
    notifyListeners();
  }

  ///FutureBuilder用(notifyListeners(リビルド)なし)
  //todo getSingle()に変更してすっきり書く
  Future<List<ComparisonOverview>> getWaitOverview(
      String comparisonItemId) async {
    _comparisonOverviews =
    await _compareRepository.getOverview(comparisonItemId);
    itemTitle = comparisonOverviews[0].itemTitle;
    way1Title = comparisonOverviews[0].way1Title;
    way2Title = comparisonOverviews[0].way2Title;
    _way1MeritEvaluate = comparisonOverviews[0].way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverviews[0].way1DemeritEvaluate;
    _way2MeritEvaluate = comparisonOverviews[0].way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverviews[0].way2DemeritEvaluate;
    _conclusionController.text = comparisonOverviews[0].conclusion;

    //todo way3Evaluate
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
  ///updateItem
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

  //todo way1,way2,way3入力
  ///AddScreen/InputPartでWay1Merit,Way2Meritリストを新規登録
  //way1Merit,way2Meritのリストを作って保存
  //todo list.add=>DB登録=>list空の流れではなく、
  // initWay1MeritをリストにしてcreateDescListに渡す方がすっきり書ける
  Future<void> createDesc(Way1Merit initWay1Merit,
      Way2Merit initWay2Merit, Way1Demerit initWay1Demerit,
      Way2Demerit initWay2Demerit,) async {
    _way1MeritList = [initWay1Merit];
    _way2MeritList = [initWay2Merit];
    //todo _way3MeritList = [initWay3Merit];
    _way1DemeritList = [initWay1Demerit];
    _way2DemeritList = [initWay2Demerit];
    //todo _way3DemeritList = [initWay3Demerit];

    //ここでaddしていくと古いものがだぶる
///既存のoverviewでway1リスト追加=>新規でoverview,way1リスト作成,DB登録=>既存のoverviewが重複して登録されてしまう
//    _way1MeritList.add(initWay1Merit);
//    print('compareViewModel/createDesc/way1MeritList.add$_way1MeritList');
//    _way2MeritList.add(initWay2Merit);
    //todo way3追加
    await _compareRepository.createDescList(
        _way1MeritList,_way2MeritList,_way1DemeritList,_way2DemeritList);
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
  Future<void> setWay1MeritNewValue(int newValue) async {
    _way1MeritEvaluate = newValue;
  }
  Future<void> setWay1DemeritNewValue(int newValue) async {
    _way1DemeritEvaluate = newValue;
  }
  Future<void> setWay2MeritNewValue(int newValue) async {
    _way2MeritEvaluate = newValue;
  }
  Future<void> setWay2DemeritNewValue(int newValue) async {
    _way2DemeritEvaluate = newValue;
  }
  Future<void> setWay3MeritNewValue(int newValue) async {
    _way3MeritEvaluate = newValue;
  }
  Future<void> setWay3DemeritNewValue(int newValue) async {
    _way3DemeritEvaluate = newValue;
  }
  Future<void> setConclusion(String newConclusion) async {
    conclusion = newConclusion;
  }


  ///DescFormAndButtonでList<Way1Merit>の入力変更があったとき
  Future<void> setChangeListDesc(
      ComparisonOverview comparisonOverview,
      DisplayList displayList,
      String newDesc, int index) async {
    print('setNewDesc!:$newDesc');

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
    switch(displayList){
      case DisplayList.way1Merit:
          ///変更行作成=>DB更新は変更した行のみ
          final changeWay1Merit = Way1Merit(
            way1MeritId: _way1MeritList[index].way1MeritId,
            comparisonItemId: _way1MeritList[index].comparisonItemId,
            way1MeritDesc: newDesc,
          );
          await _compareRepository.setWay1MeritDesc(changeWay1Merit, index);
          _way1MeritList = await _compareRepository.getWay1MeritList(
              comparisonOverview.comparisonItemId);
          break;
      case DisplayList.way2Merit:
          final changeWay2Merit = Way2Merit(
            way2MeritId: _way2MeritList[index].way2MeritId,
            comparisonItemId: _way2MeritList[index].comparisonItemId,
            way2MeritDesc: newDesc,
          );
          await _compareRepository.setWay2MeritDesc(changeWay2Merit, index);
          _way2MeritList = await _compareRepository.getWay2MeritList(
              comparisonOverview.comparisonItemId);
          break;
      case DisplayList.way1Demerit:
      ///変更行作成=>DB更新は変更した行のみ
        final changeWay1Demerit = Way1Demerit(
          way1DemeritId: _way1DemeritList[index].way1DemeritId,
          comparisonItemId: _way1DemeritList[index].comparisonItemId,
          way1DemeritDesc: newDesc,
        );
        await _compareRepository.setWay1DemeritDesc(changeWay1Demerit, index);
        _way1DemeritList = await _compareRepository.getWay1DemeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:
      ///変更行作成=>DB更新は変更した行のみ
        final changeWay2Demerit = Way2Demerit(
          way2DemeritId: _way2DemeritList[index].way2DemeritId,
          comparisonItemId: _way2DemeritList[index].comparisonItemId,
          way2DemeritDesc: newDesc,
        );
        await _compareRepository.setWay2DemeritDesc(changeWay2Demerit, index);
        _way2DemeritList = await _compareRepository.getWay2DemeritList(
            comparisonOverview.comparisonItemId);
        break;
        //todo way3入力
      case DisplayList.way3Merit:
        break;
      case DisplayList.way3Demerit:
        break;
    }

    notifyListeners();
  }

  ///DescFormAndButtonでリスト行追加
  Future<void> accordionAddList(ComparisonOverview comparisonOverview,
      DisplayList displayList) async {
    switch(displayList){
      case DisplayList.way1Merit:
            final initWay1Merit = Way1Merit(
              comparisonItemId: comparisonOverview.comparisonItemId,
              way1MeritDesc: '',
            );
            print('CompareViewModel/addWay1Merit/新規リスト追加前'
                '${_way1MeritList.map((
                way1Merit) => way1Merit.way1MeritDesc).toList()}');
            await _compareRepository.addWay1Merit(initWay1Merit);
            //1行DBへ追加した後、追加したもの含めて_way1MeritListに取得リスト格納してみる
            _way1MeritList = await _compareRepository.getWay1MeritList(
                comparisonOverview.comparisonItemId);
            print('CompareViewModel/addWay1Merit/新規リスト追加後'
                '${_way1MeritList.map((
                way1Merit) => way1Merit.way1MeritDesc).toList()}');
            break;
      case DisplayList.way2Merit:
            final initWay2Merit = Way2Merit(
              comparisonItemId: comparisonOverview.comparisonItemId,
              way2MeritDesc: '',
            );
            await _compareRepository.addWay2Merit(initWay2Merit);
            _way2MeritList = await _compareRepository.getWay2MeritList(
                comparisonOverview.comparisonItemId);
            break;
      case DisplayList.way1Demerit:
        final initWay1Demerit = Way1Demerit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way1DemeritDesc: '',
        );
        await _compareRepository.addWay1Demerit(initWay1Demerit);
        _way1DemeritList = await _compareRepository.getWay1DemeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:
        final initWay2Demerit = Way2Demerit(
          comparisonItemId: comparisonOverview.comparisonItemId,
          way2DemeritDesc: '',
        );
        await _compareRepository.addWay2Demerit(initWay2Demerit);
        _way2DemeritList = await _compareRepository.getWay2DemeritList(
            comparisonOverview.comparisonItemId);
        break;
        //todo way3入力
      case DisplayList.way3Merit:
      case DisplayList.way3Demerit:

    }
    notifyListeners();
  }

  ///DescFormAndButtonでリスト削除
  Future<void> accordionDeleteList(
      DisplayList displayList,
      int accordionIdIndex,
      ComparisonOverview comparisonOverview) async {
    switch(displayList){
      case DisplayList.way1Merit:
        final deleteWay1MeritId = _way1MeritList[accordionIdIndex].way1MeritId;
        await _compareRepository.deleteWay1Merit(deleteWay1MeritId);
        //再取得しないとDescFormAndButtonでのListViewの認識している長さと削除するindexが異なりエラー
        _way1MeritList = await _compareRepository.getWay1MeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Merit:
        final deleteWay2MeritId = _way2MeritList[accordionIdIndex].way2MeritId;
        await _compareRepository.deleteWay2Merit(deleteWay2MeritId);
        _way2MeritList = await _compareRepository.getWay2MeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way1Demerit:
        final deleteWay1DemeritId =
            _way1DemeritList[accordionIdIndex].way1DemeritId;
        await _compareRepository.deleteWay1Demerit(deleteWay1DemeritId);
        _way1DemeritList = await _compareRepository.getWay1DemeritList(
            comparisonOverview.comparisonItemId);
        break;
      case DisplayList.way2Demerit:
        final deleteWay2DemeritId =
            _way2DemeritList[accordionIdIndex].way2DemeritId;
        await _compareRepository.deleteWay2Demerit(deleteWay2DemeritId);
        _way2DemeritList = await _compareRepository.getWay2DemeritList(
            comparisonOverview.comparisonItemId);
        break;
    //todo way3入力
      case DisplayList.way3Merit:
      case DisplayList.way3Demerit:
    }

//    notifyListeners();
  }


  ///CompareScreenで表示されてる値を元にviewModelの値更新(ListPageに反映される)＆DB登録
  //todo favorite,way3追加
  Future<void> saveComparisonItem(ComparisonOverview updateOverview) async {
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
    //todo 自動更新の場合はキーボード完了ボタンを押したらonSelectTag
    await onSelectTag(selectTagTitle);

    notifyListeners();
  }

  ///データ保存後に再取得
  Future<void> getOverviewList() async {
    print('getOverviewList発動');
    _comparisonOverviews = await _compareRepository.getOverviewList();
    print('getOverviewList非同期終了');
    notifyListeners();
  }

  ///ListPageのFutureBuilder用
  Future<List<ComparisonOverview>> getList() async {
//    print('getList発動');
    _comparisonOverviews = await _compareRepository.getList();
//    print('getList非同期終了');
    return _comparisonOverviews;
  }

  //FutureBuilder用
  Future<List<ComparisonOverview>> isOverviewList() async {
    return _comparisonOverviews;
  }

  Future<void> changeEditStatus(ListEditMode editMode) async {
    if (editMode == ListEditMode.edit) {
      editStatus = ListEditMode.display;
      deleteItemIdList =[];
    } else {
      editStatus = ListEditMode.edit;

    }
    notifyListeners();
  }
  //ListPage単一行削除
  Future<void> deleteItem(String comparisonItemId) async {
    //削除
    await _compareRepository.deleteItem(comparisonItemId);
    //データ取得?
    notifyListeners();
  }

  //ListPage削除項目選択
  void checkDeleteIcon(String itemId) {
    ///1.Listにindexの値をupdateするメソッドがないので、map型に変換してupdateする
    ////asMap()するだけで{index:value}のMap型にできる=>map.update(index,(value)=>!value);
    ///2. comparisonItemIDをリストに追加・削除を行う
    if(deleteItemIdList.contains(itemId)){
      deleteItemIdList.remove(itemId);
      print('id削除後:$deleteItemIdList');
    }else{
      deleteItemIdList.add(itemId);
      print('id追加後:$deleteItemIdList');
    }
    notifyListeners();
  }

  //ListPage選択行削除
  Future<void> deleteItemList() async {
      _compareRepository.deleteItemList(deleteItemIdList);
     deleteItemIdList =[];
     ///NavBarで削除おしてもListView反映されない
      ///=>snapshot<List<DraggingItemData>>を変更しないと通知されない
      ///>comparisonOverviewsを変更するのに同時にgetOverviewListが必要
     await getOverviewList();
//    notifyListeners();
  }

  //ListPage編集時の並び替え可能なアイテムリスト変換
  //initStateの役割をここで行う
  Future<List<DraggingItemData>> getItemDataList() async {
    print('getItemDataList呼び出し');
    // FutureBuilder呼び出し毎にaddしていくとdraggedItemsが増えていってしまう
    draggedItems = <DraggingItemData>[];
    for (var i = 0; i < _comparisonOverviews.length; ++i) {
      final overView = _comparisonOverviews[i];
      draggedItems.add(DraggingItemData(
          title:overView.itemTitle,
          key:ValueKey(i),
          comparisonItemId:overView.comparisonItemId,
          orderId: i));
    }
    print('draggedItems順番：${draggedItems.map((e) => e.title)}');
    return draggedItems;
  }

  ///ListPage編集並び替え後のDBの順番入れ替え、まずdataIdで行ってみる
  Future<void> changeCompareListOrder(List<DraggingItemData> draggingItems)
  async{
    //draggingItemsをrepositoryにそのまま渡してcomparisonItemId順にdataIdを更新する
    await _compareRepository.changeCompareListOrder(
     _comparisonOverviews,draggingItems);
    // 順番変更登録後にreorderble_edit_listで使うdraggedItems更新必要
    // 並び替えてもcheckDeleteIcon=>getItemDataListで戻ってしまう
    ///_comparisonOverviewsを新たな順番で取得できてればOK
    _comparisonOverviews =await _compareRepository.getOverviewList();
  }

  //reorderbleStatelessで使用
  void dragItem(int draggingIndex, int newPositionIndex,
  DraggingItemData draggedItem) {
          debugPrint('Reordering $draggingIndex -> $newPositionIndex');
           draggedItems.removeAt(draggingIndex);
          draggedItems.insert(newPositionIndex, draggedItem);
      notifyListeners();
  }


  Future<void> backListPage() {
    notifyListeners();
  }

  //todo way3追加
  Future<void> setOverview(ComparisonOverview comparisonOverview) async {
    itemTitle = comparisonOverview.itemTitle;
    way1Title = comparisonOverview.way1Title;
    _way1MeritEvaluate = comparisonOverview.way1MeritEvaluate;
    _way1DemeritEvaluate = comparisonOverview.way1DemeritEvaluate;
    way2Title = comparisonOverview.way2Title;
    _way2MeritEvaluate = comparisonOverview.way2MeritEvaluate;
    _way2DemeritEvaluate = comparisonOverview.way2DemeritEvaluate;
    conclusion = comparisonOverview.conclusion;
    print('文頭のsetOverview/notifyListeners');
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
    //todo way3入力
    print('getWay1/Way2MeritList/notifyListeners');
    notifyListeners();
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
  //todo way3追加


 ///tagDialogPageでList<tag>を新規登録
  ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
  Future<void> createTag(ComparisonOverview comparisonOverview) async{
    //完了を押したらinput内容(List<String>)とcomparisonIdを基にList<Tag>クラスをDB登録
    //List<Tag>作成はDBでの重複削除リスト作成後にrepositoryで行う

    //表示用リストだったものを本登録
    ///TagDialogPageで完了ボタン押した時に入力中のタグも登録
    if(_tempoInput =='' || _tempoInput == null || _tempoInput == ' '){
    }else{
      _tempoDisplayList.add(_tempoInput);
    }
    print('viewModelのcreateTag時のtempoDisplayList:$_tempoDisplayList');

    await _compareRepository.createTag(
        _tempoDisplayList,comparisonOverview.comparisonItemId);
    ///タグを空にして完了おしてもTagがでてくるので追加
    _tempoDisplayList = [];
    ///残っているとtempoDisplayListにaddされ続けてしまう
    _tempoInput ='';
    //新規作成のときはnotifyListenersいらない？取得の時のみ？
  }


  ///TagDialogPageでの登録完了(createTag)前の表示用リスト
  //tagChipsでtextField入力内容をviewModelへset
  Future<void> setTempoDisplayList(List<String> tempoDisplayList)async{
    _tempoDisplayList = tempoDisplayList;
    //onSubmitted時にtempoDeleteListから重複しているタグを削除
    // (tempoDisplayListに上がっているものはtempoDeleteListから抜く)
    final tempoDisplaySet = _tempoDisplayList.toSet();//StringのSet
    final  tempoDeleteLabelsSet = _tempoDeleteList.toSet()//Stringのset
          ..removeAll(tempoDisplaySet);
    _tempoDeleteList = tempoDeleteLabelsSet.toList();
    ///  _tempoInputに文字が残っていると消したのにcreateTag時に _tempoDisplayListにaddされてしまう
    _tempoInput ='';
  }

  ///TagInputChipで仮入力したものをset
  void setTempoInput(String tempoInput ){
    if(tempoInput ==''){
    }else{
      _tempoInput= tempoInput;
    }
  }


 ///CompareScreenでのList<Tag>取得(文頭取得用)
  Future<void> getTagList(String comparisonItemId) async{
    _tagList = await _compareRepository.getTagList(comparisonItemId);
//    print('viewModel.getTagList:${_tagList.map((e) => e.tagTitle)}');
    //_tagNameListにもtagTitle格納
    _tagNameList = _tagList.map((tag)=>tag.tagTitle).toList();
    print('viewModel.getTagList/_tagNameList:$_tagNameList');
    //List<Tag>=>List<Chips>へ変更
    _displayChipList = _tagList.map((tag) {
      return Chip(
        label: Text(tag.tagTitle),
      );
    }).toList();

    //ここでSelectTaPage更新するとComPareScreenへ映る毎に読み込まれてしまうのでやめる
//    await onSelectTag(selectTagTitle);
    notifyListeners();
  }


  ///tagChipsで削除するTagを登録
  Future<void> createDeleteList(
      List<String> tempoDeleteLabels,) async{
    final joinList = [...tempoDeleteLabels,..._tagNameList];
//  final joinList= List<String>.from(tempoDeleteLabels)..addAll(_tagNameList);
    //削除する項目(tempoDeleteLabels)とDB登録してある項目(_tagNameList)を結合して
    ///重複のみを抜き出す（重複削除はset化してremoveAllすれば良いが、重複抜出はリスト結合&if文しかない）
    // ここではTag化せずにList<String>に留めておいて完了押(deleteTag)したらTag化する方向にもっていく
    print('viewModel.createDeleteList/joinList:$joinList');
    final lists =<String>[];
    joinList.map((title) {
      if(lists.contains(title)){
        _tempoDeleteList.add(title);
//        print('createDeleteList/_tempoDeleteList:$_tempoDeleteList');
      }else{
       lists.add(title);
//       print('delete以外のリスト：$lists');
      }
    }).toList();


  }
  ///tagDialogPageでList<tag>を削除
  Future<void>deleteTag(String comparisonItemId) async{
    //createDeleteListで作成したtempoDeleteListをList<Tag>化してDBへ渡す
//    print('deleteTagメソッドで消すtempoDeleteTagList:$_tempoDeleteList');
    _tempoDeleteList.map((title){
      final deleteTag = Tag(
        comparisonItemId: comparisonItemId,
        tagTitle: title,
      );
      deleteTagList.add(deleteTag);
    }).toList();
//    print('deleteTagメソッドで消すリスト:'
//        '${deleteTagList.map((e) => e.tagTitle).toList()}');
    await _compareRepository.deleteTag(deleteTagList);
    _tempoDeleteList = [];
   _deleteTagList = [];
  }

  ///TagPageのFutureBuilder用
  Future<List<TagChart>> getAllTagList() async {
    //ordrybyで登録時間順で取得
    _allTagList = await _compareRepository.getAllTagList();
    print('viewModel.getTagAllList:${_allTagList.map((e) => e.tagTitle)}');

    //TagPageを表示する手順
    ///方法1. List<Tag>の内容を全てList<TagChart>として取得して表示する:難
    ///重複タイトルを削除&重複タイトルのcomparisonItemIdをリスト化する
    ///List<Tag> => List<Map<String,dynamic>> =>同じタイトル数とそのidを抽出 =>List<TagChart>
      //List<Map<String, dynamic>>へ変換
//        final  allTagListMap = _allTagList.map((tag) => tag.toMap()).toList();
//        print('allTagList=>allTagListMap:$allTagListMap');

    ///方法2. List<Tag>から最低限必要なタイトルとアイテム数だけをList<TagChart>に格納して表示する:簡単
    final tagAllTitleList = <String>[];
    _allTagList.map((tag) {
     return tagAllTitleList.add(tag.tagTitle);
    }).toList();

    final tagSummary =<String, int>{};//Map<String,int>

    ///重複タイトルの数を数えてMap型に格納
    ///参照:https://www.fixes.pub/program/268895.html
    ///.where参照:https://qiita.com/dennougorilla/items/170deacf178891ced41e
    tagAllTitleList.toSet().toList().forEach(
            (st)=> tagSummary[st]=
            tagAllTitleList.where((i)=> i== st).length);
    ///Map<String,dynamic> =>List<TagChart>
    ///参考:https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    final tagChartList = <TagChart>[];
    tagSummary.forEach((key, amount) =>
        tagChartList.add(TagChart(
            tagTitle: key,
            tagAmount: amount,
            myFocusNode: FocusNode(),//タップした時focusする用に追加
        )));

//    print('tagSummary:$tagSummary');
//    print('tagChartList:$tagChartList');
    return tagChartList;
  }

  ///TagPage=>SelectTagPage
  Future<void> onSelectTag(String tagTitle) async{
    selectTagTitle = tagTitle;
    _selectOverviews =[];
    //tagTitleを元にList<Tag>を取得(更新順)
    // todo ListPage(_comparisonOverviews)とSelectListPage(_selectOverviews)のcreatedAtが異なることでリスト表示が違う
    //タグが追加された順になっている(一方で更新されたものほど上に来た方が使い勝手いいかも(ascでなくてdesc))
    _selectTagList =await _compareRepository.onSelectTag(tagTitle);
    print('viewModel/onSelectTag:${_selectTagList.map((e) => e.tagTitle)}');
    print('viewModel/onSelectTag:${_selectTagList.map((e) => e.createAtToString)}');
    //[Tag(),Tag(),Tag()]みたいなイメージ

   // Tag内のcomparisonItemIdを元にoverViewを取得しリスト化
    final idList = _selectTagList.map((tag) => tag.comparisonItemId).toList();


///forEach内の非同期処理でcomparisonIdからList<overview>取得
    ///参照:https://qiita.com/hisw/items/2df0052a400263d5863e
   await Future.forEach(idList, (String id) async{
           final selectOverView =
      await  _compareRepository.getComparisonOverview(id);
       _selectOverviews.add(selectOverView);
       print('Future.forEach/id:${_selectOverviews.map((e) =>e.comparisonItemId).toList()}');
    });
//    print('viewModel/onSelectTag/selectOverview:${_selectOverviews.map((overview) => overview.itemTitle)}');
    notifyListeners();
  }

  ///SelectTagPageのFutureBuilder用=>使わないので削除して良い
  Future<List<ComparisonOverview>> getSelectList(String tagTitle) async {
    _selectOverviews =[];
    _selectTagList = await _compareRepository.onSelectTag(tagTitle);
    final idList = _selectTagList.map((tag) => tag.comparisonItemId).toList();
    await Future.forEach(idList, (String id) async{
      final selectOverView =
      await  _compareRepository.getComparisonOverview(id);
      _selectOverviews.add(selectOverView);
    });
    return _selectOverviews;
  }

  ///onSelectTagを実施してSelectTagPageのSelectorを更新するだけのメソッド
  //TagDialogPageの完了ボタンで追加=>削除=>このメソッド=>読み込み(notifyListeners)するので
  //notifyListenersはなし
  Future<void> updateSelectTagPage() async{
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
    selectedIndex =null;
    notifyListeners();
  }

  void changeToTagDelete() {
    tagEditMode = TagEditMode.tagDelete;
    ///"完了"押した時に_selectedIndexをデフォルトに(次に編集押した時に前の選択状態にならないようにする)
    selectedIndex =null;
    notifyListeners();
  }
  void changeToNormal() {
    tagEditMode = TagEditMode.normal;
    notifyListeners();
  }

  //TagListでの通常モード(タイトル)<=>フォーカスモードの切替
  Future<void> changeEditFocus( int listNumber ) {
  selectedIndex = listNumber;
    notifyListeners();
//  selectedIndex =null;//ここでデフォルトにするとリストタップしても変更しなくなる
  }

  Future<void> onDeleteTag(String tagTitle) async{
    //tagTitleで紐づけて削除するのでcomparisonItemIdいらない
    //一応Tag形式にしてやりとりしてるが、tagTitleだけあれば削除可能(のはず)
    final deleteTag = Tag(tagTitle: tagTitle);
    await _compareRepository.onDeleteTag(deleteTag);
    //削除してtagPage更新
    selectedIndex =null;
    notifyListeners();
  }

  void unFocusTagPageList() {
    //考え方はchangeToNormalメソッドみたいな感じ
    selectedIndex =null;
    notifyListeners();
  }

  ///タグ名の編集時にタグ選択した時にcomparisonIdを取得する タグ名変えてもcreatedAtは更新しない
  //updateTagTitleと２こ１
  //todo getAllTagListの方法1でList<TagChart>内にcomparisonItemId格納できればこのメソッドいらない
  Future<void> getTagTitleId(String tagTitle) async{

    print('viewModel/getTagTitleId/tagTitle:$tagTitle');
    print('viewModel/getTagTitled/_selectTagList:Before:${_selectTagList.map((e) => e.tagTitle)}');
    //tagTitleからList<Tag>読取
    _selectTagList =await _compareRepository.onSelectTag(tagTitle);
    print('viewModel/getTagTitled/_selectTagList:${_selectTagList.map((e) => e.tagTitle)}');
  }

  ///タグ名編集画面でtextFieldに変更があればDBを更新
  Future<void>updateTagTitle(String newTagTitle) async{
    //タグが1つのcomparisonItemIdに複数ある場合があるので、comparisonItemId&tagIdで更新
    _selectTagList = _selectTagList.map((tag) {
      return Tag(
        comparisonItemId: tag.comparisonItemId,
        tagId: tag.tagId,
        tagTitle: newTagTitle,
        createdAt:tag.createdAt,
        createAtToString:tag.createAtToString,
      );
    }).toList();

    print('viewModel/updateTagTitle/_selectTagListのtitle:${_selectTagList.map((e) => e.tagTitle)}');
    print('/_selectTagListのcomparisonItemId:${_selectTagList.map((e) => e.comparisonItemId)}');
    print('_selectTagListのtagId:${_selectTagList.map((e) => e.tagId)}');

    await _compareRepository.updateTagTitle(_selectTagList,newTagTitle);

  }



  ///TagDialogPageのFutureBuilderで候補タグ格納(全タグから選択タグを削除)
  Future<List<String>> getCandidateTagList() async{
    //全タグリストから選択されたタグリストを比較して重複を削除
    _allTagList = await _compareRepository.getAllTagList();
    final candidateTitleSet = <String>{};
      _allTagList.map((tag) {
      return candidateTitleSet.add(tag.tagTitle);
    }).toSet();
    final choiceTitleSet=  <String>{};
      tagList.map((tag) {
      return choiceTitleSet.add(tag.tagTitle);
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

  //todo way3追加
  Future<void> updateItem(ComparisonOverview comparisonOverview) async{
    //compareScreenのSelectorまわすので入力
    itemTitle = _titleController.text;
    way1Title = _way1Controller.text;
    way2Title = _way2Controller.text;

    //引数はcomparisonItemIdしか使わず、テキスト入力はviewModelの値
        final updateOverview = ComparisonOverview(
      comparisonItemId:comparisonOverview.comparisonItemId,
      itemTitle: _titleController.text,
      way1Title: _way1Controller.text,
      way2Title: _way2Controller.text,
      createdAt: DateTime.now(),
    );
    await _compareRepository.updateComparisonOverView(updateOverview);
    await onSelectTag(selectTagTitle);
    notifyListeners();
    _titleController.clear();
    _way1Controller.clear();
    _way2Controller.clear();
  }

  //タイトル更新時(AddScreenMode.edit)、
  // inputPartの初期表示(CompareScreeのSelectorで表示されているものを表示)
  void setEditController(){
    _titleController.text = itemTitle;
    _way1Controller.text = way1Title;
    _way2Controller.text = way2Title;
  }

  //タイトル作成時(AddScreenMode.add)、
  // addScreenでの初期表示、cancelするときとDB登録したあと
  Future<void> itemControllerClear() async{
    _titleController.clear();
    _way1Controller.clear();
    _way2Controller.clear();
  }

  //AddScreenでのボタン押せる・押せないの判定のため、TextField入力に変更があったらnotifyListeners
  void itemTitleChanged (){
    notifyListeners();
  }

  //way1MeritListをtapしたら他のリストのTextFieldはTextに戻る
  void focusWay1MeritList() {
    isWay1MeritDeleteIcon  = true;
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
    isWay1DemeritDeleteIcon  = true;
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
    isWay2DemeritDeleteIcon  = true;
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
    isWay3MeritDeleteIcon  = true;
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
    isWay3DemeritDeleteIcon  = true;
    isWay3DemeritFocusList = true;
    //isWay3DemeritFocusList以外false
    isWay1MeritFocusList = false;
    isWay1DemeritFocusList = false;
    isWay2MeritFocusList = false;
    isWay2DemeritFocusList = false;
    isWay3MeritFocusList = false;
    notifyListeners();
  }









}
